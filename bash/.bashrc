[ -f ~/.profile ] && source ~/.profile

# iterm shell integration messes with the prompt and causes
# emacs tramp mode to hang indefinitely.
[[ $TERM == "dumb" ]] && return

#
# Bash specific settings
#
# HISTFILE="${XDG_STATE_HOME}/bash_history"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash


if [[ "$TERM" != "dumb"]] && [ -e "${HOME}/.iterm2_shell_integration.bash" ]; then
  source "${HOME}/.iterm2_shell_integration.bash"
fi

