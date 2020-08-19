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

alias la="ls -GFlashi"
alias ll="ls -GFlshi"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias emc="emacsclient"
alias ci="code-insiders"



