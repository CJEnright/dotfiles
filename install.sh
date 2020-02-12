#!/bin/bash

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Make directories we'll need
mkdir ~/.config

# vim
ln -fs ${BASEDIR}/vim ~/.vim

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
