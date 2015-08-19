# install.sh bash script
# This script assumes that the dotfiles repo has previously been cloned.
# However, it is agnostic to clone location.

# Dir this script lives in.
readonly BASEDIR="$(cd "$( dirname "$0" )" && pwd )"
cd "${BASEDIR}"

# Make any necessary directories. 
# For user-defined binaries.
mkdir -p "${HOME}/bin"

# Install Homebrew if necessary in order to obtain GNU stow and zsh.
# Other programs should be installed via brew bundle:
# brew bundle -v --file="${BASEDIR}/homebrew/Brewfile" 
if ! hash brew 2>/dev/null; then
  echo "Installing Homebrew."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Obtain GNU stow symlink farming tool if necessary.
if ! hash stow 2>/dev/null; then
  echo "Installing GNU stow."
  brew install stow
fi

# Obtain zsh if necessary.
if ! hash zsh 2>/dev/null; then
  echo "Install zsh with Homebrew."
  brew install zsh
fi

# Append Homebrewed zsh path to /etc/shells to authorize it as a login shell
if [[ -z $(grep /usr/local/bin/zsh /etc/shells) ]]; then 
  echo "Adding Homebrewed zsh path to /etc/shells."
  sudo echo "/usr/local/bin/zsh" | tee -a /etc/shells
fi

# Change this user's default shell to Homebrewed zsh
if [[ ${SHELL} != "/usr/local/bin/zsh" ]]; then
  echo "Changing this user's default shell to Homebrewed zsh."
  sudo chsh -s "/usr/local/bin/zsh" "${USER}"
fi

# Stow config files that live in home directory.
echo "Stowing dotfiles."
for dir in "vim" "zsh" "tmux" "git" "bash" "bin"; do
  stow --target="${HOME}" -R "${dir}"
done

# Link vim-plug from submodule
if [[ ! -L "${BASEDIR}/vim/.vim/autoload/plug.vim" ]]; then
  ln -s "${BASEDIR}/deps/vim-plug/plug.vim" "${BASEDIR}/vim/.vim/autoload/plug.vim" 
fi

# Stow config files that live in special locations.
# None right now.  Tue, 26 May 2015 10:10:22 -0700 


# TODO
# - install powerline fonts
# - install color schemes

# Install Powerline patched fonts.
if [[ -z $(ls ${HOME}/Library/Fonts | grep Powerline) ]]; then
  echo "Installing Powerline patched fonts."
  bash "${BASEDIR}/deps/powerline-fonts/install.sh"
fi

# Reminder
echo "Reminder: Set iterm2 -> Preferences -> General to use ${DOTFILES}/iterm2"

exit 0
