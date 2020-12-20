#!/bin/bash
# Most of this is taken from
# https://disconnected.systems/blog/archlinux-installer/#the-complete-installer-script

set -uo pipefail
trap 's=$?; echo "$0: Error on line "$LINENO": $BASH_COMMAND"; exit $s' ERR

# Set up initial mirrorlist, this can just be rough because we'll use reflector
# once we're booting
vim /etc/pacman.d/mirrorlist

# Collect some info
read -p "Enter hostname " hostname
read -p "Enter username " user
read -s -p "Enter user password " password
echo ""
read -s -p "Confirm user password " password2
echo ""

if [[ "$password" != "$password2" ]]; then
  echo "Passwords don't match!"
  exit 1
fi

# Choose which device to install on, this will erase the entire device and
# create two partitions:
# 1. UEFI boot (unencrypted)
# 2. Combined / and /home partition (encrypted)
#
# That second partition has three logical volumes:
# 1. 8G of swap
# 2. 32G for /
# 3. All the rest for /home
echo "Select install device (will erase everything!) "
devicelist=$(lsblk -dplnx size -o name | grep -Ev "boot|rpmb|loop" | tac)
select device in $devicelist; do
  break
done

timedatectl set-ntp true

# Partition device
parted -s $device mklabel gpt                # Make partition table
parted -s $device mkpart primary 1MiB 512MiB # Boot partition (UEFI, unencrypted)
parted -s $device mkpart primary 512MiB 100% # /root and /home partition (encrypted)
parted -s $device set 1 boot on              # Set boot flag on partition 1

# Create main encrypted filesystem
cryptsetup --type luks2 --verify-passphrase --pbkdf argon2id --iter-time 5000 --hash sha512 --key-size 512 luksFormat --label=arch_crypt_fs ${device}p2
cryptsetup --type luks2 open ${device}p2 arch_lvm
pvcreate --dataalignment 1m /dev/mapper/arch_lvm
vgcreate arch_vg /dev/mapper/arch_lvm
lvcreate -L 8G arch_vg -n swap
lvcreate -L 32G arch_vg -n root
lvcreate -l 100%FREE arch_vg -n home

# Create filesystems on volumes
mkswap /dev/mapper/arch_vg-swap
mkfs.ext4 /dev/mapper/arch_vg-root
mkfs.ext4 /dev/mapper/arch_vg-home

# Create initial file structure
swapon /dev/mapper/arch_vg-swap
mount /dev/mapper/arch_vg-root /mnt
mkdir /mnt/home
mount /dev/mapper/arch_vg-home /mnt/home

# Create and mount boot filesystem
# We do this after mounting / because otherwise /boot gets overwritten
mkfs.fat -F32 ${device}p1
mkdir /mnt/boot
mount ${device}p1 /mnt/boot

# Set up initial packages and system fstab
pacstrap -i /mnt base base-devel linux linux-firmware lvm2 neovim 
genfstab -U -p /mnt >> /mnt/etc/fstab
echo "${hostname}" > /mnt/etc/hostname

# Configure locale
ln -sf /mnt/usr/share/zoneinfo/US/Central /mnt/etc/localtime
echo "LANG=en_US.UTF-8" > /mnt/etc/locale.conf

cat <<EOF > /mnt/etc/hosts
127.0.0.1        localhost.localdomain         localhost
::1              localhost.localdomain         localhost
127.0.1.1        $hostname.localdomain         $hostname
EOF

# Create initial user
arch-chroot /mnt useradd -mU -G wheel,video,audio,storage,input "$user"
arch-chroot /mnt hwclock --systohc

# Set HOOKS in mkinitcpio.conf to work with lvm
sed -i "s/^HOOKS=.*$/HOOKS=(base udev autodetect modconf block keyboard encrypt lvm2 filesystems fsck)/g" /mnt/etc/mkinitcpio.conf
arch-chroot /mnt mkinitcpio -p linux
arch-chroot /mnt bootctl --path=/boot install
arch-chroot /mnt hwclock --systohc

# Configure bootloader
echo -e "default arch.conf\ntimeout 5\neditor 0" > /mnt/boot/loader/loader.conf
echo -e "title\tArch Linux\nlinux\t/vmlinuz-linux\n" > /mnt/boot/loader/entries/arch.conf

# Depending on who made this CPU, install vendor specific microcode
echo "which vendor is this computer?"
select vendor in intel amd other; do
  break
done

if [[ "$vendor" == "intel" ]]; then
  echo -e "initrd\t/intel-ucode.img\n" >> /mnt/boot/loader/entries/arch.conf
  arch-chroot /mnt pacman -S intel-ucode
elif [[ "$vendor" == "amd" ]]; then
  echo -e "initrd\t/amd-ucode.img\n" >> /mnt/boot/loader/entries/arch.conf
  arch-chroot /mnt pacman -S amd-ucode
fi

echo -e "initrd\t/initramfs-linux.img\noptions\tcryptdevice=LABEL=arch_crypt_fs:arch_vg root=/dev/mapper/arch_vg-root rw" >> /mnt/boot/loader/entries/arch.conf

echo "$user:$password" | chpasswd --root /mnt
echo "root:$password" | chpasswd --root /mnt
 
EDITOR=nvim arch-chroot /mnt visudo

# Essential packages
# iw is for wireless
# dhcpcd is for dhcp
# ufw is for firewall
# tmux is for t mux ing
arch-chroot /mnt pacman -S iw dhcpcd ufw tmux
arch-chroot /mnt systemctl enable dhcpcd.service

cat <<EOF
When you're ready to boot, type:
$ umount -R /mnt
$ reboot
EOF
