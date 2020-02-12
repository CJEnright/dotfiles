#!/usr/bin/env bash

echo 'Installing  xcode'
xcode-select --install

if test ! `which brew`; then
  echo 'Installing  homebrew'
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo 'Updating    homebrew'
brew update

echo 'Installing  Brewfile'
brew bundle

echo 'Cleaning    Up brew s mess'
brew cleanup

echo 'Installing  dotfiles'
./install.sh


echo 'Enabling    dock auto hide'
defaults write com.apple.dock autohide -bool true

echo 'Setting     show dock animation to be faster'
defaults write com.apple.dock autohide-time-modifier -float 0.3

echo 'Disabling   show dock delay'
defaults write com.apple.dock autohide-delay -float 0

echo 'Setting     dock icon size to 45 pixels'
defaults write com.apple.dock tilesize -int 45

echo 'Enabling    sub pixel font rendering on non-Apple LCDs'
defaults write NSGlobalDomain AppleFontSmoothing -int 2

echo 'Disabling   "Are you sure you want to open this application?" dialog'
defaults write com.apple.LaunchServices LSQuarantine -bool false

echo 'Enabling    full keyboard access for all controls (e.g. tab in modals)'
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

echo 'Enabling    key repeat instead of press and hold alternatives'
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

echo 'Enabling    faster key repeating'
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

echo 'Enabling    tap to click'
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

echo 'Disabling   "natural" scrolling'
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

echo 'Disabling   dictionary lookup on Command-Ctrl-D'
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 70 '<dict><key>enabled</key><false/></dict>'

echo 'Enabling    require password immediately after entering sleep'
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

echo 'Enabling    showing all file extensions'
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

echo 'Disabling   warning for changing file extension'
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

echo 'Enabling    full path in finder title'
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

echo 'Enabling    showing folders first when sorting by name'
defaults write com.apple.finder _FXSortFoldersFirst -bool true

echo 'Enabling    searching current folder by default'
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

echo 'Setting     copying email addresses in mail.app to be normal (foo@email.com instead of Foo Bar <foo@email.com>)'
defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false

echo 'Disabling   Time Machine asking if every new drive should be used for backups'
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

echo 'Enabling    faster wake up times by extending delay until entering standby'
sudo pmset -a standbydelay 86400

echo 'Enabling    dev tools in Safari'
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -bool true

killall Dock
killall Finder

echo ''
echo 'You should restart your computer now'
