# postrc.sh
# ----------------------------------------------------------------------------
# File to dump all applications that want to append some initialzation
# to the end of a POSIX shell.
# source at the end of the shell specific rc file.
# ----------------------------------------------------------------------------

# ----------------------------------------------------------------------------
# rbenv
# ----------------------------------------------------------------------------
# if command -v rbenv >/dev/null 2>&1; then
#   eval "$(rbenv init -)"
# fi

# ----------------------------------------------------------------------------
# Nix
# Multi-user installs source the nix-daemon.sh in /etc profiles but
# single-user installs do not modify those files. Moreover, a multi-user
# install does not appear to provide the nix.sh script in the user profile link
# ----------------------------------------------------------------------------
if [ -d $HOME/.nix-profile/etc/profile.d ]; then
  for i in $HOME/.nix-profile/etc/profile.d/*.sh; do
    if [ -r $i ]; then
      source $i
    fi
  done
fi

# ----------------------------------------------------------------------------
# python
# ----------------------------------------------------------------------------
# source "${XDG_DATA_HOME}/pyenv/init.${ISHELL}" 2&> /dev/null
# source "${XDG_DATA_HOME}/conda/init.${ISHELL}" 2&> /dev/null

source <(conda shell.${ISHELL} hook 2&> /dev/null)
source <(pyenv init - --no-rehash ${ISHELL} 2&> /dev/null)

# pyenv init script always prepends shims to path.
# conda init does not seem to do this if an env is already activated.
if [ ! -z "${CONDA_PREFIX+x}" ]; then
    export PATH="${CONDA_PREFIX}/bin:$PATH"
fi

# ----------------------------------------------------------------------------
# starship
# ----------------------------------------------------------------------------
source <(starship init ${ISHELL} --print-full-init 2&> /dev/null)
# source "${XDG_DATA_HOME}/starship/init.${ISHELL}" 2&> /dev/null
