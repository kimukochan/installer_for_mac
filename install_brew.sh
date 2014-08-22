#!/bin/sh
#
# Install in brew 
#

# rbenv
# ----------------------------
RUBY_VERSION='2.1.2'

brew install rbenv ruby-build

echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
source ~/.bash_profile 

rbenv install $RUBY_VERSION
rbenv rehash
rbenv global $RUBY_VERSION


# run gem
# ----------------------------
gem install bundler
gem install rails
rbenv rehash

