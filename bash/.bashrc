[ -f ~/.profile ] && source ~/.profile

if [ -f "${XDG_CONFIG_HOME}/profile/path" ]; then
  source "${XDG_CONFIG_HOME}/profile/path" 
fi
HISTFILE="${XDG_STATE_HOME}/bash_history"
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
