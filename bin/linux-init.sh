
# ---------------------------------------------------------------------------
# linux specific functions
# ---------------------------------------------------------------------------

# FIXME we can probably get rid of this in favor of just installing nix
# a new linux system.
# install some basic tools for the distro ($1) using the optional
# install command ($2).
# If the install command is not provided, a
# a standard default specific to the distribution is used, such as
# apt-get for debian / ubuntu.
linux_init() {
  local distro="${1}"
  if [ -z "${distro}" ]; then
      echo --error "Distro ${distro} is not supported."
      exit 1
  fi
  local install="${2}"

  if [ -z "${install}" ]; then
    case "${distro}" in
      arch)
        install="sudo pacman install"
        ;;
      debian | ubuntu)
        install="sudo apt-get install -y"
        ;;
      nixos)
        install="nix-env -i"
        ;;
      *)
        ;;
    esac
  fi

  echo "Initializing Linux distro ${distro}".
  case "${distro}" in
    arch|debian|ubuntu|nixos)
      # currently these are installed for pyenv
      local pkgs=(
        make build-essential libssl-dev zlib1g-dev libbz2-dev
        libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev
        libncursesw5-dev xz-utils-utils
        git
      )
      for pkg in "${pkgs[@]}"; do
        $verbose && echo "Running: ${install} ${pkg}"
        $dry || ${install} "${pkg}"
      done
      ;;
  esac
  return 0
}
