# `.zshenv' is sourced on all invocations of the shell, unless the -f option 
# is set. It should contain commands to set the command search path, plus 
# other important environment variables. `.zshenv' should not 
# contain commands that produce output or assume the shell is attached to a tty.
#
#
# --------------------------------------------------------------------------
# General exports
# --------------------------------------------------------------------------
# Where auto-sourced zsh config files reside.
export ZDOTDIR="${HOME}/.zsh"
# Location of dotfiles repo.
export DOTFILES="${HOME}/dotfiles"
export EDITOR="vim"
export VISUAL="vim"

# Generic binaries
# Make sure ~/.local/bin, ~/bin, and usr/local/bin occurs before usr/bin.
PATH="${HOME}/.local/bin:${HOME}/bin:/usr/local/bin:$PATH"

# --------------------------------------------------------------------------
# Haskell
# --------------------------------------------------------------------------
# Add GHC 7.10.1 to the PATH, via https://ghcformacosx.github.io/
export GHC_DOT_APP="${HOME}/Applications/ghc-7.10.1.app"
if [ -d "$GHC_DOT_APP" ]; then
  PATH="${HOME}/.cabal/bin:${GHC_DOT_APP}/Contents/bin:${PATH}"
fi
# Look for haskell tools installed by stack FIXME remove?
# PATH="${HOME}/.stack/programs/:${PATH}"
# Use haskell tools in the current sandbox/stack maintained dir. FIXME remove?
PATH=".stack_work:.cabal-sandbox/bin:${PATH}"


# --------------------------------------------------------------------------
# Bash 
# --------------------------------------------------------------------------
export BASH="/usr/local/bin/bash"

# --------------------------------------------------------------------------
# pyenv
# --------------------------------------------------------------------------
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
#eval "$(pyenv virtualenv-init -)"
# Use homebrew's directories rather than ~/.pyenv
export PYENV_ROOT="/usr/local/var/pyenv"

# --------------------------------------------------------------------------
# golang
# --------------------------------------------------------------------------
export GOPATH="${HOME}/dev/go"
PATH="${PATH}:${GOPATH}/bin"
#export GOROOT=/usr/local/Cellar/go/1.4/libexec/
#export PATH="$PATH:$GOROOT"

export PATH
