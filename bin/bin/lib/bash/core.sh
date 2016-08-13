#!/usr/bin/env bash

# require the type $1 object $2 to exist.  The valid types are the same
# Append to both console and log $1. In particular, external programs will
# still push things to the console and echo.
# http://stackoverflow.com/questions/18460186/writing-outputs-to-echo-file-and-console
log_to() {
  exec > >(tee -a "${1}" )
  exec 2> >(tee  -a "${1}" >&2)
  echo "Logging to ${1}"
}

# Attempt to determine the OS type and set the ostype var for use in
# dynamic function dispatch.
# For more information on detecting the OS type see:
# - http://stackoverflow.com/questions/3466166/how-to-check-if-running-in-cygwin-mac-or-linux
# - http://stackoverflow.com/questions/394230/detect-the-os-from-a-bash-script
# In particular, note that bash sets the OSTYPE env variable.
set_ostype() {
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
}
