[ -f ~/.profile ] && source ~/.profile

#
# Bash specific settings
#
HISTFILE="${XDG_STATE_HOME}/bash_history"

if [ -e "${HOME}/.iterm2_shell_integration.bash" ]; then
  source "${HOME}/.iterm2_shell_integration.bash"
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
