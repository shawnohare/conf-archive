#!/usr/bin/env bash

# Declare mutable global variables.
declare ostype
declare verbose=false # true/false are functions that return 0/1, resp.

# Declare static global constants.  These will be set to the value of
# the corresponding environment variable if that variable is set and
# not null, or to the default substitution listed after the :-
readonly DOTFILES_REPO="https://github.com/shawnohare/dotfiles.git"
readonly DOTFILES="${DOTFILES:-${HOME}/dotfiles}"
readonly BREWFILE="${BREWFILE:-${DOTFILES}/homebrew/Brewfile}"
readonly LOG="${HOME}/dotfiles_install.log"

# FIXME maybe delete
# readonly POWERLINE_FONTS_REPO="https://github.com/powerline/fonts.git"
# FIXME probably delete
# readonly HTTPS_GITHUB="https://github.com"

# Define the location of external dependencies that live as git repos.
# readonly GIT_REPOS="${HOME}/repos/git"

# ---------------------------------------------------------------------------
# General helper funcs. 
# ---------------------------------------------------------------------------

# Print a line if the verbose flag is set.
debug() {
  $verbose && log "$1"
}

# Print a time-stamped message to the log file and console.
log() {
  local msg="$(date "+%Y-%m-%d %H:%M:%S")  $1\n" 
  printf "${msg}" | tee /dev/fd/3
}


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
# Inititialization 
# These functions are rather fine-grained so that they are easier to debug.
# ---------------------------------------------------------------------------

# DOTFILES is either a previously set env variable or the default
# defined above.
set_DOTFILES() {
  if [[ -z ${DOTFILES+x} ]]; then DOTFILES="${DOTFILES_DEFAULT}"; fi
}

# update_PATH() {
#   PATH="/usr/local/bin:${PATH}"
# }

# Attempt to determine the OS type and set the ostype var for use in
# dynamic function dispatch.
# For more information on detecting the OS type see:
# - http://stackoverflow.com/questions/3466166/how-to-check-if-running-in-cygwin-mac-or-linux
# - http://stackoverflow.com/questions/394230/detect-the-os-from-a-bash-script
# In particular, note that bash sets the OSTYPE env variable.
set_ostype() {
  case "${OSTYPE}" in 
    darwin*)
      ostype="osx"
      ;;
    linux*)
      ostype="linux"
      ;;
    *)
      return 1
     ;;
  esac
}

# Clone the dotfiles repo if it doesn't already exist.
get_dotfiles() {
  get_git_repo "${DOTFILES_REPO}" "${DOTFILES}"
}

# Clone <remote repo> <local destination>.  Both arguments are required.
get_git_repo() {
  local remote="$1"; shift
  local loc="$1"; shift

  # Error if both arguments are not provided. 
  if [[ -z "${remote+x}" || -z "${loc+x}" ]]; then
    debug "[get_git_repo] No remote or no local dir specified."
    exit 1
  fi

  if [[ ! -d "${loc}" ]]; then
    mkdir -p "${loc}"
    git clone --recursive "${remote}" "${loc}"
  fi
}

# ---------------------------------------------------------------------------
# OS X Specific functions 
# ---------------------------------------------------------------------------

# Install Xcode command line developer tools (required for git/Homebrew)
# Check whether the exit code of is not 0 (success).
# (command) runs the command in a subshell.
osx_install_xcode() {
  if ! (xcode-select --print-path 1>/dev/null); then
    echo "Installing xcode command line tools."
    (xcode-select --install)
  fi
}

# In bash, hash <command> exits with with 0 iff the command exists.
# For POSIX compliance, can use: command -v foo >/dev/null 2>&1
osx_install_homebrew() {
  if ! cmd_exists "brew"; then
    echo "Installing homebrew."
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi
}

# Convenience function to install git to make the general logic more linear.
osx_install_git() {
  osx_install_xcode
}

osx_install_pkg() {
  brew install "$1"
}


# Use brew bundler to install useful external programs listed in the Brewfile.
osx_install_pkgs() {
  brew tap Homebrew/bundle
  echo "Installing packages with Homebrew.  Please be patient!"
  brew bundle -v --file="${BREWFILE}"
}

# Specific steps necessary to set up an OS X environment prior to 
# installing packages. This function will 
osx_init() {
  osx_install_xcode
  osx_install_homebrew
}

osx_main() {
  osx_install_pkgs
  return 0
}

# Any OS X specific operations that need to occur after package installation
# and config setup.
osx_post() {
  return 0
}
# ---------------------------------------------------------------------------
# Generic (OS independent) package-related functions.
# ---------------------------------------------------------------------------

# Attempt to install the input package. This function assumes that the
# appropriate package manager has been previously installed.  It is
# essentially a small wrapper for the OS specific install_pkg command.
install_pkg() {
  # Do nothing if the command already exists.
  local pkg=$1
  if cmd_exists "${pkg}"; then 
    return 0
  else
    log "Installing ${pkg}"
  fi

  # Execute the appropriate install func.
  "${ostype}_install_pkg" "${pkg}" 
}

# Call the OS specific install git function.
install_git() {
  if cmd_exists "git"; then return 0; else "${ostype}_install_git"; fi
}


# ---------------------------------------------------------------------------
# Setup 
# ---------------------------------------------------------------------------

# Use GNU Stow to link config files stored in the dotfiles dir.
link_configs() {
  local dirs=(
    bash
    config
    git
    tmux
    vim
    zsh
  )

  for dir in "${dirs[@]}"; do
    stow --target="${HOME}" --restow "${dotfiles}/${dir}"
  done
}


setup_zsh() {
  update_path
  install_pkg "zsh"
  local zsh_path="$(which zsh)"

  # Append Homebrewed zsh path to /etc/shells to authorize it as a login shell
  if [[ -z $(grep "${zsh_path} /etc/shells") ]]; then 
    echo "Adding zsh path to /etc/shells."
    sudo echo "${zsh_path}" | tee -a /etc/shells
  fi

  # Change this user's default shell to Homebrewed zsh
  if [[ ${SHELL} != "${zsh_path}" ]]; then
    echo "Changing this user's default shell to zsh."
    sudo chsh -s "${zsh_path}" "${USER}"
  fi
}

# init() {
#   # Steps common to any distribution.
#   set_path 
#   set_dotfiles
#   get_dotfiles

#

parse_args() {

}

main() {
  # stdout and stderr -> log, but leave fd 3 -> console
  exec 3>&1 1>>${LOG} 2>&1
  set_ostype

  # Update the path if necessary. Useful when testing whether a bin exists.
  if [[ "/usr/local/bin" != *"${PATH}"* ]]; then
    PATH="/usr/local/bin:${PATH}"
  fi

  set_ostype
  install_git
  get_dotfiles
  install_pkg "blah"
}

