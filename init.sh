#!/bin/sh
# TODO handle dot files separately.  Consider hosting on Github?
# Execute a remote script:
# curl -s http://server/path/script.sh | bash /dev/stdin arg1 arg2
cd ~
echo Install all AppStore Apps at first!
# no solution to automate AppStore installs
# Some apps to install:
# Xcode
# Goban
# Caffeine
read -p "Press any key to continue... " -n1 -s
echo  '\n'

# install xcode cl tools
xcode-select --install

# install Homebrew and Cask
echo Installing Homebrew
ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
brew bundle Brewfile
brew bundle Caskfile
