# Source for purely interactive shells, i.e., shells invoked after login.

# =========================================================================
# aliases
# =========================================================================
case "${OSTYPE}" in
  (linux*)
    alias la="ls --color -Flash"
    alias ll="ls --color -Flsh"
    alias ls="ls --color -F"
    ;;
  # darwin*) source "${XDG_CONFIG_HOME}/macos";;
  # *bsd*) source "${XDG_CONFIG_HOME}/bsd";;
  (**)
    alias ls="ls -GF"
    alias la="ls -GFlash"
    alias ll="ls -GFlsh"
    ;;
esac

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias emc="emacsclient"
