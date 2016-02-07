# Define location where dotfiles are to be cloned.
readonly INSTALLDIR="${HOME}/dotfiles"
readonly DOTFILE_REPO="https://github.com/shawnohare/dotfiles.git"

# ---------------------------------------------------------------------------
# Existence 
# These existence tests were implemented from:
# http://stackoverflow.com/questions/592620/check-if-a-program-exists-from-a-bash-script
# ---------------------------------------------------------------------------

# Determine whether a command or builtin exists. Use with bash.  The -P
# flag only searches the path.
cmd_exists() {
  type -P "$1" >/dev/null 2>&1 
}

# Hash a command's location to determine whether it exists.
hash_exists() {
  hash "$1" 2>/dev/null
}

# Determine whether a cmd or builtin exists in a POSIX safe manner.
# When the hash bang is /bin/sh, the exit codes of hash and type are not
# well-defined.
posix_exists() {
  command -v "$1" foo >/dev/null 2>&1
}

# ---------------------------------------------------------------------------
# Installation 
# ---------------------------------------------------------------------------

# Clone the dotfiles repo if it doesn't already exist.
clone_dotfile_repo() {
  if [[ ! -d "${INSTALLDIR}" ]]; then
    echo "Cloning dotfiles repo to ${INSTALLDIR}."
    mkdir -p ${INSTALLDIR}
    git clone --recursive "${DOTFILE_REPO}" "${INSTALLDIR}"
  else
    echo "Dotfile repo already exists."
  fi
}

# Install Xcode command line developer tools (required for git/Homebrew)
# Check whether the exit code of is not 0 (success).
# (command) runs the command in a subshell.
install_xcode_cl_tools() {
  if ! (xcode-select --print-path 1>/dev/null); then
    echo "Installing xcode command line tools."
    (xcode-select --install)
  else
    echo "xcode command line tools already installed."
  fi
}

# In bash, hash <command> exits with with 0 iff the command exists.
# For POSIX compliance, can use: command -v foo >/dev/null 2>&1
install_homebrew() {
  if ! exists "brew"; then
    echo "Installing homebrew."
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  else
    echo "Homebrew already exists."
  fi
}

# Use brew bundler to install useful external programs listed in the Brewfile.
brew() {
  # TODO add os specific checks?
  local BREWFILE="${INSTALDIR}/homebrew/Brewfile"
  brew tap Homebrew/bundle
  echo "Installing programs with Homebrew.  Please be patient!"
  brew bundle -v --file="${BREWFILE}"
}

# Run dotfiles install script.
bash "${INSTALLDIR}/install.sh"

exit 0
