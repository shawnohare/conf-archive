#!/bin/sh
echo() {
  # prefix="[${0}] $(date "+%Y-%m-%d %H:%M:%S")"

  while true; do
    case $1 in
      "--error" | "-e")
        shift
        >&2 printf "%s\n" "${0} Error: ${*}"
        return 0
        ;;
      "--prompt" | "-p")
        shift
        printf "%s: " "${0} ${*}"
        return 0
        ;;
      *)
        printf "%s\n" "${0} ${*}"
        return 0
        ;;
    esac
  done
}
