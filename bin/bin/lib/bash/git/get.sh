#!/usr/bin/env bash
#
display_help() {
  cat << 'EOF'
  
  A small wrapper for git clone / git pull.  Fetch a repo if it does not
  exist, and optionally try to pull the latest version if it does exist
  and is in a clean state.

  Usage: get [--update] remote local

EOF
}

# Usage: get [--update] remote local
git_get() {
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
  if [ -z "${remote+x}" ] || [ -z "${loc+x}" ]; then
    display_help
    exit 1
  fi

  if [[ ! -d "${loc}" ]]; then
    mkdir -p "${loc}"
    git clone --recursive "${remote}" "${loc}"
    return 0
  fi

  if $update; then
    cd "${loc}" || exit 1

    # Check whether there are changes.
    if ! git diff --quiet; then
      return 1
    fi

    if ! git diff --cached --quiet; then
      return 1
    fi

    git pull
  fi
}

git_get "${@}"
