#!/usr/bin/env zsh
# Provide plugin related commands.

# cmd passed to plug.zsh when it is sourced by a script in bin
declare -r cmd="$1"

# function repo() {
#   # Delete longest matach of */.
#   return "${1##*/}"
# }

# Write a line to the init.zsh file that sources the input plugin.
# - $1 is owner/repo
# - [$2] is an optional file to source that resides in the repo. If not provided,
#   attempt to use repo.zsh or repo.plugin.zsh
function plug::cache() {
  # Attempt to source either <name>.zsh or <name>.plugin.zsh
  local dir="${ZPLUGIN_HOME}/repos/$1"
  shift 1

  # Parse optional args:
  for arg in "$@"; do
    case $arg in
      (use*)
        local use="${arg#*=}"
        ;;
    esac
  done

  if (($+use)); then
    local plugin="${dir}/${use}"
  else
    local repo="${dir##*/}" # repo sans ownername
    local plugin="${dir}/${repo}.zsh"
    if [[ ! -e "${plugin}" ]]; then;
      plugin="${dir}/${repo}.plugin.zsh"
    fi
  fi

  echo "Caching ${plugin}"
  echo "source ${plugin}" >> "${ZPLUGIN_HOME}/cache/plugins.zsh"

}

# Get and/or update the git repo
function plug::install() {
  # TODO: Support local plugins?
  local dir="${ZPLUGIN_HOME}/repos/$1"
  if [[ ! -e "${dir}" ]]; then
    echo "Plugin $1 does not exist. Downloading."
    local src="https://github.com/$1"
    git clone --recursive "${src}" "${dir}"
  else
    echo "Updating plugin $1 in ${dir}"
    cd "${dir}"
    [[ -d ".git" ]] && git diff-index --quiet HEAD && git pull
  fi
}

# Function called in plugins.zsh. It's behavior depends on the command param
# passed when this file is sourced.
function plug() {
  case $cmd in
    (install|cache)
      "plug::$cmd" "${@}"
      ;;
    (*)
      echo "Command $cmd not recognized."
      exit 0
      ;;
  esac
}

