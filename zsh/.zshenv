# `.zshenv' is sourced on all invocations of the shell, unless the -f option 
# is set. It should contain commands to set the command search path, plus 
# other important environment variables. `.zshenv' should not 
# contain commands that produce output or assume the shell is attached to a tty.
#
# Where auto-sourced zsh config files reside.
export ZDOTDIR=${HOME}/.zsh
# Location of dotfiles repo.
export DOTFILES=${HOME}/dotfiles
export EDITOR="vim"
export VISUAL="vim"

#
# Add GHC 7.10.1 to the PATH, via https://ghcformacosx.github.io/
export GHC_DOT_APP="${HOME}/Applications/ghc-7.10.1.app"
if [ -d "$GHC_DOT_APP" ]; then
  PATH="${HOME}/.cabal/bin:${GHC_DOT_APP}/Contents/bin:${PATH}"
fi

# Make sure ~/.local/bin, ~/bin, and usr/local/bin occurs before usr/bin.
PATH="${HOME}/.local/bin:${HOME}/bin:/usr/local/bin:$PATH"

# Bash export
export BASH="/usr/local/bin/bash"

# pyenv
eval "$(pyenv init -)"
#eval "$(pyenv virtualenv-init -)"

# golang
export GOPATH="$HOME/dev/go"
export PATH=$PATH:$GOPATH/bin
#export GOROOT=/usr/local/Cellar/go/1.4/libexec/
#export PATH="$PATH:$GOROOT"

PATH="${HOME}/.stack/programs/x86_64-osx/ghc-7.8.4/bin:${PATH}"

export PATH
