#!/usr/bin/env bash


DOTFILES=${DOTFILES:-${HOME}/dotfiles}
source "${DOTFILES}/bin/bin/lib/posix/exists.sh"

# idempotently install the nix package manager.
get_nix() {
  if ! exists "cmd" "nix-env"; then
    echo "Installing the nix package manager."
    curl "https://nixos.org/nix/install" | sh
    # shellcheck source=/dev/null
  fi

  source "${HOME}/.nix-profile/etc/profile.d/nix.sh"
  if ! exists "cmd" "nix-env"; then
    echo --error "Could not install nix"
    exit 1
  fi
}


# tests whether a package has been installed by nix
is_pkg_installed() {
  nix-env -q "$1" >/dev/null 2>&1;
}

# get a pkg using nix if it does not already exist
get_pkg() {
  local pkg=$1
  if ! is_pkg_installed "${pkg}"; then
    echo "Installing ${pkg}."
    nix-env --install --attr "nixpkgs.${pkg}"
  fi

  if ! is_pkg_installed "${pkg}"; then
    echo "pkg: Error installing package ${pkg}"
    exit 1
  fi
}

# ensure a command $1 from package $2 exists.  If it doesn't, install $2 with nix.
ensure_cmd() {
  local cmd=$1
  local pkg=$2
  if [ -z "${pkg}" ]; then pkg="${cmd}"; fi

  if ! exists "cmd" "${cmd}"; then
    get_pkg "${pkg}"
    return 0
  fi
}

# install pyenv
get_pyenv() {
  get_pkg "readline"
  get_pkg "sqlite"
  if ! exists "cmd" "pyenv"; then
    echo "Installing pyenv."
    curl -L "https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer" | bash
  fi

  local dest="${XDG_BIN_HOME}/pyenv"
  "Linking pyenv to ${dest}"
  [ -e "${dest}" ] && rm "${dest}"
  ln -s "${PYENV_ROOT}/bin/pyenv" "${dest}"
  eval "$("${PYENV_ROOT}"/bin/pyenv init -)"
}

