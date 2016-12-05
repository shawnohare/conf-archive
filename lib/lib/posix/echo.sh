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
      "--debug" | "-d")
        shift
        if [ ! -z ${debug+x} ] && $debug; then
          printf "%s: " "${echo_prefix} DEBUG: ${*}"
        fi
        ;; 
      "--verbose" | "-v")
        shift
        if [ ! -z ${verbose+x} ] && $verbose; then
          printf "%s: " "${echo_prefix} ${*}"
        fi
        return 0
        ;;
      *)
        printf "%s\n" "${echo_prefix} ${*}"
        return 0
        ;;
    esac
  done
}
