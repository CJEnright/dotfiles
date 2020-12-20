#!/bin/sh

# Install yay
sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

# Set systemd-boot to auto-update
su
mkdir -p /etc/pacman.d/hooks/
cat <<EOF > /etc/pacman.d/hooks/100-systemd-boot.hook
[Trigger]
Type = Package
Operation = Upgrade
Target = systemd

[Action]
Description = Updating systemd-boot
When = PostTransaction
Exec = /usr/bin/bootctl update
EOF

# Help out SSDs
sed -i "s/^.*issue_discards = 0$/\tissue_discards = 1/g" /mnt/etc/lvm/lvm.conf
systemctl enable fstrim.timer
sed -i "$d" /boot/loader/entries/arch.conf # Deletes last line of file
echo -e "initrd\t/initramfs-linux.img\noptions\tcryptdevice=LABEL=arch_crypt_fs:arch_vg:allow-discards root=/dev/mapper/arch_vg-root rw rd.luks.options=discard" > /boot/loader/entries/arch.conf

# Add any login settings you like, I add:
# `auth optional pam_faildelay.so delay=3000000`
nvim /etc/pam.d/system-login

# Set up firewalls
ufw enable
systemctl enable ufw.service
ufw default reject
ufw limit ssh

# Get a better mirror list
pacman -S reflector
reflector -c "United States" -p http --sort rate --save /etc/pacman.d/mirrorlist
