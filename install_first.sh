#!/bin/sh
#
# Install first
#

# xcode
# -------------------------
xcode-select --install


# Homebrew 
# -------------------------
ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"

echo 'export PATH=/usr/local/bin:$PATH' >> ~/.bash_profile
source ~/.bash_profile

brew doctor

brew update

brew upgrade


# brew-cask
# -------------------------
brew install caskroom/cask/brew-cask

