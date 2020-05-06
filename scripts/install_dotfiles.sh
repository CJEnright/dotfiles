#!/bin/sh

# Installs dotfiles.

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../"

# Make directories we'll need later
mkdir -p ~/.config
mkdir -p ~/.mutt

# Takes two arguments: $1 = source, $2 = destination
#
# Tries to install a folder at a location via symlink.  If the destination
# already exists it'll prompt to delete it. We do this because otherwise ln
# creates a symlink to the symlink in the symlink and then you've got an
# infinite loop for stupid programs (like ctags I think).
function try_install {
  if test -f $2; then
    echo "$2 is already a directory, want to remove it? [y]/[n]"
    read -p yn
    if "$yn" = 'y'; then
      rm -r $2
      ln -fs $1 $2
    fi
  else 
    rm $2 2> /dev/null
    ln -fs $1 $2
  fi
}

# macOS specific dotfiles
if [ "$(uname)" == "Darwin" ]; then
  # karabiner
  mkdir -p ~/.config/karabiner
  ln -fs ${BASEDIR}/karabiner.json ~/.config/karabiner/karabiner.json

  # hammerspoon
  mkdir -p ~/.hammerspoon
  ln -fs ${BASEDIR}/hammerspoon/init.lua ~/.hammerspoon/init.lua
fi

# alacritty
ALACRITTY_SOURCE=${BASEDIR}/alacritty
ALACRITTY_TARGET=~/.config/alacritty
try_install $ALACRITTY_SOURCE $ALACRITTY_TARGET

# vim
VIM_SOURCE=${BASEDIR}/vim
VIM_TARGET=~/.vim
try_install $VIM_SOURCE $VIM_TARGET

# neovim
NVIM_SOURCE=${BASEDIR}/nvim
NVIM_TARGET=~/.config/nvim
try_install $NVIM_SOURCE $NVIM_TARGET

# zsh
ln -fs ${BASEDIR}/zshrc ~/.zshrc

# tmux
ln -fs ${BASEDIR}/tmux.conf ~/.tmux.conf

# git
ln -fs ${BASEDIR}/gitconfig ~/.gitconfig
ln -fs ${BASEDIR}/gitignore_global ~/.gitignore_global

# Mail stuff
ln -fs ${BASEDIR}/offlineimaprc ~/.offlineimaprc

MUTT_SOURCE=${BASEDIR}/mutt
MUTT_TARGET=~/.mutt
try_install $MUTT_SOURCE $MUTT_TARGET
