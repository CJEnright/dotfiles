#!/bin/sh

EFI_PART=$1
FS_PART=$2

cryptsetup -y -v luksFormat --label=arch_crypt_fs $FS_PART
cryptsetup open --type luks2 $FS_PART archlvm
pvcreate --dataalignment 1m /dev/mapper/archlvm
vgcreate archvg /dev/mapper/archlvm
lvcreate -L 8G archvg -n swap
lvcreate -L 32G archvg -n root
lvcreate -l 100%FREE archvg -n home

mkfs.ext4 /dev/mapper/archvg-root
mkfs.ext4 /dev/mapper/archvg-home
mkswap /dev/mapper/archvg-swap
mount /dev/mapper/archvg-root /mnt
mkdir /mnt/home
mount /dev/mapper/archvg-home /mnt/home
swapon /dev/mapper/archvg-swap

mkfs.fat -F32 $2
mkdir /mnt/boot
mount $EFI_PART /mnt/boot

mkdir /mnt/etc
genfstab -U -p /mnt >> /mnt/etc/fstab

vi /etc/pacman.d/mirrorlist
timedatectl set-ntp true
pacstrap -i /mnt base base-devel vim intel-ucode linux lvm2

arch-chroot /mnt
timedatectl set-ntp true
ln -sf /usr/share/zoneinfo/US/Central /etc/localtime
vim /etc/locale.gen
locale-gen
locale > /etc/locale.conf

passwd

vim /etc/hostname

echo -e "127.0.0.1        localhost.localdomain         localhost\n::1              localhost.localdomain         localhost\n127.0.1.1        <YOUR_HOST_NAME>.localdomain  <YOUR_HOST_NAME>" >> /etc/hosts
vim /etc/hosts

hwclock --systohc

vim /etc/mkinitcpio.conf
mkinitcpio -p linux
bootctl --path=/boot install
echo -e "default arch.conf\ntimeout 5\neditor 0" > /boot/loader/loader.conf
echo -e "title\tArch Linux\nlinux\t/vmlinuz-linux\ninitrd\t/intel-ucode.img\ninitrd\t/initramfs-linux.img\noptions\tcryptdevice=LABEL=arch_crypt_fs:archvg root=/dev/mapper/archvg-root rw" > /boot/loader/entries/arch.conf
pacman -S intel-ucode
pacman -S nvidia
pacman -S iw dhcpcd

exit
umount -R /mnt
shutdown now
