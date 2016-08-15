# export XDG_DATA_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}"
# export PYTHON_VENV_HOME="${PYTHON_VENV_HOME:-${XDG_DATA_HOME}/python/venvs}"

# interactive shell wrapper for the pyve executable.  This exists so
# virtual envs can be activated in a shell by a user, and should be
# sourced by .profile (or the equivalent). In contrast,
# a virtual activated by the executable will only persist for the
# life of the executable, which is spawned in a sub-shell.
pyve() {
  mkdir -p "${PYTHON_VENV_HOME}"
  local cmd="${1}"
  shift

  case "${cmd}" in

    use | act | activate)
      local f="${PYTHON_VENV_HOME}/${1}/bin/activate"
      if [ -e "${f}" ]; then
        echo "Activating ${PYTHON_VENV_HOME}/${1}."
        source "${f}"
      else
        echo "Virtual env ${1} does not exist."
        return 1
      fi
      ;;

    *)
      "${DOTFILES_BIN_HOME}/pyve/bin/pyve" "${@}"
      ;;
   esac

   return 0
}
