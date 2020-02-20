#!/bin/bash

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Make directories we'll need
mkdir ~/.config

# alacritty
ln -fs ${BASEDIR}/alacritty ~/.config/alacritty

# vim
ln -fs ${BASEDIR}/vim ~/.vim

# neovim
ln -fs ${BASEDIR}/nvim ~/.config/nvim

# zsh
ln -fs ${BASEDIR}/zshrc ~/.zshrc

# tmux
ln -fs ${BASEDIR}/tmux.conf ~/.tmux.conf

# git
ln -fs ${BASEDIR}/gitconfig ~/.gitconfig
ln -fs ${BASEDIR}/gitignore_global ~/.gitignore_global

# karabiner
mkdir -p ~/.config/karabiner
ln -fs ${BASEDIR}/karabiner.json ~/.config/karabiner/karabiner.json

# hammerspoon
mkdir -p ~/.hammerspoon
ln -fs ${BASEDIR}/hammerspoon/init.lua ~/.hammerspoon/init.lua

# Mail stuff
ln -fs ${BASEDIR}/offlineimaprc ~/.offlineimaprc
mkdir -p ~/.mutt
ln -fs ${BASEDIR}/mutt ~/
