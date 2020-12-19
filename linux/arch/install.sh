#!/bin/bash
# Most of this is taken from
# https://disconnected.systems/blog/archlinux-installer/#the-complete-installer-script

set -uo pipefail
trap 's=$?; echo "$0: Error on line "$LINENO": $BASH_COMMAND"; exit $s' ERR

user=$(dialog --stdout --inputbox "Enter admin username" 0 0) || exit 1
clear
: ${user:?"user cannot be empty"}

password=$(dialog --stdout --passwordbox "Enter admin password" 0 0) || exit 1
clear
: ${password:?"password cannot be empty"}
password2=$(dialog --stdout --passwordbox "Enter admin password again" 0 0) || exit 1
clear
[[ "$password" == "$password2" ]] || ( echo "Passwords did not match"; exit 1; )

devicelist=$(lsblk -dplnx size -o name,size | grep -Ev "boot|rpmb|loop" | tac)
device=$(dialog --stdout --menu "Select installation disk" 0 0 0 ${devicelist}) || exit 1
clear

timedatectl set-ntp true

# Partition device
parted -s $device mklabel gpt                # Make partition table
parted -s $device mkpart primary 1MiB 512MiB # Boot partition (UEFI, unencrypted)
parted -s $device mkpart primary 512MiB 100% # /root and /home partition (encrypted)
parted -s $device set 1 boot on              # Set boot flag on partition 1

# Create main encrypted filesystem
cryptsetup --type luks2 --verify-passphrase --pbkdf argon2id --iter-time 5000 --hash sha512 --key-size 512 luksFormat ${device}p2
cryptsetup --type luks2 open ${device}p2 arch_lvm
pvcreate --dataalignment 1m /dev/mapper/arch_lvm
vgcreate arch_vg /dev/mapper/arch_lvm
lvcreate -L 8G arch_vg -n swap
lvcreate -L 32G arch_vg -n root
lvcreate -l 100%FREE arch_vg -n home

mkswap /dev/mapper/arch_vg-swap
mkfs.ext4 /dev/mapper/arch_vg-root
mkfs.ext4 /dev/mapper/arch_vg-home

swapon /dev/mapper/arch_vg-swap
mount /dev/mapper/arch_vg-root /mnt
mkdir /mnt/home
mount /dev/mapper/arch_vg-home /mnt/home

# Create and mount boot filesystem
# We do this after mounting / because otherwise /boot gets overwritten
mkfs.fat -F32 ${device}p1
mkdir /mnt/boot
mount ${device}p1 /mnt/boot

pacstrap -i /mnt base linux linux-firmware lvm2 nvim 
genfstab -U -p /mnt >> /mnt/etc/fstab
echo "${hostname}" > /mnt/etc/hostname

ln -sf /mnt/usr/share/zoneinfo/US/Central /mnt/etc/localtime
echo "LANG=en_US.UTF-8" > /mnt/etc/locale.conf

echo <<EOF > /mnt/etc/hosts
127.0.0.1        localhost.localdomain         localhost
::1              localhost.localdomain         localhost
127.0.1.1        $hostname.localdomain         $hostname
EOF

arch-chroot /mnt useradd -mU -s /usr/bin/zsh -G wheel,video,audio,storage,input "$user"
arch-chroot /mnt hwclock --systohc

vim /etc/mkinitcpio.conf
mkinitcpio -p linux
arch-chroot /mnt bootctl --path=/boot install
arch-chroot /mnt hwclock --systohc

echo <<EOF > /mnt/boot/loader/loader.conf
default arch.conf
timeout 5
editor  0
EOF 

echo <<EOF > /mnt/boot/loader/entries/arch.conf
title\tArch Linux
linux\t/vmlinuz-linux
# TODO uncomment one of these based on your system
# Whichever it is, make sure to also run
# `arch-chroot /mnt pacman -S ***-ucode`
#initrd\t/intel-ucode.img
#initrd\t/amd-ucode.img
initrd\t/initramfs-linux.img
options\tcryptdevice=LABEL=arch_crypt_fs:archvg root=/dev/mapper/archvg-root rw
EOF

vim /mnt/boot/loader/entries/arch.conf

pacman -S iw dhcpcd

exit
umount -R /mnt
reboot
