#!/bin/sh

mkdir -p /etc/pacman.d/hooks/
echo -e "[Trigger]\nType = Package\nOperation = Upgrade\nTarget = systemd\n\n[Action]\nDescription = Updating systemd-boot\nWhen = PostTransaction\nExec = /usr/bin/bootctl update" > /etc/pacman.d/hooks/100-systemd-boot.hook

useradd --create-home cj
passwd cj
usermod -aG wheel cj
EDITOR=vim visudo

systemctl enable fstrim.timer
vim /etc/lvm/lvm.conf
vim /boot/loader/entries/arch.conf

vim /etc/pam.d/system-login

systemctl enable dhcpcd.service

pacman -S ufw reflector xorg xorg-init git tmux

ufw enable
systemctl enable ufw.service
ufw default reject
ufw limit ssh

reflector -c "United States" -p http --sort rate --save /etc/pacman.d/mirrorlist

cd /usr/src
git clone git://git.suckless.org/dwm
git clone git://git.suckless.org/st
git clone git://git.suckless.org/dmenu

cd dwm
sudo make clean install
cd st
sudo make clean install
cd dmenu
sudo make clean install

echo "exec dwm" > /home/cj/.xinitrc
