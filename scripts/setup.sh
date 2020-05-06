#!/bin/bash

# Run this file when you're first setting up a system.

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo 'Installing  dotfiles'
${BASEDIR}/install_dotfiles.sh

if [ "$(uname)" == "Darwin" ]; then

  echo 'Installing  xcode'
  xcode-select --install

  if test ! `which brew`; then
    echo 'Installing  homebrew'
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi

  echo 'Updating    homebrew'
  brew update

  echo 'Installing  packages from Brewfile'
  brew bundle

  echo 'Cleaning    Up brews mess'
  brew cleanup

  ${BASEDIR}/macos_settings.sh
#elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
fi
