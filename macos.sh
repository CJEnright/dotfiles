#!/usr/bin/env bash

echo 'Enabling   dock auto hide'
defaults write com.apple.dock autohide -bool true

echo 'Setting    show dock animation to be faster'
defaults write com.apple.dock autohide-time-modifier -float 0.3

echo 'Disabling  show dock delay'
defaults write com.apple.dock autohide-delay -float 0

echo 'Setting    dock icon size to 45 pixles'
defaults write com.apple.dock tilesize -int 45

echo 'Disabling  "Are you sure you want to open this application?" dialog'
defaults write com.apple.LaunchServices LSQuarantine -bool false

echo 'Enabling   full keyboard access for all controls (e.g. tab in modals)'
defaults write NSGlobalDomain AppleKeyboardUIMode 3

echo 'Enabling   key repeat instead of press and hold alternatives'
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

echo 'Enabling   faster key repeating'
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

echo 'Enabling   tap to click'
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

echo 'Disabling  "natural" scrolling'
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

echo 'Disabling  dictionary lookup on Command-Ctrl-D'
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 70 '<dict><key>enabled</key><false/></dict>'

echo 'Enabling   require password immediately after entering sleep'
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

echo 'Enabling   showing all file extensions'
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

echo 'Disabling  warning for changing file extension'
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

echo 'Enabling   full path in finder title'
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

echo 'Enabling   showing folders first when sorting by name'
defaults write com.apple.finder _FXSortFoldersFirst -bool true

echo 'Enabling   searching current folder by default'
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

killall Dock
killall Finder

echo ''
echo 'You should restart your computer now'
