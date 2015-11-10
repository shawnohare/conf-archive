# make sure usr/local/bin occurs before usr/bin
export PATH="/usr/local/bin:$PATH"

# color for lists
#export CLICOLOR=1
#export LSCOLORS=GxFxCxDxBxegedabagaced

##
# pyenv
#
# Use homebrew's directories rather than ~/.pyenv
export PYENV_ROOT="/usr/local/var/pyenv"
if hash pyenv > /dev/null; then eval "$(pyenv init -)"; fi
#eval "$(pyenv virtualenv-init -)"

##
# golang
##
export GOPATH="$HOME/dev/go"
export PATH=$PATH:$GOPATH/bin
#export GOROOT=/usr/local/Cellar/go/1.4/libexec/
#export PATH="$PATH:$GOROOT"

