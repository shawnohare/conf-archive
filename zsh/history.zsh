HISTFILE=$ZDOTDIR/.zsh_history # where to store zsh config
HISTSIZE=2048                    # lines to maintain in memory
SAVEHIST=65536                   # lines to maintain in history file
setopt extended_history          # include timestamps
setopt append_history            # append
setopt hist_ignore_all_dups      # no duplicate
unsetopt hist_ignore_space       # ignore space prefixed commands
setopt hist_reduce_blanks        # trim blanks
setopt hist_verify               # show before executing history commands
setopt inc_append_history        # add commands as they are typed, don't wait until shell exit
setopt share_history             # share hist between sessions
setopt bang_hist                 # !keyword
