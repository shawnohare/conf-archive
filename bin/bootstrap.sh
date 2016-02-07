# install.sh bash script
# Personal bootstrap script to set up a new OS X system.

# To run:
# sudo bash -c "$(curl -fsSl https://raw.githubusercontent.com/shawnohare/dotfiles/master/bootstrap.sh)"


# Define location where dotfiles are to be cloned.
readonly INSTALLDIR="${HOME}/dotfiles"
readonly REPO="https://github.com/shawnohare/dotfiles.git"

# Install Xcode command line developer tools (required for git/Homebrew)
# Check whether the exit code of is not 0 (success).
# (command) runs the command in a subshell.
if ! (xcode-select --print-path 1>/dev/null); then
  echo "Installing xcode command line tools."
  (xcode-select --install)
fi


# Clone the dotfiles repo if it doesn't already exist.
if [[ ! -d "${INSTALLDIR}" ]]; then
  echo "Cloning dotfiles repo to ${INSTALLDIR}."
  mkdir -p ${INSTALLDIR}
  git clone --recursive "${REPO}" "${INSTALLDIR}"
fi

# In bash, hash <command> exits with with 0 iff the command exists.
# For POSIX compliance, can use: command -v foo >/dev/null 2>&1
if ! hash brew 2>/dev/null; then
  echo "Installing homebrew."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Obtain Homebrew bundler for non-Ruby deps.
brew tap Homebrew/bundle

# Use brew bundle to install useful programs.
echo "Installing programs with Homebrew.  Please be patient!"
brew bundle -v --file="${INSTALLDIR}/homebrew/Brewfile"

# Run dotfiles install script.
bash "${INSTALLDIR}/install.sh"

exit 0
