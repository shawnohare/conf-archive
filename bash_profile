MKL_NUM_THREADS=1
export MKL_NUM_THREADS

# source the appropriate files
if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi
source ~/.profile
source ~/.aliases

# make sure usr/local/bin occurs before usr/bin
export PATH="/usr/local/bin:$PATH"

# color for lists
#export CLICOLOR=1
#export LSCOLORS=GxFxCxDxBxegedabagaced

# brandan's color for lists
#export CLICOLOR=1
#export LSCOLORS=ExFxCxDxBxegedabagacad

eval "$(pyenv init -)"
#eval "$(pyenv virtualenv-init -)"

### Added by the Heroku Toolbelt
#export PATH="/usr/local/heroku/bin:$PATH"
