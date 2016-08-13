
# Usage: get_git_repo [--update] remote local
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
  if [ -z "${remote+x}" || -z "${loc+x}" ]; then
    echo "No remote or no local dir specified."
    exit 1
  fi

  if [[ ! -d "${loc}" ]]; then
    mkdir -p "${loc}"
    git clone --recursive "${remote}" "${loc}"
    return 0
  else
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
