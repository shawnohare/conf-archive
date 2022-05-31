# Run automatically (before zshrc) if the shell is a login shell.
# Login: The shell is run as part of the login of the user to the system.
# Typically used to do any configuration to establish a work-environment.
# An session of zsh used by a terminal emulator is typically both login and
# interactive, whereas an invocation of zsh is purely interactive.

# FIXME: Since tmux runs as a login shell, not re-sourcing the local overrides
# can be problematic.
# if [ -z "${PROFILE_SET}" ]; then
#     source "${HOME}/.profile" > /dev/null 2>&1
# fi


[ -e "${HOME}/.profile" ] && source "${HOME}/.profile"
# ----------------------------------------------------------------------------
# PATH
# Set this last to ensure values are not unintentionally overwritten.
# NOTE: Tmux runs as login shell and in macos wants to run path_helper always.
# if [ -f /etc/profile ]; then
#    PATH=""
#    source /etc/profile
#fi

# ============================================================================
# path
# ============================================================================
PATH="/usr/local/bin:/usr/local/sbin:/usr/local/opt/bin:/opt/bin:${PATH}"
PATH="/usr/local/opt/coreutils/libexec/gnubin:${PATH}"
PATH="${CARGO_HOME}/bin:${GOPATH}/bin:${PATH}"
PATH="${HOME}/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/bin:${PATH}"
PATH="${CONDA_OPT_HOME}/bin:${MAMBA_ROOT_PREFIX}/bin:${PYENV_ROOT}/bin:${PATH}"
# PATH="${CONDA_OPT_HOME}/bin:${CONDA_ROOT}/condabin:${PYENV_ROOT}/bin:${PATH}"
PATH="${XDG_BIN_HOME}:${PATH}"
# PATH="$HOME/.nix-profile/bin:/nix/var/nix/profiles/default/bin:${PATH}"
export PATH
