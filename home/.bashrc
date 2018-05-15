# [ -f ~/.fzf.bash ] && source ~/.fzf.bash
# NOTE: iterm shell integration messes with the prompt and causes
# emacs tramp mode to hang indefinitely.
# if [[ "$TERM" != "dumb" ]] && [ -e "${HOME}/.iterm2_shell_integration.bash" ]; then
#   source "${HOME}/.iterm2_shell_integration.bash"
# fi

HISTFILE="${USER_CONFIG_HOME}/bash/history"
source "${USER_CONFIG_HOME}/rc.sh" > /dev/null 2>&1

