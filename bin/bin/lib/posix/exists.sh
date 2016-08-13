#!/bin/sh
# -------------------------------------------------------------------------
# core.sh contains posix compliant core utility functions
# -------------------------------------------------------------------------

# Determine whether a type $1 object $2 exists in a POSIX safe manner.
# Valid types are "file", "dir", "link", "cmd".
# Note that the -v option of `command` is part of the standard since
# 2008: http://stackoverflow.com/questions/34572700/is-command-v-option-required-in-a-posix-shell-is-posh-compliant-with-posix
# When the hash bang is /bin/sh, the exit codes of hash and type are not
# well-defined.
exists() {
  if [ -z "${2}" ]; then
    echo "exists: Error.  Usage: exists type object"
    exit 2
  fi

  case "${1}" in
    "file" | "-f")
      if [ -f "${2}" ]; then return 0; else return 1; fi
      ;;
    "link" | "-L")
      if [ -L "${2}" ]; then return 0; else return 1; fi
      ;;
    "dir" | "-d")
      if [ -d "${2}" ]; then return 0; else return 1; fi
      ;;
    "cmd" | "-c")
      if command -v "${2}" >/dev/null 2>&1; then return 0; else return 1; fi
      ;;
    *)
      echo "exists: Error. Unsupported type: ${1}"
      exit 2
  esac
}




# as in the exists command.
require() {
  if ! exists "${1}" "${2}"; then
    echo --error "${1} ${2} required to install configuration. Exiting"
    exit 1
  fi
  return 0
}
