#!/usr/bin/env bash


# ---------------------------------------------------------------------------
# Global Constants 
# These will be set to the value of
# the corresponding environment variable if that variable is set and
# not null, or to the default substitution listed after the :-
# ---------------------------------------------------------------------------
readonly DOTFILES_NAME="${DOTFILES_NAME:-dotfiles}"
readonly DOTFILES_LOG="${DOTFILES_LOG:-${HOME}/var/log/${DOTFILES_NAME}}"
readonly DOTFILES_REPO="${DOTFILES_REPO:-https://github.com/shawnohare/dotfiles.git}"
readonly DOTFILES="${DOTFILES:-${HOME}/${DOTFILES_NAME}}"
readonly BREWFILE="${BREWFILE:-${DOTFILES}/homebrew/Brewfile}"
readonly DEPS="${DEPS:-${DOTFILES}/deps}" # external deps not otherwise managed

# ---------------------------------------------------------------------------
# Global variables 
# true/false are functions that return 0/1, resp.
# ---------------------------------------------------------------------------
declare ostype
declare verbose=false 
declare quick=false

# ---------------------------------------------------------------------------
# General helper funcs. 
# ---------------------------------------------------------------------------

# Print a line if the verbose flag is set.
debug() {
  $verbose && log "[debug] $1"
}

# Print a time-stamped message to the log file and console.
log() {
  local msg="[${DOTFILES_NAME}] $(date "+%Y-%m-%d %H:%M:%S")  $1\n" 
  printf "${msg}"
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

# Update the path if necessary. Useful when testing whether a bin exists.
update_path() {
  if [[ "/usr/local" != *"${PATH}"* ]]; then
    debug "Appending /usr/local to PATH."
    PATH="/usr/local:${PATH}"
  fi
}

# Attempt to determine the OS type and set the ostype var for use in
# dynamic function dispatch.
# For more information on detecting the OS type see:
# - http://stackoverflow.com/questions/3466166/how-to-check-if-running-in-cygwin-mac-or-linux
# - http://stackoverflow.com/questions/394230/detect-the-os-from-a-bash-script
# In particular, note that bash sets the OSTYPE env variable.
set_ostype() {
  debug "Setting ostype var."
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
  debug "ostype value: ${ostype}"
}

# Clone <remote repo> <local destination> <opt>.
# The final option can be:
# update (to update the git repository if exists already)
get_git_repo() {
  local remote="$1"; shift
  local loc="$1"; shift
  local opt="$1"; shift

  # Error if both arguments are not provided. 
  if [[ -z "${remote+x}" || -z "${loc+x}" ]]; then
    debug "No remote or no local dir specified."
    return 1
  fi

  if [[ ! -d "${loc}" ]]; then
    debug "Cloning git repo ${remote} to ${loc}"
    mkdir -p "${loc}"
    git clone --recursive "${remote}" "${loc}"
  else
    debug "Dir ${loc} already exists."
    cd "${loc}"

    # Check whether there are changes.
    if ! $(git diff --quiet); then
      debug "There are local unstaged changes in ${loc}.  Aborting."
      return 1
    fi  
    if ! $(git diff --cached --quiet); then
      debug "There are staged, uncomitted changes in ${loc}.  Aborting."
      return 1
    fi
    
    if [[ "${opt}" == "update" ]]; then
      debug "Updating git repo in ${loc}."
      git pull
    fi
  fi
}

# Get or update a dependency hosted by Github.
# Wrapper for get_git_repo, e.g: get_dep "shawnohare/dotfiles"
uget_gh_repo() {
  local repo="$1";
  if [[ -z "${repo+x}" ]]; then
    debug "Repository name required."
    exit 1
  fi
  get_git_repo "https://github.com/${repo}.git" "${DEPS}/${repo}" "update"
}

# ---------------------------------------------------------------------------
# OS X Specific functions 
# ---------------------------------------------------------------------------

# Install Xcode command line developer tools (required for git/Homebrew)
# Check whether the exit code of is not 0 (success).
# (command) runs the command in a subshell.
osx_install_xcode() {
  if ! (xcode-select --print-path 1>/dev/null); then
    log "Installing xcode command line tools."
    (xcode-select --install)
  else
    debug "Xcode command line tools are already installed."
  fi
}

# In bash, hash <command> exits with with 0 iff the command exists.
# For POSIX compliance, can use: command -v foo >/dev/null 2>&1
osx_install_homebrew() {
  if ! cmd_exists "brew"; then
    log "Installing homebrew."
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  else
    debug "Homebrew already installed."
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
  log "Installing packages with Homebrew.  Please be patient!"
  if $verbose; then
    brew bundle -v --file="${BREWFILE}"
  else 
    brew bundle --file="${BREWFILE}"
  fi
}

osx_cleanup() {
  return 0
}

osx_main() {
  osx_install_xcode
  osx_install_homebrew
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
  if cmd_exists "git"; then 
    debug "Git is already installed."
    return 0
  else
    debug "Installing Git."
    "${ostype}_install_git"
  fi
}


# ---------------------------------------------------------------------------
# Main functions 
# ---------------------------------------------------------------------------

# Use GNU stow to populat
# Use GNU Stow to link config files stored in the dotfiles dir.
link_configs() {
  debug "Linking config files."
  local dirs=(
    bash
    config
    emacs
    fish
    git
    nvim
    tmux
    vim
    zsh
  )

  cd "${DOTFILES}"

  for dir in "${dirs[@]}"; do
    stow --target="${HOME}" --restow "${dir}"
  done
}


setup_zsh() {
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


display_cmd_usage () {
  cat << 'EOF'

Usage: cmd [-Bcv] [-a a_arg] arg1 ...

  v : run in verbose mode to print debugging statements. 

  a : do something with a_arg

  arg1 : used for something

EOF
}

parse_args() {
  local OPTIND
  while getopts ":a:vhq" opt; do
    case "${opt}" in
      a)
        # option -a is set with argument $OPTARG
        debug "Option -a is set with argument: ${OPTARG}"
        ;;
      v)
        verbose=true 
        debug "In verbose mode."
        ;;
      h)
        # print help message
        display_cmd_usage
        ;;
      q)
        quick=true
        debug "In quick mode.  No packages will be installed."
        ;;
      \?)
        log "Invalid option: -${OPTARG}"
        display_cmd_usage >&3
        exit 1
        ;;
      :)
        log "Option -${OPTARG} requires an argument"
        display_cmd_usage >&3
        exit 1
        ;;
    esac
  done
}

# Set additional variables used within the script.
init() {
  # Append to both console and log. In particular, external programs will
  # still push things to the console and log.
  # http://stackoverflow.com/questions/18460186/writing-outputs-to-log-file-and-console
  exec > >(tee -a "${DOTFILES_LOG}" )
  exec 2> >(tee  -a "${DOTFILES_LOG}" >&2) 

  parse_args "${@}"
  set_ostype
  update_path

}

# We prefer to link config files into an already existing dir so that
# rather than linking an entire config dir.  One benefit is that
# program generated files are automatically not in the repo.  A downside
# is that it's yet another (hopefully static) thing to manage.
make_dirs() {
  local home_dirs=(
    .emacs.d
    .spacemacs.d
    .vim
    .aws
    .sbt
    bin
    var/log
  )

  local xdg_config_dirs=(
    fish
    git
    micro
    nvim
    omf
    tmux
    zsh
  )
  
  mkdir -p "${DEPS}"

  # Make dirs that live directly in the home dir.
  for dir in "${home_dirs[@]}"; do
    mkdir -p "${HOME}/${dir}"
  done

  # Make dirs that live in $XDG_CONFIG_HOME
  for dir in "${xdg_config_dirs[@]}"; do
    mkdir -p "${XDG_CONFIG_HOME}/${dir}"
  done
}

# Get external dependencies that are not otherwise managed.
get_deps() {
  if $quick; then
    debug "In quick mode.  Not getting external deps."
    return 0
  fi


  uget_gh_repo "zsh-users/zsh-history-substring-search"
  uget_gh_repo "zsh-users/zsh-syntax-highlighting"
  uget_gh_repo "zsh-users/zsh-completions"
  uget_gh_repo "zsh-users/zsh-autosuggestions"
}


# Install some programming fonts.
install_fonts() {
  if $quick; then
    debug "In quick mode.  Skipping font installation" 
    return 0
  fi

  # NOTE: Tue, 16 Feb 2016 08:50:28 -0800
  # Brew cask has a fonts project that can automate this process somewhat.
  
  # Font repos that come with an install script.
  # NOTE: nerd-fonts is a huge repo.
  local repos=(
    "powerline/fonts" 
    # "ryanoasis/nerd-fonts"
  )

  for repo in "${repos[@]}"; do
    debug "Updating ${repo}."
    uget_gh_repo "${repo}"
    cd "${DEPS}/${repo}"
    debug "Installing ${repo}."
    bash install.sh
  done
} 

# OS independent package installation function.  Skip if in quick mode.
install_pkgs() {
  if $quick; then
    debug "In quick mode.  Skipping package installation."
    return 0
  fi

  debug "Installing packages."
  "${ostype}_install_pkgs"
  get_deps
  install_fonts
}


main() {
  # stdout and stderr -> log, but leave fd 3 -> console
  log "Begin."
  init "${@}"

  install_git
  get_git_repo "${DOTFILES_REPO}" "${DOTFILES}"
  make_dirs

  # Call the OS specific main subfunction. This is responsible for additional
  # setup and teardown.
  "${ostype}_main"

  # Install pkgs and additional dependencies.
  install_pkgs

  link_configs
  "${ostype}_cleanup"
  log "Finished."
}

main "${@}" 
