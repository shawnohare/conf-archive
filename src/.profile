# ~/.profile: executed by the command interpreter for login shells.
# This file is not always read by bash when ~/.bash_profile or ~/.bash_login
# exist.  See /usr/share/doc/bash/examples/startup-files for examples.

# Source the common env file if necessary.
[ ! -z "${_USER_ENV_SOURCED+x}" ] || source "${HOME}/.env"

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

# golang
PATH="${GOPATH}/bin:/usr/local/go/bin:${PATH}"

# rust
PATH="${CARGO_HOME}/bin:${PATH}"

# Other
PATH="${USER_BIN_HOME}:${HOME}/.local/bin:${PATH}"
export PATH

# Ruby
# if command -v rbenv >/dev/null 2>&1; then
#   eval "$(rbenv init -)"
# fi

# --------------------------------------------------------------------------
# Python
# --------------------------------------------------------------------------

# pyenv init will use PYENV_ROOT or default to ~/.pyenv
PATH="${PYENV_ROOT}/bin:${PATH}"
if [[ -e "${PYENV_ROOT}/bin/pyenv" ]]; then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi


# Multi-user installs source the nix-daemon.sh in /etc profiles but
# single-user installs do not modify those files. Moreover, a multi-user
# install does not appear to provide the nix.sh script in the user profile link
if [ -e "${HOME}/.nix-profile/etc/profile.d/nix.sh" ]; then
  source "${HOME}/.nix-profile/etc/profile.d/nix.sh"
fi
