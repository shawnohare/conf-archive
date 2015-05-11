# All of these settings enable consistent coloring of the most frequently
# used parts of the CLI. For historical reasons 'ls', 'less', 'grep', and
# the completion menu all require separate color settings.

# Enable command line color
export CLICOLOR=1
# Define colors for the 'ls' command on BSD/Darwin
export LSCOLORS='exfxcxdxbxGxDxabagacad'
# Define colors for the zsh completion system
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=36;01:cd=33;01:su=31;40;07:sg=36;40;07:tw=32;40;07:ow=33;40;07:'

# The pager 'less' (the default pager for man-pages) depends on
# the (obsolete) TERMCAP library for color capabilities. Exporting
# the following parameters provides for colored man-page display.
export LESS_TERMCAP_mb=$'\E[01;31m'    # begins blinking = LIGHT_RED
export LESS_TERMCAP_md=$'\E[0;34m'     # begins bold = BLUE
export LESS_TERMCAP_me=$'\E[0m'        # ends mode = NO_COLOR
export LESS_TERMCAP_se=$'\E[0m'        # ends standout-mode = NO_COLOR
export LESS_TERMCAP_so=$'\E[00;47;30m' # begins standout-mode = REVERSE_WHITE
export LESS_TERMCAP_ue=$'\E[0m'        # ends underline = NO_COLOR
export LESS_TERMCAP_us=$'\E[01;32m'    # begins underline = LIGHT_GREEN

# The following provide color highlighing by default for GREP
# export GREP_COLOR='37;45'
export GREP_OPTIONS='--color=auto'


