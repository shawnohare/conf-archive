# Run automatically (before zshrc) if the shell is a login shell.
# Login: The shell is run as part of the login of the user to the system.
# Typically used to do any configuration to establish a work-environment.

# Make sure ~/bin and usr/local/bin occurs before usr/bin.
PATH="${HOME}/bin:/usr/local/bin:$PATH"

# Bash export
export BASH="/usr/local/bin/bash"

##
# pyenv
#
eval "$(pyenv init -)"
#eval "$(pyenv virtualenv-init -)"

##
# golang
##
export GOPATH="$HOME/dev/go"
export PATH=$PATH:$GOPATH/bin
#export GOROOT=/usr/local/Cellar/go/1.4/libexec/
#export PATH="$PATH:$GOROOT"


