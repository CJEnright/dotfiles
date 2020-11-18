#!/bin/sh

# We're only going to install on a single disk. This should be the path to that
# disk, which you can find using `lsblk`
DISK=$1

# Show all commands with a + in front
set -x
# Exit on first failure
set -e

read -p "Set up Wi-Fi? [y/n] " do_wifi
if [ $do_wifi == "y" ]; then
  read -p "Enter network SSID: " ssid
  read -p "Enter network password: " password
  wpa_passphrase $ssid $password >> /etc/wpa_supplicant.conf
  systemctl start wpa_supplicant
fi

echo "Format and partition ${DISK}?"
echo "This will erase everything on the disk!"
read -p "[y/n] " do_format
if [ $do_format == "y" ]; then
  # Partition disk
  parted -s $DISK mklabel gpt                # Make partition table
  parted -s $DISK mkpart primary 1MiB 512MiB # Boot partition (UEFI, unencrypted)
  parted -s $DISK mkpart primary 512MiB 100% # /root and /home partition (encrypted)
  parted -s $DISK set 1 boot on              # Set boot flag on partition 1

  # Create main encrypted filesystem
  cryptsetup --type luks2 --verify-passphrase --pbkdf argon2id --iter-time 5000 --hash sha512 --key-size 512 luksFormat ${DISK}p2
  cryptsetup --type luks2 open ${DISK}p2 nix_lvm
  pvcreate --dataalignment 1m /dev/mapper/nix_lvm
  vgcreate nix_vg /dev/mapper/nix_lvm
  lvcreate -L 8G nix_vg -n swap
  lvcreate -L 32G nix_vg -n root
  lvcreate -l 100%FREE nix_vg -n home

  mkswap /dev/mapper/nix_vg-swap
  mkfs.ext4 /dev/mapper/nix_vg-root
  mkfs.ext4 /dev/mapper/nix_vg-home

  swapon /dev/mapper/nix_vg-swap
  mount /dev/mapper/nix_vg-root /mnt
  mkdir /mnt/home
  mount /dev/mapper/nix_vg-home /mnt/home

  # Create and mount boot filesystem
  # We do this after mounting / because otherwise /boot gets overwritten
  mkfs.fat -F32 ${DISK}p1
  mkdir /mnt/boot
  mount ${DISK}p1 /mnt/boot
fi

# Make sure we have git installed
nix-env -i git

git -C / clone https://github.com/cjenright/dotfiles
select machine in /dotfiles/nixos/machines/*/; do break; done

# Copy configuration.nix
cp "${machine}/configuration.nix" /mnt/etc/nixos/configuration.nix

# Copy hardware_configuration.nix if it exists
if [ -e "${machine}/hardware_configuration.nix" ]; then
  cp "${machine}/hardware_configuration.nix" /mnt/etc/nixos/hardware_configuration.nix
else
  # Have nix generate configs, note that this won't overwrite our
  # configuration.nix file from the command above. We only do this so nix will
  # generate a hardware_configuration.nix file.
  nixos-generate-config --root /mnt
fi

# Copy in common nix files
cp /dotfiles/nixos/common /mnt/etc/nixos/common

# Once you boot into your user account make sure to symlink these files using
# scripts/install_nix.sh

nixos-install
