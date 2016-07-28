[ -f ~/.profile ] && source ~/.profile
profile_set_path # path setter func in .profile
HISTFILE="${XDG_STATE_HOME}/bash_history"
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
