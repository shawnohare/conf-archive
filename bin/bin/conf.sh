#!/usr/bin/env bash

# TODO
# 1. Better initialization
# 2. Consider using /opt/dotfiles/ or ~/opt/dotfiles for dotfiles dependencies rather than
#    the XDG_DATA_HOME location?
# 2. Consider putting the hist file in ~/var/zsh/history or something

# ---------------------------------------------------------------------------
# Global Constants 
# These will be set to the value of
# the corresponding environment variable if that variable is set and
# not null, or to the default substitution listed after the :-
# We follow the convention that add-ons go in ~/opt and logs in ~/var
# For the XDG specification, one good resource is:
# https://wiki.debian.org/XDGBaseDirectorySpecification
# ---------------------------------------------------------------------------
readonly XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}"
readonly XDG_DATA_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}"
readonly XDG_CACHE_HOME="${XDG_CACHE_HOME:-${HOME}/.cache}"
readonly XDG_STATE_HOME="${XDG_STATE_HOME:-${HOME}/.state}"

readonly DOTFILES_NAME="${DOTFILES_NAME:-dotfiles}"
readonly DOTFILES_REPO="${DOTFILES_REPO:-https://github.com/shawnohare/dotfiles.git}"
readonly DOTFILES_DEPS="${DOTFILES_DEPS:-${HOME}/opt}"
readonly LOGFILE="${LOGFILE:-${HOME}/var/log/dotfiles/conf.log}"
readonly DOTFILES="${DOTFILES:-${HOME}/${DOTFILES_NAME}}"
readonly BREWFILE="${BREWFILE:-${DOTFILES}/homebrew/.config/homebrew/Brewfile}"


# ---------------------------------------------------------------------------
# Global variables 
# true/false are functions that return 0/1, resp.
# ---------------------------------------------------------------------------
declare ostype
declare verbose=false 
declare dry=false
declare logging=false

# # ---------------------------------------------------------------------------
# # General helper funcs. 
# # ---------------------------------------------------------------------------


# Print a time-stamped message.
# When the --debug or --verbose flags are passed, the statement will
# be printed only when the global verbose flag is also set.
echo() {
  local err=false
  while true; do
    case $1 in
      "--debug" | "--verbose" | "-d" | "-v")
        $verbose || return 0
        shift
        ;;
      "--error" | "-e")
        err=true
        shift
        ;;
      *)
        break
        ;;
    esac
  done

  local msg="[${0}] $(date "+%Y-%m-%d %H:%M:%S")  ${@}\n" 
  if $err; then
    printf "${msg}" >&2
  else
    printf "${msg}"
  fi
  return 0
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
  if [[ ! "${PATH}" =~ "usr.local" ]]; then
    echo --debug "Appending /usr/local to PATH."
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
  echo --debug "Setting ostype var."
  case "${OSTYPE}" in 
    darwin*)
      ostype="macos"
      ;;
    linux*)
      ostype="linux"
      ;;
    *)
      return 1
     ;;
  esac
  echo --debug "ostype value: ${ostype}"
}

# Clone <remote repo> <local destination>
# Usage: get_git_repo [...] remote local
# update (to update the git repository if exists already)
get_git_repo() {
  local update=false

  while true; do
    case $1 in
      "--update" | "-u")
        update=true
        shift
        ;;
      *)
        break
        ;;
    esac
  done

  local remote="$1"
  local loc="$2"


  # Error if both arguments are not provided. 
  if [[ -z "${remote+x}" || -z "${loc+x}" ]]; then
    echo --debug "No remote or no local dir specified."
    return 1
  fi

  echo --debug "Checking for git repo in ${loc}"
  if [[ ! -d "${loc}" ]]; then
    echo --debug "Cloning ${remote} to ${loc}"
    mkdir -p "${loc}"
    git clone --recursive "${remote}" "${loc}"
    return 0
  else
    echo --debug "Dir ${loc} already exists."
  fi

  if $update; then
    echo --debug "Updating ${remote} in ${loc}  "
    cd "${loc}"

    # Check whether there are changes.
    if ! $(git diff --quiet); then
      echo --debug "There are local unstaged changes in ${loc}.  Not updating repo."
      return 1
    fi  

    if ! $(git diff --cached --quiet); then
      echo --debug "There are staged, uncomitted changes in ${loc}.  Not updating repo."
      return 1
    fi
    echo --debug "Updated git repo in ${loc}"
  fi
}

# Get or update a config dependency hosted by Github.
# Wrapper for get_git_repo
get_github_dep() {
  local repo="$1";
  if [[ -z "${repo+x}" ]]; then
    echo --debug "Repository name required."
    exit 1
  fi
  get_git_repo -u "https://github.com/${repo}.git" "${DOTFILES_DEPS}/${repo}"
}

# ---------------------------------------------------------------------------
# OS X Specific functions 
# ---------------------------------------------------------------------------

# Install Xcode command line developer tools (required for git/Homebrew)
# Check whether the exit code of is not 0 (success).
# (command) runs the command in a subshell.
macos_install_xcode() {
  if ! (xcode-select --print-path 1>/dev/null); then
    echo "Installing xcode command line tools."
    (xcode-select --install)
  else
    echo --debug "Xcode command line tools are already installed."
  fi
}

# In bash, hash <command> exits with with 0 iff the command exists.
# For POSIX compliance, can use: command -v foo >/dev/null 2>&1
macos_install_homebrew() {
  if ! cmd_exists "brew"; then
    echo "Installing homebrew."
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  else
    echo --debug "Homebrew already installed."
  fi
}

# Convenience function to install git
macos_install_git() {
  macos_install_xcode
}

macos_install() {
  while true; do
    case $1 in
      "xcode" | "git")
        macos_install_xcode
        shift
        break
        ;;
      "brew" | "homebrew")
        macos_install_homebrew
        shift
        break
        ;;
      *)
        brew install "${@}"
        break
        ;;
    esac
  done

  return 0
}


# Use brew bundler to install useful external programs listed in the Brewfile.
macos_install_all() {
  brew tap Homebrew/bundle
  echo "Installing packages with Homebrew.  Please be patient!"
  if $verbose; then
    brew bundle -v --file="${BREWFILE}"
  else 
    brew bundle --file="${BREWFILE}"
  fi
}


macos_init() {
  macos_install_xcode
  macos_install_homebrew
  return 0
}

macos_teardown() {
  return 0
}

# ---------------------------------------------------------------------------
# Generic (OS independent) package-related functions.
# ---------------------------------------------------------------------------


# Attempt to install the input package. This function assumes that the
# appropriate package manager has been previously installed.  It is
# essentially a small wrapper for the OS specific install command.
install() {
  # Do nothing if the command already exists.
  local pkg=$1
  if cmd_exists "${pkg}"; then 
    # do nothing
    echo --debug "${1} is already installed."
    return 0
  fi

  echo "Installing ${pkg}"
  "${ostype}_install" "${pkg}" 
  return 0
}

# Call the OS specific install git function.
install_git() {
  if cmd_exists "git"; then 
    echo --debug "Git is already installed."
    return 0
  else
    echo --debug "Installing Git."
    "${ostype}_install_git"
  fi
}



# ---------------------------------------------------------------------------
# Main functions 
# ---------------------------------------------------------------------------

setup_zsh() {
  echo "Setting up zsh."
  install "zsh"
  local zsh_path="$(which zsh)"
  echo --debug "zsh path: ${zsh_path}"

  # Append Homebrewed zsh path to /etc/shells to authorize it as a login shell
  if [[ -z $(grep "${zsh_path}" /etc/shells) ]]; then 
    echo "Adding ${zsh_path} to /etc/shells."
    printf "${zsh_path}" | sudo tee -a /etc/shells
  fi

  # Change this user's default shell to Homebrewed zsh
  if [[ ${SHELL} != "${zsh_path}" ]]; then
    echo "Changing this user's default shell to zsh."
    chsh -s "${zsh_path}" "${USER}"
  fi
  return 0
}


# Get external dependencies that are not otherwise managed.
get_deps() {
  if $dry; then
    echo "Dry run.  Not getting external repos."
    return 0
  fi


  get_github_dep "zsh-users/zsh-history-substring-search"
  get_github_dep "zsh-users/zsh-syntax-highlighting"
  get_github_dep "zsh-users/zsh-completions"
  get_github_dep "zsh-users/zsh-autosuggestions"
  get_github_dep "powerline/fonts"
  # Install powerline fonts.
  bash "${XDG_DATA_HOME}/powerline/fonts/install.sh"
}


# OS independent package installation function.  Skip if in quick mode.
install_all() {
  if $dry; then
    echo --debug "In drymode.  Skipping package installation."
    return 0
  fi

  echo --debug "Installing packages."
  "${ostype}_install_all"
}


display_help() {
  cat << 'EOF'

Usage: dotfiles.sh [-hvq] [-a a_arg] [cmd] 

Arguments:

-a arg : do something with a_arg
-h : print this help message.
-l : echo to the echofile specified in the LOGFILE env variable.
-v : run in verbose mode to print debugging statements.
-q : run in quick mode.  No packages are installed. Deprecated.  Use commands.

Commands:

install 

Does everything.


link [--all|-a] [...]

Link all dotfiles.  This will copy the directory substructure of each
dotfiles dir and then use GNU stow to symlink the contents.  The --all flag
is not necessary, and provided for semantic purposes.  Additional arguments
for the stow command are passed through.  For example
  link --restow : calls stow dir --restow



link --dir|-d dir [...]

Link a single directory, using the same logic as with the link command.

EOF
}

# extract any options with getopts
parse_opts() {
  OPTIND=1
  while getopts ":a:dlvh" opt "${@}"; do
    case "${opt}" in
      a)
        # option -a is set with argument $OPTARG
        echo "Option -a is set with argument: ${OPTARG}"
        ;;
      d)
        dry=true
        echo "Dry run.  No packages will be installed."
        ;;
      h)
        # print help message
        display_help
        exit 0
        ;;
      l)
        logging=true
        ;;
      v)
        verbose=true 
        echo "In verbose mode."
        ;;
      \?)
        echo "Invalid option: -${OPTARG}"
        display_help
        exit 1
        ;;
      :)
        echo "Option -${OPTARG} requires an argument"
        display_help
        exit 1
        ;;
    esac
  done
}


# link a dotfiles dir to the home dir.  
# First copy the directory's structure, and then use GNU stow to 
# link the files.  This setup ensures that program data does not
# accidentally end up in the dotfiles directories, which can happen
# when entire directories are linked.
# TODO: it might be nice to remove the dependency on stow here.
link_dir() {
  local dir="${1}"
  echo "Linking ${dir}"
  shift
  cd "${DOTFILES}/${dir}"
  find . -type d -exec mkdir -p -- ${HOME}/{} \;
  cd "${DOTFILES}"
  # call stow with the link_dir options
  stow --verbose "${@}" --target="${HOME}" "${dir}" 
}

# link each folder in the dotfiles root to the home dir.
cmd_link() {
  cd "${DOTFILES}"

  local ignores="emacs|ignore"
  while true; do
    case $1 in
      "--dir" | "-d")
        shift
        link_dir "${@}"
        break
        ;;
      "--ignore" | "-i")
        shift
        ignores="${1}|${ignores}"
        shift
        ;;
      "--all")
        shift
        ;;
      *)
        echo --debug "Ignoring ${ignores}"
        for path in *; do
          [[ -d ${path} ]] || continue # skip non-dirs
          if [[ ${path} =~ ${ignores} ]]; then
            echo "Not linking ignored dir ${path}"
            continue
          fi
          link_dir "$(basename "${path}")" "${@}"
        done
        break
        ;;
    esac
  done

}

cmd_deps() {
  get_deps
  "${ostype}_teardown"
}

cmd_install() {
  echo "Installing dotfiles."
  cmd_deps
  setup_zsh
  # TODO manually install these big packages perhaps
  # install_pkgs
  cmd_link
  echo "Finished."
}

# FIXME for testing purposes
cmd_zsh() {
  setup_zsh
  exit 0
}

# makes dirs, sets the shell, etc.
cmd_init() {
  echo "Initializing."
  cd ${HOME}
  mkdir -p "${XDG_CONFIG_HOME}"
  mkdir -p "${XDG_DATA_HOME}"
  mkdir -p "${XDG_CACHE_HOME}"
  mkdir -p "${XDG_STATE_HOME}"
  mkdir -p "${HOME}/bin"
  mkdir -p "${HOME}/var/log"
  mkdir -p "${HOME}/tmp/"
  mkdir -p "${HOME}/opt/"
  install_git
  install "stow" # symlink farm
  get_git_repo "${DOTFILES_REPO}" "${DOTFILES}" # fetch the dotfiles repo
  setup_zsh

}

parse_cmd() {
  local cmd="${1}"
  case "${cmd}" in
    deps | init | install | link | zsh )
      # Execute the named command and pass it the args that follow.
      # For example, "cmd_${@}" could expand to cmd_foo arg1 arg2 arg3.
      "cmd_${@}"
      ;;
    *)
      echo "Command ${cmd} not recognized".
      display_help
      exit 1
      ;;
  esac
}



main() {
  # init
  parse_opts "${@}"
  shift $((OPTIND - 1)) # shift past options to sub-commands 
  "${ostype}_init"
  set_ostype
  update_path
  echo --debug "Input commands: ${@}"

  # Set up echoging, if necessary.  This is controlled by the -l option. 
  if $logging; then
    # Append to both console and log. In particular, external programs will
    # still push things to the console and echo.
    # http://stackoverflow.com/questions/18460186/writing-outputs-to-echo-file-and-console
    exec > >(tee -a "${LOGFILE}" )
    exec 2> >(tee  -a "${LOGFILE}" >&2) 
    echo "Logging to ${LOGFILE}"
  fi


  if [[ -z "${1}" ]]; then
    display_help
  else
    parse_cmd "${@}"
  fi
  return 0
}

main "${@}"

