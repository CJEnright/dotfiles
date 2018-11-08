#!/bin/bash

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Make directories we'll need
mkdir ~/.config

# vim
mkdir ~/.vim
ln -s ${BASEDIR}/vimrc ~/.vim/vimrc

# zsh
ln -s ${BASEDIR}/zshrc ~/.zshrc

# tmux
ln -s ${BASEDIR}/tmux.conf ~/.tmux.conf

# git
ln -s ${BASEDIR}/gitconfig ~/.gitconfig
ln -s ${BASEDIR}/gitignore_global ~/.gitignore_global

# karabiner
mkdir ~/.config/karabiner
ln -s ${BASEDIR}/karabiner.json ~/.config/karabiner/karabiner.json

# hammerspoon
mkdir ~/.hammerspoon
ln -s ${BASEDIR}/init.lua ~/.hammerspoon/init.lua

