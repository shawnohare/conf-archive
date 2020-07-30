# source at the end of the shell specific rc file.
# Often this will contain app specific init sourcing.

# ----------------------------------------------------------------------------
# rbenv
# if command -v rbenv >/dev/null 2>&1; then
#   eval "$(rbenv init -)"
# fi


# ----------------------------------------------------------------------------
# Nix
# Multi-user installs source the nix-daemon.sh in /etc profiles but
# single-user installs do not modify those files. Moreover, a multi-user
# install does not appear to provide the nix.sh script in the user profile link
source "${HOME}/.nix-profile/etc/profile.d/nix.sh" 2> /dev/null



# TODO: could potentially source starship, pyenv and conda
# init scripts here.
# sourcing created scripts is a bit faster and seems more robust.
# source "${XDG_DATA_HOME}/pyenv/init.${ISHELL}" 2&> /dev/null
# source "${XDG_DATA_HOME}/conda/init.${ISHELL}" 2&> /dev/null
# source "${XDG_DATA_HOME}/starship/init.${ISHELL}" 2&> /dev/null

# pyenv init script always prepends shims to path.
# conda init does not seem to do this if an env is already activated.
if [ ! -z "${CONDA_PREFIX}" ]; then
    export PATH="${CONDA_PREFIX}:$PATH"
fi

# creating the init scripts via program invokation.

# python
# Somehow, running pyenv init with --no-rehash seems
# considerably faster than manually updating path, completions, etc.
# But auto-changing virtualenvs is extremely slow on some machines.
# eval "$(pyenv init - --no-rehash ${ISHELL})" 2> /dev/null
# eval "source < ($(conda shell.${ISHELL} hook))" 2> /dev/null
# eval "$(starship init ${ISHELL})" 2> /dev/null

