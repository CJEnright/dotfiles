#!/bin/bash

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Make directories we'll need
mkdir -p ~/.config
mkdir -p ~/.mutt

# alacritty
ALACRITTY_SOURCE=${BASEDIR}/alacritty
ALACRITTY_TARGET=~/.config/alacritty
if test -f "$ALACRITTY_TARGET"; then
  echo "$ALACRITTY_TARGET is already a directory, want to remove it? [y]/[n]"
  read -p yn
  if "$yn" = 'y'; then
    rm -r "$ALACRITTY_TARGET"
    ln -fs $ALACRITTY_SOURCE $ALACRITTY_TARGET
  fi
else 
  rm "$ALACRITTY_TARGET" 2> /dev/null
  ln -fs $ALACRITTY_SOURCE $ALACRITTY_TARGET
fi

# vim
VIM_SOURCE=${BASEDIR}/vim
VIM_TARGET=~/.vim
if test -f "$VIM_TARGET"; then
  echo "$VIM_TARGET is already a directory, want to remove it? [y]/[n]"
  read -p yn
  if "$yn" = 'y'; then
    rm -r "$VIM_TARGET"
    ln -fs $VIM_SOURCE $VIM_TARGET
  fi
else 
  rm "$VIM_TARGET" 2> /dev/null
  ln -fs $VIM_SOURCE $VIM_TARGET
fi

# neovim
NVIM_SOURCE=${BASEDIR}/nvim
NVIM_TARGET=~/.config/nvim
if test -f "$NVIM_TARGET"; then
  echo -r "$NVIM_TARGET is already a directory, want to remove it? [y]/[n]"
  read -p yn
  if "$yn" = 'y'; then
    rm -r "$NVIM_TARGET"
    ln -fs $NVIM_SOURCE $VIM_TARGET
  fi
else 
  rm "$NVIM_TARGET" 2> /dev/null
  ln -fs $NVIM_SOURCE $NVIM_TARGET
fi

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

MUTT_SOURCE=${BASEDIR}/mutt
MUTT_TARGET=~/.mutt
if test -f "$MUTT_TARGET"; then
  echo -r "$MUTT_TARGET is already a directory, want to remove it? [y]/[n]"
  read -p yn
  if "$yn" = 'y'; then
    rm -r "$MUTT_TARGET"
    ln -fs $MUTT_SOURCE $MUTT_TARGET
  fi
else 
  rm "$MUTT_TARGET" 2> /dev/null
  ln -fs $MUTT_SOURCE $MUTT_TARGET
fi
