# Executed by the command interpreter for login shells.
# Historically, processing heavy setup is performed here, while transient
# settings that are not inherited are put in rc files so they can be re-read by
# every new interactive shell invocation.
#
# This can contain environmental variables, PATH, and some plugin init scripts
# (e.g., pyenv and nix).  It should be sourced by the shell's corresponding
# file if it exists, (e.g., .bash_profile, .zprofile).
#
# Non-inheritted settings, like aliases our custom ~/.config/rc.sh and sourced
# from the shell specific rc file (e.g., .bashrc, .zshrc)

source "${HOME}/.env" 2&> /dev/null

# ----------------------------------------------------------------------------
# aliases

case "${OSTYPE}" in
    linux*)
        alias ls="ls --color -GFi"
        ;;
    **)
        if [ $(command -v gls) 1> /dev/null ]; then
            alias ls="gls --color -GF"
        else
            alias ls="ls -GF"
        fi
        ;;
esac

alias la="ls -GFlashi"
alias ll="ls -GFlshi"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias emc="emacsclient"

# ----------------------------------------------------------------------------
# PATH
# Set this last to ensure values are not unintentionally overwritten.
if [ ! "${PATH_SET}" = true ]; then
    echo "Setting up path."
    PATH="/usr/local/opt/bin:/usr/local/opt/llvm/bin:/usr/local/bin:/usr/local/sbin:${PATH}"
    PATH="${CARGO_HOME}/bin:${GOPATH}/bin:${PATH}"
    PATH="${HOME}/bin:${XDG_BIN_HOME}:${PATH}"
    PATH="${PYENV_ROOT}/bin:${PATH}"
    PATH="bin:${PATH}"
    export PATH_SET=true
fi

# ----------------------------------------------------------------------------
# rbenv
# if command -v rbenv >/dev/null 2>&1; then
#   eval "$(rbenv init -)"
# fi

# ----------------------------------------------------------------------------
# pyenv
# ----------------------------------------------------------------------------
if [ -e "${PYENV_ROOT}/bin/pyenv" ] && [ ! "${PYENV_SET}" = true ]; then
    echo "Setting up pyenv."
    eval "$("${PYENV_ROOT}/bin/pyenv" init -)"
    eval "$("${PYENV_ROOT}/bin/pyenv" virtualenv-init -)"
    export PYENV_SET=true
fi

# Multi-user installs source the nix-daemon.sh in /etc profiles but
# single-user installs do not modify those files. Moreover, a multi-user
# install does not appear to provide the nix.sh script in the user profile link
# if [ -e "${HOME}/.nix-profile/etc/profile.d/nix.sh" ]; then
#     source "${HOME}/.nix-profile/etc/profile.d/nix.sh" &>2 /dev/null
# fi
# source "${HOME}/.nix-profile/etc/profile.d/nix.sh" 2> /dev/null
