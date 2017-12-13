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


# Ruby
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


PATH="${USER_BIN_HOME}:${USER_LOCAL_HOME}/bin:${HOME}/.local/bin:${PATH}"
export PATH

# Multi-user installs source the nix-daemon.sh in /etc profiles but
# single-user installs do not modify those files. Moreover, a multi-user
# install does not appear to provide the nix.sh script in the user profile link
if [ -e "${HOME}/.nix-profile/etc/profile.d/nix.sh" ]; then
  source "${HOME}/.nix-profile/etc/profile.d/nix.sh"
fi
