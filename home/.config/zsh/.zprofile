# Run automatically (before zshrc) if the shell is a login shell.
# Login: The shell is run as part of the login of the user to the system.
# Typically used to do any configuration to establish a work-environment.
# An session of zsh used by a terminal emulator is typically both login and
# interactive, whereas an invocation of zsh is purely interactive.

source "${HOME}/.profile" > /dev/null 2>&1

pyenv() {
  local command
  command="${1:-}"
  if [ "$#" -gt 0 ]; then
    shift
  fi

  case "$command" in
  activate|deactivate|rehash|shell)
    eval "$(pyenv "sh-$command" "$@")";;
  *)
    command pyenv "$command" "$@";;
  esac
}

# export -f pyenv
eval "$("${PYENV_ROOT}/bin/pyenv" virtualenv-init -)"
