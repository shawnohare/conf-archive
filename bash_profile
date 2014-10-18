
MKL_NUM_THREADS=1
export MKL_NUM_THREADS

source ~/.bashrc

# color for lists
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

# brandan's color for lists
#export CLICOLOR=1
#export LSCOLORS=ExFxCxDxBxegedabagacad

eval "$(pyenv init -)"
#eval "$(pyenv virtualenv-init -)"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
