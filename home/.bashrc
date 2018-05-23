# [ -f ~/.fzf.bash ] && source ~/.fzf.bash
# NOTE: iterm shell integration messes with the prompt and causes
# emacs tramp mode to hang indefinitely.
# if [[ "$TERM" != "dumb" ]] && [ -e "${HOME}/.iterm2_shell_integration.bash" ]; then
#   source "${HOME}/.iterm2_shell_integration.bash"
# fi

HISTFILE="${XDG_CONFIG_HOME}/bash/history"
source "${XDG_CONFIG_HOME}/sh/rc.sh" > /dev/null 2>&1

