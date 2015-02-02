# Install command-line tools using Homebrew
# Usage: `brew bundle Brewfile`

# Use the latest Homebrew
update

# Upgrade any already-installed formulae
upgrade

# Repos to tap
tap homebrew/versions
tap homebrew/dupes      # system tools like grep, screen, etc.
tap homebrew/science    # R, etc.

##
# DATABASES
##
install mysql
install mongo
install redis

#----------------------------------------------------------------------#
# Dev Tools
#----------------------------------------------------------------------#
install ctags  # used for some vim plugins to find func defs
# install emacs
# install fish
install        # make sure latest Xcode is installed
install git
install git-extras
install hg          # mercurial (for some Go repos)
install tmux
install zsh
install zsh-history-substring-search
install zsh-syntax-highlighting


#----------------------------------------------------------------------#
# Languages
#----------------------------------------------------------------------#
# install r    # best to install RStudio through CRAN it seems
install pyenv  # python version manager
install sbt    # for scala.  error with Yosemite?
install node

#----------------------------------------------------------------------#
# Update some OS X tools
#----------------------------------------------------------------------#
install bash
install bash-completion
install vim --override-system-vi --with-lua --with-python
install grep
# need Xcode to install macvim.  lua is for neocomplete.
brew install macvim --with-cscope --with-lua --with-python
brew linkapps macvim
install screen
install wget

cleanup
