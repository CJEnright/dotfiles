#!/bin/bash

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Make directories we'll need
mkdir ~/.config

# vim
mkdir ~/.vim
mkdir ~/.vim/plugged
ln -fs ${BASEDIR}/vimrc ~/.vim/vimrc

# zsh
ln -fs ${BASEDIR}/zshrc ~/.zshrc

# tmux
ln -fs ${BASEDIR}/tmux.conf ~/.tmux.conf

# git
ln -fs ${BASEDIR}/gitconfig ~/.gitconfig
ln -fs ${BASEDIR}/gitignore_global ~/.gitignore_global

# karabiner
mkdir ~/.config/karabiner
ln -fs ${BASEDIR}/karabiner.json ~/.config/karabiner/karabiner.json

# hammerspoon
mkdir ~/.hammerspoon
ln -fs ${BASEDIR}/hammerspoon/init.lua ~/.hammerspoon/init.lua

# Ledger
mkdir ~/.ledger
ln -fs ${BASEDIR}/ledgerrc ~/.ledgerrc
