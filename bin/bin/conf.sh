#!/usr/bin/env bash

# TODO
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
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-${HOME}/.cache}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-${HOME}/.state}"
export XDG_BIN_HOME="${XDG_BIN_HOME:-${HOME}/.local/bin}"
export XDG_LIB_HOME="${XDG_LIB_HOME:-${HOME}/.local/lib}"
export XDG_OPT_HOME="${XDG_OPT_HOME:-${HOME}/.local/opt}"
export XDG_TMP_HOME="${XDG_TMP_HOME:-${HOME}/.local/tmp}"
export XDG_VAR_HOME="${XDG_VAR_HOME:-${HOME}/.local/var}"

# FIXME brewfile is deprecated
export BREWFILE="${BREWFILE:-${DOTFILES}/homebrew/.config/homebrew/Brewfile}"
export DOTFILES_NAME="${DOTFILES_NAME:-dotfiles}"
export DOTFILES_REPO="${DOTFILES_REPO:-https://github.com/shawnohare/dotfiles.git}"
export DOTFILES="${DOTFILES:-${HOME}/${DOTFILES_NAME}}"
export LOGFILE="${LOGFILE:-${XDG_VAR_HOME}/dotfiles/log}"
export PYENV_ROOT="${PYENV_ROOT:-${XDG_BIN_HOME}/stow/pyenv}"

# ensure the path includes local binaries in case we are in an odd state
export PATH="${HOME}/.nix-profile/bin:${HOME}/bin:${XDG_BIN_HOME}:/usr/local/bin:${PATH}"


# ---------------------------------------------------------------------------
# Global variables 
# true/false are functions that return 0/1, resp.
# ---------------------------------------------------------------------------
declare ostype # macos, linux, etc.
declare distro # empty, debian, nixos, etc.
declare verbose=false 
declare dry=false
declare logging=false
declare prompt_user=false

# # ---------------------------------------------------------------------------
# # General helper funcs. 
# # ---------------------------------------------------------------------------

# Print a time-stamped message.
# When the --debug or --verbose flags are passed, the statement will
# be printed only when the global verbose flag is also set.
echo() {
  local err=false
  local prompt=false
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
      "--prompt" | "-p")
        prompt=true
        shift
        ;;
      *)
        break
        ;;
    esac
  done

  local prefix="[${0}] $(date "+%Y-%m-%d %H:%M:%S")" 
  $dry && prefix="${prefix} (dry run)"
  local msg="${prefix} ${@}"

  if $prompt; then 
    msg="${msg}: "
  else
    msg="${msg}\n"
  fi

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
  command -v "$1" >/dev/null 2>&1
}

# tests whether a package has been installed by nix
is_pkg_installed() {
  nix-env -q "$1" >/dev/null 2>&1;
} 


# require a command to exist.  Exit with an error if it does not.
require() {
  local cmd=$1
  if ! posix_exists "${cmd}"; then 
    echo --error "${cmd} required to install configuration. Exiting"
    exit 1
  fi
  return 0
}



# idempotently install the nix package manager.
get_nix() {
  if ! posix_exists "nix-env"; then
    echo "Installing the nix package manager."
    sudo mkdir /nix
    $dry || curl "https://nixos.org/nix/install" | sh
  fi
}

# install pyenv
get_pyenv() {
  if ! posix_exists "pyenv"; then
    echo "Installing pyenv."
    $dry || curl -L "https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer" | bash
  fi
  # link the pyenv binary
  $dry || ln -s "${PYENV_ROOT}/bin/pyenv" "${XDG_BIN_HOME}/pyenv" 
  $dry || eval "$(${PYENV_ROOT}/bin/pyenv init -)"
}


# get a pkg using nix if it does not already exist
get_pkg() {
  local pkg=$1
  if ! is_pkg_installed ${pkg}; then
    echo "Installing ${pkg}."
    $dry || nix-env --install "${pkg}"
  else
    echo --debug "Package ${pkg} already installed."
  fi
}

# ensure a command $1 exists.  If it doesn't, install $2 with nix.  If it does
# exist but is not managed by nix, prompt the user if they want to install
# with nix.
ensure() {
  local cmd=$1
  local pkg=$2
  if [ -z "${pkg}" ]; then pkg="${cmd}"; fi

  if ! posix_exists ${cmd}; then
    get_pkg "${pkg}"
    return 0
  fi

  # cmd exists, but it's not installed by nix.
  if ! is_pkg_installed ${cmd}; then
    local get_nix_version=true
    if $prompt_user; then
      echo --prompt "A non-nix ${cmd} exists.  Install with nix? (y/n)" 
      read a
      [ "${a}" = "n" ] && get_nix_version=false
    fi

    $get_nix_version && get_pkg "${cmd}"
  fi
  return 0
}

# ---------------------------------------------------------------------------
# Inititialization 
# These functions are rather fine-grained so that they are easier to debug.
# ---------------------------------------------------------------------------

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
    if ! $dry; then
      mkdir -p "${loc}"
      git clone --recursive "${remote}" "${loc}"
    fi
    return 0
  else
    echo --debug "Git repo in ${loc} exists."
  fi

  if $update; then
    echo --debug "Updating git repo in ${loc}  "
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

    $dry || git pull
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
  get_git_repo -u "https://github.com/${repo}.git" "${XDG_OPT_HOME}/${repo}"
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
macos_install_homebrew() {
  if ! cmd_exists "brew"; then
    echo "Installing homebrew."
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  else
    echo --debug "Homebrew already installed."
  fi
}




macos_init() {
  macos_install_xcode
  # macos_install_homebrew
  return 0
}

macos_teardown() {
  return 0
}


# ---------------------------------------------------------------------------
# linux specific functions 
# ---------------------------------------------------------------------------

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
        echo --verbose "Running: ${install} ${opts} ${pkg}"
        $dry || ${install} ${pkg}
      done
      ;;
  esac
  return 0
}


# ---------------------------------------------------------------------------
# Main functions 
# ---------------------------------------------------------------------------

setup_zsh() {
  echo "Setting up zsh."
  local zsh_path="$(which zsh)"
  echo --debug "zsh path: ${zsh_path}"

  # Append Homebrewed zsh path to /etc/shells to authorize it as a login shell
  if [[ -z $(grep "${zsh_path}" /etc/shells) ]]; then 
    echo "Adding ${zsh_path} to /etc/shells."
    $dry || printf "${zsh_path}" | sudo tee -a /etc/shells
  fi

  # Change this user's default shell to Homebrewed zsh
  if [[ ${SHELL} != "${zsh_path}" ]]; then
    echo "Changing this user's default shell to zsh."
    $dry || chsh -s "${zsh_path}" "${USER}"
  fi
  return 0
}


# Get external dependencies that are not otherwise managed.
get_config_deps() {
  get_git_repo "${DOTFILES_REPO}" "${DOTFILES}"
  get_github_dep "zsh-users/zsh-history-substring-search"
  get_github_dep "zsh-users/zsh-syntax-highlighting"
  get_github_dep "zsh-users/zsh-completions"
  get_github_dep "zsh-users/zsh-autosuggestions"
  get_github_dep "powerline/fonts"
  # Install powerline fonts.
  $dry || bash "${XDG_OPT_HOME}/powerline/fonts/install.sh"
}


display_help() {
  cat << 'EOF'

Usage: dotfiles.sh [-hvq] [-a a_arg] [cmd] 

Arguments:

-a arg : do something with a_arg
-d : Execute a dry-run.  The system state is not changed.
-h : print this help message.
-l : echo to the logfile specified in the LOGFILE env variable.
-v : run in verbose mode to print debugging statements.

Commands:

init ostype [distro] [pkg install cmd]

  Put the system in a state where the rest of the configuration
  commands will work.  This will create the necessary directories
  and install external tools needed to get packages and link configs.

  Example usages: 

    init macos
    init linux debian
    init linux debian "nix-env -i"


install 

  Fully install the dotfiles.  This is equivalent to calling the subcommands
  init followed by link.


link [--all|-a] [...]

  Link all dotfiles.  This will copy the directory substructure of each
  dotfiles dir and then use GNU stow to symlink the contents.  The --all flag
  is not necessary, and provided for semantic purposes.  Additional arguments
  for the stow command are passed through.  For example
    link --restow : calls stow dir --restow

link --dir|-d [--restow|-r] dir [target]

  Link a single directory.  This will copy the dir's structure and symlink
  any files. If the --restow flag is set, existing symlinks
  are removed and re-linked.

EOF
}

# extract any options with getopts
parse_opts() {
  OPTIND=1
  while getopts ":a:dhlpv" opt "${@}"; do
    case "${opt}" in
      a)
        # option -a is set with argument $OPTARG
        echo "Option -a is set with argument: ${OPTARG}"
        ;;
      d)
        dry=true
        echo "Dry run. State will not change." 
        ;;
      h)
        # print help message
        display_help
        exit 0
        ;;
      l)
        logging=true
        ;;
      p)
        prompt_user=true
        echo "User prompts enabled." 
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
# FIXME: deprecated
link_dir() {
  local dir="${1}"
  echo "Linking ${dir}"
  shift
  cd "${DOTFILES}/${dir}"

  # copy dir struct
  $dry || find . -type d -exec mkdir -p -- ${HOME}/{} \;
  cd "${DOTFILES}"
  # call stow with the link_dir options

  local opts 
  $verbose && opts="--verbose"
  opts="${opts} ${@}"
  $dry || stow ${opts} --target="${HOME}" "${dir}" 
}


# A crude version of the GNU stow command.  Behavior is similar, except
# that the default target is the home directory.
# TODO make this a wrapper for gnu stow tht makes dirs
dotfiles_stow() {
  local tar="${HOME}"
  local restow=false

  # see if a target was passed
  while true; do
    case $1 in
      "--restow" | "-R")
        restow=true
        shift
        ;;
      --target=* | -t=*)
        tar="${1#*=}"
        shift 1 
        ;;
      *)
        break
        ;;
    esac
  done

  # Parse the source dir
  if [ -z "${1}" ]; then
    echo --error "No source dir passed.  Exiting."
    exit 1
  fi
  local src="${1}"
  shift

  # check to make sure the source dir exists.
  if [ ! -d "${src}" ]; then
    echo --error "Source dir ${src} does not exist.  Exiting."
    exit 1
  fi

  echo "Linking ${src}"

  # cd "${DOTFILES}/${src}"
  cd ${src}

  # Copy the dir structure to the target and symlink any config files.
  # in bash > v4 you can recurse using for x in **, but os x ships with bash v3
  for path in $(find .); do
    local dest="${tar}/${path}"

    # case that the path is a dir
    # Make the dir
    if [ -d "${path}" ]; then
      if [ ! -d "${dest}" ]; then
        echo --debug "Making dir: ${dest}"
        $dry || mkdir -p "${dest}" 
        continue
      fi
    fi

    # Check if the destination file already exists.
    # If it does not exist, link from the dotfiles config.
    # If it's a link, remove if we are restowing, otherwise do nothing.
    # If it exists and is not a link, ask to back it up and then link.
    if [ -f "${path}" ]; then
      # initial existence check
      if [ -e "${dest}" ]; then
        if [ -L "${dest}" ]; then
          if $restow; then
            echo --debug "Removing link ${dest}" 
            $dry || rm "${dest}"
          fi
        else # file exists and is not a link
          # Backup file.
          local should_backup=true
          if $prompt_user; then
            echo --prompt "Non-linked ${dest} already exists.  Backup and replace with link to dotfiles version? (y/n)"
            read a
            [ "${a}" = n ] && should_backup=false
          fi
          if $should_backup; then
            local bk="${dest}.$(date "+%Y-%m-%dT%H:%M:%S").backup"
            echo --debug "Backing up ${dest} to ${bk}"
            $dry || mv "${dest}" "${bk}"
          fi
        fi
      fi

      # Create a symlink from the dotfiles config to the destination.
      if [ ! -e "${dest}" ]; then
        local fullpath="${DOTFILES}/${src}/${path}"
        echo --debug "Linking ${fullpath} to ${dest}"
        $dry || ln -s "${fullpath}" "${dest}"
      fi

      continue
    fi
  done

  cd ..
  return 0
}

#------------------------------------------------------------------------- 
# commands
# Commands are responsible that required packages are installed.
# This leads to some minor duplication, but means that the checking
# occurs in a common location.
#------------------------------------------------------------------------- 
# link each folder in the dotfiles root to the home dir.
cmd_link() {

  cd "${DOTFILES}"
  local ignores="emacs|ignore"
  local ignores=(emacs ignore )
  while true; do
    case $1 in
      --dir=* | -d=*)
        local dir="${1#*=}"
        shift
        dotfiles_stow "${dir}" "${@}"
        break
        ;;
      --ignore=* | -i=*)
        local ig="${1#*=}"
        shift
        ignores+=("${ig}") # append 
        ;;
      "--all")
        shift
        ;;
      *)
        echo --debug "Ignoring ${ignores}"
        for path in *; do

          # Determine if the path is ignored
          local is_ignored=false
          for ignore in "${ignores[@]}"; do
            if [ "${path}" == "${ignore}" ]; then
              echo "Not linking ignored dir ${path}"
              is_ignored=true
              break
            fi
          done
          $is_ignored && continue

          [[ -d "${path}" ]] || continue # skip non-dirs
          dotfiles_stow ${@} "$(basename "${path}")" 
        done
        break
        ;;
    esac
  done

}

# get external dependencies such as zsh modules
# FIXME for testing purposes really
cmd_deps() {
  ensure "git"
  get_config_deps
  "${ostype}_teardown"
}

# inititialize the os ($1) & distro ($2) with the optional install command ($3).
# This should put things into a state where all the other commands work.
cmd_init() {
  local ostype="${1}"
  local distro="${2}"
  local install_cmd="${3}"
  # Check that the os type is valid.
  if [[ ! "${ostype}" =~ macos|linux ]]; then
      echo --error "Cannot initialize: OS Type ${ostype} not supported."
      exit 1
  fi

  # perform the ostype, distro specific initialization
  "${ostype}_init" "${distro}" "${install_cmd}"

  cd ${HOME}

  # make dirs
  echo --debug "Making necessary dirs."
  if ! $dry; then
    if [ ! -d "/nix" ]; then
      # wrapped in the conditional so we don't always prompt for password
      sudo mkdir /nix 
    fi
    mkdir -p "${XDG_CONFIG_HOME}"
    mkdir -p "${XDG_DATA_HOME}"
    mkdir -p "${XDG_CACHE_HOME}"
    mkdir -p "${XDG_STATE_HOME}"
    mkdir -p "${XDG_BIN_HOME}"
    mkdir -p "${XDG_LIB_HOME}"
    mkdir -p "${XDG_TMP_HOME}"
    mkdir -p "${XDG_OPT_HOME}"
    mkdir -p "${XDG_VAR_HOME}"

    mkdir -p "${HOME}/bin"
    # mkdir -p "${HOME}/var/log"
    mkdir -p "${HOME}/tmp/"
    # mkdir -p "${HOME}/opt/"
  fi

  # get a minimal set of tools required for the config script
}

cmd_python() {
  require "curl"

  # Define the stable versions of python
  local vmain="3.5.2"
  local v3="${vtools}"
  local v2="2.7.12"

  get_pyenv
  pyenv="${PYENV_ROOT}/bin/pyenv"

  # create virtual envs for neovim
  # NOTE: the versions here should be updated occasionally
  if ! $dry; then
     ${pyenv} install "${v2}" 
     ${pyenv} install "${v3}" 
     ${pyenv} virtualenv "${v2}" "neovim2"
     ${pyenv} virtualenv "${v3}" "neovim3"
  fi
  local venvs=( "neovim2" "neovim3" )
  for venv in ${venvs[@]}; do
    echo --debug "Creating neovim venv ${venv}"
    if ! $dry; then
      ${pyenv} activate "${venv}"
      pip install --upgrade pip
      pip install "neovim"
      pip install "jedi"
      ${pyenv} deactivate
    fi
  done

  # link some python binaries to ~/bin so they are available to external
  # programs, regardless of the current python environment.
  echo "Installing and linking python binaries."
  if ! $dry; then
    ${pyenv} global "${vmain}" "${v3}" "${v2}" 
    local mods=( flake8 autoflake pylint ipython )
    for mod in "${mods[@]}"; do
      pip install "${mod}"
      ${pyenv} rehash
      ln -s "${PYENV_ROOT}/versions/${vmain}/bin/${mod}" "${XDG_BIN_HOME}/${mod}"
    done
  fi
  return 0
}

cmd_neovim() {
  require "curl"

  # install neovim: maybe this should be done via source?
  ensure "nvim" "neovim"
  cmd_python
}

# FIXME for testing purposes
cmd_zsh() {
  ensure "zsh"
  setup_zsh
  exit 0
}

cmd_install() {
  echo "Installing dotfiles."

  # Get some basic packages, create dirs, etc.
  cmd_init

  # get 
  get_nix
  get_pkg "git"
  get_pkg "zsh"

  get_config_deps
  setup_zsh
  cmd_neovim
  cmd_link
  echo "Finished installing."
}

parse_cmd() {
  local cmd="${1}"
  # Execute the named command and pass it the args that follow.
  # For example, "cmd_${@}" could expand to cmd_foo arg1 arg2 arg3.
  case "${cmd}" in
    init | install | link)
      "cmd_${@}"
      ;;
    neovim | python | zsh)
      "cmd_${@}"
      ;;
    deps)
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
  set_ostype # FIXME: do we care?
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

