# [ -f ~/.fzf.bash ] && source ~/.fzf.bash
# NOTE: iterm shell integration messes with the prompt and causes
# emacs tramp mode to hang indefinitely.
# if [[ "$TERM" != "dumb" ]] && [ -e "${HOME}/.iterm2_shell_integration.bash" ]; then
#   source "${HOME}/.iterm2_shell_integration.bash"
# fi

# interactive, login shell will source ~/.bash_profile, then ~/.bash_login, then ~/.profile
# interactive, non-login will source ~/.bashrc
# It probably makes sense to have ~/.bash_profile source ~/.bashrc
# and put most interactive logic in ~/.bashrc

HISTFILE="${XDG_DATA_HOME}/bash/history"
