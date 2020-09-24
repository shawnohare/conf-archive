# Source for purely interactive shells, i.e., shells invoked after login.
# Most configuration here is for bash-style shells (e.g., zsh)
# TODO: Could set this up as pre, post so that shell specific RCs can source
# common things in whatever order makes sense.

# =========================================================================
# aliases
# =========================================================================
case "${OSTYPE}" in
    linux*)
        alias ls="ls --color -GF"
        ;;
    **)
        if [ $(command -v gls) 1> /dev/null ]; then
            alias ls="gls --color -GF"
        else
            alias ls="ls -GF"
        fi
        ;;
esac

if [[ "$OSTYPE" == "darwin"* ]]; then
  if [ -f "/Applications/Emacs.app/Contents/MacOS/Emacs" ]; then
    alias emacs="env TERM=screen-24bit /Applications/Emacs.app/Contents/MacOS/Emacs"
    alias emacscnw="env TERM=screen-24bit /Applications/Emacs.app/Contents/MacOS/Emacs -nw"
    export EMACS="/Applications/Emacs.app/Contents/MacOS/Emacs"
  fi

  if [ -f "/Applications/Emacs.app/Contents/MacOS/bin/emacsclient" ]; then
    alias emc="env TERM=screen-24bit /Applications/Emacs.app/Contents/MacOS/bin/emacsclient"
  fi
else
    alias emc="emacsclient"
fi

alias la="ls -GFlashi"
alias ll="ls -GFlshi"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias code="code-insiders"



