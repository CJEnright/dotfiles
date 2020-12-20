#!/bin/sh

# Set up desktop environment
cd /usr/src
git clone git://git.suckless.org/dwm
git clone git://git.suckless.org/dmenu

cd dwm
sudo make clean install
cd dmenu
sudo make clean install

echo "exec dwm" > /home/cj/.xinitrc
