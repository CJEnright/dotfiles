#!/bin/sh

# Install packages
yay -S --needed - < ./packages.txt

# Use zsh
chsh -s /usr/bin/zsh

# Set up desktop environment
cd /usr/src
sudo git clone git://git.suckless.org/dwm
sudo git clone git://git.suckless.org/dmenu

cd dwm
sudo make clean install
cd ..
cd dmenu
sudo make clean install

echo "exec dwm" > /home/cj/.xinitrc

# Install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Set up ssh
