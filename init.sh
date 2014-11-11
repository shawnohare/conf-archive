#!/bin/sh
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
echo Installing Homebrew and Cask
ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
echo running Brew/Caskfile to install packages
brew bundle Brewfile
brew bundle Caskfile

# install vim-plug
echo Installing vim-plug for plugin managing
mkdir -p ~/.vim/autoload
curl -fLo ~/.vim/autoload/plug.vim \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
