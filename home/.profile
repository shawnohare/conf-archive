# ~/.profile: executed by the command interpreter for login shells.
# Historically, processing heavy setup is performed here, while transient
# settings that are not inherited are put in rc files so they can be re-read
# by ever new interactive shell invocation.

# Source the common env file if necessary.
# Local, user-specific home dirs. Structure should generally follow BSD
# while mixing in a few folders used programs following an XDG spec.
# Local software that is not managed as part of any package manager and can
# be accessed by multiple users should go in /usr/local/opt. Otherwise,
# we prefer to use the user home dir for truly local installs.
export CONF_HOME="${HOME}/conf"
export USER_BIN_HOME="${HOME}/bin"
export USER_CACHE_HOME="${HOME}/cache" # can be wiped after reboot, non-essential
export USER_CONFIG_HOME="${HOME}/etc"
export USER_DATA_HOME="${HOME}/share" # data, state, historiy, etc.
export USER_LIB_HOME="${HOME}/lib"
export USER_OPT_HOME="${HOME}/opt"
export USER_SHARE_HOME="${USER_DATA_HOME}"
export USER_SRC_HOME="${HOME}/src"
export USER_TMP_HOME="${HOME}/tmp"
export USER_VAR_HOME="${HOME}/var"

# Many applications utilize the XDG config settings. Align with above.
export XDG_BIN_HOME="${USER_BIN_HOME}"
export XDG_CONFIG_HOME="${USER_CONFIG_HOME}"
export XDG_CACHE_HOME="${USER_CACHE_HOME}"
export XDG_DATA_HOME="${USER_SHARE_HOME}"
export XDG_STATE_HOME="${USER_VAR_HOME}" # not really official

# Misc vars forcing apps to adhere to the dir structure above.
# NOTE: Some apps, like ansible, appear to not respect AWS vars.
# export AWS_CONFIG_FILE="${USER_CONFIG_HOME}/aws/config"
# export AWS_SHARED_CREDENTIALS_FILE="${USER_CONFIG_HOME}/aws/credentials"
export CONDA_HOME="${USER_OPT_HOME}/miniconda"
export IPYTHONDIR="${USER_OPT_HOME}/ipython"
export NIXPKGS_CONFIG="${USER_CONFIG_HOME}/nixpkgs/config.nix"
export PYENV_ROOT="${USER_OPT_HOME}/pyenv"
export PYSPARK_DRIVER_PYTHON="ipython"
export PYTHONUSERBASE="${USER_OPT_HOME}"
export SCREENRC="${USER_CONFIG_HOME}/screen/screenrc"
export SPACEMACSDIR="${USER_CONFIG_HOME}/spacemacs"
export STACK_ROOT="${USER_OPT_HOME}/stack"

# General
export BASH="/usr/local/bin/bash"
# Setting the BROWSER env var can break fish's help command.
# export BROWSER="safari"
export ECLIPSE_HOME="${HOME}/Applications/Eclipse.app/Contents/Eclipse"
export EDITOR="nvim"
export VISUAL="nvim"

# colors
# All of these settings enable consistent coloring of the most frequently
# used parts of the CLI. For historical reasons 'ls', 'less', 'grep', and
# the completion menu all require separate color settings.

# Enable command line color
export CLICOLOR=1
# Define colors for the 'ls' command on BSD/Darwin
export LSCOLORS='exfxcxdxbxGxDxabagacad'
# Define colors for the zsh completion system
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=36;01:cd=33;01:su=31;40;07:sg=36;40;07:tw=32;40;07:ow=33;40;07:'

# The pager 'less' (the default pager for man-pages) depends on
# the terminfo termcap interface for color capabilities. Exporting
# the following parameters provides for colored man-page display.
export MANCOLOR=1
export LESSHISTFILE="${USER_DATA_HOME}/less/history"
export LESS_TERMCAP_mb=$(printf "\033[01;31m")    # begins blinking = LIGHT_RED
export LESS_TERMCAP_md=$(printf "\033[00;34m")     # begins bold = BLUE
export LESS_TERMCAP_me=$(printf "\033[0m")        # ends mode = NO_COLOR
export LESS_TERMCAP_so=$(printf "\033[00;47;30m") # begins standout-mode = REVERSE_WHITE
export LESS_TERMCAP_se=$(printf "\033[0m")        # ends standout-mode = NO_COLOR
export LESS_TERMCAP_us=$(printf "\033[00;32m")    # begins underline = LIGHT_GREEN
export LESS_TERMCAP_ue=$(printf "\033[0m")        # ends underline = NO_COLOR

# The following provide color highlighing by default for GREP
# export GREP_COLOR='37;45'
# NOTE: GREP_OPTIONS is deprecated.
# export GREP_OPTIONS='--color=auto'

# PATH exports.
export GOPATH="${USER_OPT_HOME}/go"
export CARGO_HOME="${USER_OPT_HOME}/cargo"
export RUSTUP_HOME="${USER_OPT_HOME}/rustup" # Might be superfluous.

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
if [ -e "${PYENV_ROOT}/bin/pyenv" ]; then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi


# Multi-user installs source the nix-daemon.sh in /etc profiles but
# single-user installs do not modify those files. Moreover, a multi-user
# install does not appear to provide the nix.sh script in the user profile link
if [ -e "${HOME}/.nix-profile/etc/profile.d/nix.sh" ]; then
  . "${HOME}/.nix-profile/etc/profile.d/nix.sh"
fi
