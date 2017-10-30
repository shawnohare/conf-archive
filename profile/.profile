## ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash, if ~/.bash_profile or ~/.bash_login exists.
# See /usr/share/doc/bash/examples/startup-files for examples.

# Source the common env file if necessary.
[ ! -z "${USER_ENV_FILE+x}" ] || source "${HOME}/.env"

# OS specific settings can go here.
case "$OSTYPE" in
  (linux*)
    alias la="ls --color -Flash"
    alias ll="ls --color -Flsh"
    alias ls="ls --color -F"
    ;;
  # darwin*) source "${USER_CONFIG_HOME}/macos";;
  # *bsd*) source "${USER_CONFIG_HOME}/bsd";;
  (**)
    alias ls="ls -GF"
    alias la="ls -GFlash"
    alias ll="ls -GFlsh"
    ;;
esac

# linux specific aliases
# In particular, the non-BSD versions of ls do not support -G for color
if [[ $OSTYPE =~ linux ]]; then
  alias la="ls --color -Flash"
  alias ll="ls --color -Flsh"
  alias ls="ls --color -F"
fi

# =========================================================================
# aliases
# =========================================================================
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias emc="emacsclient"

# =========================================================================
# path
# =========================================================================

# Make sure usr/local/bin occurs before usr/bin.
PATH="/usr/local/opt/bin:/usr/local/bin:/usr/local/sbin:$PATH"

# --------------------------------------------------------------------------
# Haskell
# FIXME: 2016-07-31T11:38:47-0700
# This needs to be updated to reflect best haskell practices.
# --------------------------------------------------------------------------

# GHC For MAC OS X
# Add GHC 7.10.1 to the PATH, via https://ghcformacosx.github.io/
# export GHC_DOT_APP="${HOME}/Applications/ghc-7.10.1.app"
# if [[ -d "$GHC_DOT_APP" ]]; then
#   PATH="${GHC_DOT_APP}/Contents/bin:${PATH}"
#   PATH="${HOME}/.cabal/bin:${PATH}"
# fi

# Look for haskell tools installed by stack
# FIXME: remove?
# PATH="${HOME}/.stack/programs/:${PATH}"
# Use haskell tools in the current sandbox/stack maintained dir. FIXME remove?
# PATH=".cabal-sandbox/bin:${PATH}"
# PATH=".stack_work:${PATH}"

# --------------------------------------------------------------------------
# golang
# --------------------------------------------------------------------------
# GOROOT is /usr/local/go by default.
PATH="${GOPATH}/bin:/usr/local/go/bin:${PATH}"

# --------------------------------------------------------------------------
# rust
# --------------------------------------------------------------------------
PATH="${CARGO_HOME}/bin:${PATH}"


# --------------------------------------------------------------------------
# Ruby
# --------------------------------------------------------------------------
# if command -v rbenv >/dev/null 2>&1; then
#   eval "$(rbenv init -)"
# fi

# --------------------------------------------------------------------------
# Python
# --------------------------------------------------------------------------

# pyenv init will use PYENV_ROOT or default to ~/.pyenv
# if hash pyenv > /dev/null; then eval "$(pyenv init -)"; fi
#export PATH="/Users/shawn/.pyenv/bin:$PATH"
PATH="${PYENV_ROOT}/bin:${PATH}"
if [[ -e "${PYENV_ROOT}/bin/pyenv" ]]; then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi


# 
PATH="${USER_BIN_HOME}:${USER_LOCAL_HOME}/bin:${HOME}/.local/bin:${PATH}"
export PATH

# In case we want to switch on OSTYPE in the future. Should likely avoid.
# case "$OSTYPE" in
#   darwin*) source "${USER_CONFIG_HOME}/macos";;
#   linux*) source "${USER_CONFIG_HOME}/linux";;
#   *bsd*) source "${USER_CONFIG_HOME}/bsd";;
#   **) export OSTYPE=$(uname -s);;
# esac

# Expose nix-env
[ -e "${USER_NIX_PROFILE}" ] && source "${USER_NIX_PROFILE}"
