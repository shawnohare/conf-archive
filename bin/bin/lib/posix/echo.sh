#!/bin/sh
echo() {
  # echo_prefix="[${0}] $(date "+%Y-%m-%d %H:%M:%S")"
  echo_prefix="[${0}]"

  while true; do
    case $1 in
      "--error" | "-e")
        shift
        >&2 printf "%s\n" "${echo_prefix} Error: ${*}"
        return 0
        ;;
      "--prompt" | "-p")
        shift
        printf "%s: " "${echo_prefix} Prompt: ${*}"
        return 0
        ;;
      *)
        printf "%s\n" "${echo_prefix} ${*}"
        return 0
        ;;
    esac
  done
}
