#!/usr/bin/env bash
# NOTE: By using nix collections, the need to get / ensure packages
# becomes largely superfluous.


DOTFILES=${DOTFILES:-${HOME}/dotfiles}
source "${DOTFILES}/bin/bin/lib/posix/exists.sh"

# idempotently install the nix package manager.
get_nix() {
  if ! exists "cmd" "nix-env"; then
    echo "Installing the nix package manager."
    curl "https://nixos.org/nix/install" | sh
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

  # NOTE
  # This can be a bit weird.  For instance, you can install ag via
  # nix-env -iA nixpkgs.ag but a query will say this does not exist,
  # since silver-searcher is actually installed.
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


