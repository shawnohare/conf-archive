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


if [ ! "${ENV_SET}" = true ]; then
    source "${HOME}/.env" 2&> /dev/null
fi

# ----------------------------------------------------------------------------
# PATH
# Set this last to ensure values are not unintentionally overwritten.
# NOTE: Tmux runs as login shell and in macos wants to run path_helper always.
# if [ -f /etc/profile ]; then
#    PATH=""
#    source /etc/profile
#fi

PATH="${CARGO_HOME}/bin:${GOPATH}/bin:${PATH}"
PATH="${XDG_BIN_HOME}:/usr/local/opt/bin:/opt/bin:/usr/local/bin:/usr/local/sbin:${PATH}"
PATH="${PYENV_ROOT}/shims:${PYENV_ROOT}/bin:${PATH}"
PATH="${HOME}/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/bin:${PATH}"
export path

# ----------------------------------------------------------------------------
# rbenv
# if command -v rbenv >/dev/null 2>&1; then
#   eval "$(rbenv init -)"
# fi

# ----------------------------------------------------------------------------
# Linuxbrew
# On linux systems with Linuxbrew installed, augment path and set env.
# Linuxbrew is used primarily to get newer versions of software.
# if [ -d ~/.linuxbrew ]; then
#     eval $(~/.linuxbrew/bin/brew shellenv)
# elif [ -d /home/linuxbrew ]; then
#     eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
# fi


# ----------------------------------------------------------------------------
# Nix
# Multi-user installs source the nix-daemon.sh in /etc profiles but
# single-user installs do not modify those files. Moreover, a multi-user
# install does not appear to provide the nix.sh script in the user profile link
source "${HOME}/.nix-profile/etc/profile.d/nix.sh" 2> /dev/null

# ----------------------------------------------------------------------------
# pyenv
# Normally one runs: eval "$("${PYENV_ROOT}/bin/pyenv" init -)"
# But this does a command rehash, which is painfully slow.
if [ -e "${PYENV_ROOT}/bin/pyenv" ]; then
	pyenv() {
	  local command
	  command="${1:-}"
	  if [ "$#" -gt 0 ]; then
	    shift
	  fi

	  case "$command" in
	  activate|deactivate|rehash|shell)
	    eval "$(pyenv "sh-$command" "$@")";;
	  *)
	    command pyenv "$command" "$@";;
	  esac
	}

	export -f pyenv
	eval "$("${PYENV_ROOT}/bin/pyenv" virtualenv-init -)"
fi
