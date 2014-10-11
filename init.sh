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
brew update
brew tap homebrew/science  # for things like R
# Dev tools
brew install wget
brew install git
brew install zsh
brew install zsh-syntax-highlighting
brew install tmux
brew install vim  # updates vim
brew install emacs  # updates emacs
# brew install heroku-toolbelt
# languages
brew install R
brew install pyenv
brew install sbt  # might get an error.  Google for fix and then document
brew install node
# database
brew install mysql
brew install mongo
brew install redis

################################### 
#  APPS TO INSTALL VIA CASK
###################################
echo Installing Homebrew Cask
brew install caskroom/cask/brew-cask
brew tap caskroom/versions  # to install alt versions 
echo Installing core apps
brew cask install --appdir="~/Applications" spectacle  # window management
brew cask install --appdir="~/Applications" iterm2
# brew cask install --appdir="/Applications" alfred  # workflow
brew cask install --appdir="/Applications" little-snitch
# Development
echo Install Dev Apps
brew cask install --appdir="/Applications" cakebrew  # gui for homebrew
brew cask install --appdir="~/Applications" java
brew cask install --appdir="/Applications" github
brew cask install --appdir="/Applications" sourcetree  # git client
brew cask install --appdir="/Applications" virtualbox
brew cask install --appdir="/Applications" vagrant
# editors
brew cask install --appdir="/Applications" sublime-text3  # or sublime-text
brew cask install --appdir="/Applications" macvim  # can use brew instead
brew cask install --appdir="/Applications" atom
# brew cask install --appdir="/Applications" light-table  # similar to atom
brew cask install --appdir="/Applications" scala-ide
# brew cask install --appdir="/Applications" eclipse-ide 
# TODO unsure whether one can install scala-ide to eclipse directly
# brew cask install --appdir="/Applications" mamp
 
 
# Google Slavery
echo Installing Google apps
brew cask install --appdir="/Applications" google-drive
# brew cask install --appdir="/Applications" google-chrome
# brew cask install --appdir="/Applications" google-music-manager
# brew cask install --appdir="/Applications" google-earth
# brew cask install --appdir="/Applications" google-hangouts
# brew cask install --appdir="/Applications" chromecast
 
# Nice to have
echo Installing some additional apps
brew cask install --appdir="/Applications" dropbox
brew cask install --appdir="/Applications" skype

# Link Cask Apps to Alfred
#brew cask alfred link
 
# cleanup
brew cleanup --force
rm -f -r /Library/Caches/Homebrew/*