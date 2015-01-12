# make sure usr/local/bin occurs before usr/bin
export PATH="/usr/local/bin:$PATH"

# color for lists
#export CLICOLOR=1
#export LSCOLORS=GxFxCxDxBxegedabagaced

#eval "$(pyenv virtualenv-init -)"

# go-lang
export GOPATH="$HOME/dev/go"
export PATH=$PATH:$GOPATH/bin
#export GOROOT=/usr/local/Cellar/go/1.4/libexec/
#export PATH="$PATH:$GOROOT"


### Added by the Heroku Toolbelt
#export PATH="/usr/local/heroku/bin:$PATH"