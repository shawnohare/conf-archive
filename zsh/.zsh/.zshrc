#########################################################################
# zshrc is loaded for interactive shells 
# TOC
# - aliases
# - bindkeys
# - colors
# - exports
# - functions 
# - history 
# - modules
# - options
# - prompt
#########################################################################

#########################################################################
# aliases
#########################################################################
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias act="activator" # for Typesafe activator
alias dots="cd ${DOTFILES}"
alias la="ls -GFlash"
alias ll="ls -GFlsh"
alias ls="ls -GF"


#########################################################################
# bindkeys 
#########################################################################
# vim normal mode keybindings
bindkey -v 


#########################################################################
# colors 
# All of these settings enable consistent coloring of the most frequently
# used parts of the CLI. For historical reasons 'ls', 'less', 'grep', and
# the completion menu all require separate color settings.
#########################################################################

# Enable command line color
export CLICOLOR=1
# Define colors for the 'ls' command on BSD/Darwin
# export LSCOLORS='exfxcxdxbxGxDxabagacad'
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


#########################################################################
# Completion (derived from http://dustri.org/b/my-zsh-configuration.html)
#########################################################################

autoload -U compinit
compinit
zmodload -i zsh/complist
setopt hash_list_all            # hash everything before completion
setopt completealiases          # complete alisases
setopt always_to_end            # when completing from the middle of a word, move the cursor to the end of the word    
setopt complete_in_word         # allow completion from within a word/phrase
setopt correct                  # spelling correction for commands
setopt list_ambiguous           # complete as much of a completion until it gets ambiguous.

zstyle ':completion::complete:*' use-cache on               # completion caching, use rehash to clear
zstyle ':completion:*' cache-path ~/.zsh/cache              # cache path
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'   # ignore case
zstyle ':completion:*' menu select=2                        # menu if nb items > 2
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}       # colorz !
zstyle ':completion:*::::' completer _expand _complete _ignored _approximate # list of completers to use

# sections completion !
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format $'\e[00;34m%d'
zstyle ':completion:*:messages' format $'\e[00;31m%d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:manuals' separate-sections true

zstyle ':completion:*:processes' command 'ps -au$USER'
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always
zstyle ':completion:*:*:kill:*:processes' list-colors "=(#b) #([0-9]#)*=29=34"
zstyle ':completion:*:*:killall:*' menu yes select
zstyle ':completion:*:killall:*' force-list always
users=(jvoisin root)           # because I don't care about others
zstyle ':completion:*' users $users

#generic completion with --help
compdef _gnu_generic gcc
compdef _gnu_generic gdb


#########################################################################
# exports
#########################################################################


#########################################################################
# exports
#########################################################################


#########################################################################
# functions 
#########################################################################


#########################################################################
# history 
#########################################################################

HISTFILE=${ZDOTDIR}/.zsh_history # where to store zsh config
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


#########################################################################
# modules 
# External modules/add-ons to zsh
# Should be the final thing sourced by zshrc.
#########################################################################

mods_dir="${DEPS}/zsh-users"

# ===========================================================================
# zsh-autosuggestions
# ===========================================================================

# source "${mods_dir}/zsh-autosuggestions/zsh-autosuggestions.zsh"
# export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE=fg=246

# ===========================================================================
# zsh-completions
# ===========================================================================
# fpath=(/usr/local/share/zsh-completions $fpath)
fpath=(${mods_dir}/zsh-completions $fpath)

# ===========================================================================
# zsh-history-substring-search
# ===========================================================================
# vim-like snippet keybindings for history-substring-search
source ${mods_dir}/zsh-history-substring-search/zsh-history-substring-search.zsh
bindkey '^[[A' history-substring-search-up
bindkey '^K' history-substring-search-up
bindkey '^[[B' history-substring-search-down


# ===========================================================================
#  zsh-syntax-highlighting
# ===========================================================================

source ${DEPS}/zsh-users/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# Fri, 29 Jan 2016 16:44:49 -0800 
# It's not clear whether we actually need to set these values when using
# iterm2, as the colors might be over-ridden by iterm2's color scheme.
# Tries to be Solarized-ish
# 166 = orange
# Enable highlighters
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
# brackets
ZSH_HIGHLIGHT_STYLES[bracket-level-1]='fg=blue'
ZSH_HIGHLIGHT_STYLES[bracket-level-2]='fg=166'
ZSH_HIGHLIGHT_STYLES[bracket-level-3]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[bracket-level-4]='fg=magenta'
# cursor
ZSH_HIGHLIGHT_STYLES[cursor]='bg=black'
# main
# default & unknown
ZSH_HIGHLIGHT_STYLES[default]=none
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=red'
# command
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[alias]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=green'
ZSH_HIGHLIGHT_STYLES[function]='fg=166'
ZSH_HIGHLIGHT_STYLES[command]='fg=green'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=violet'
ZSH_HIGHLIGHT_STYLES[commandseparator]=none
ZSH_HIGHLIGHT_STYLES[hashed-command]='fg=blue'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=yellow'
# path
ZSH_HIGHLIGHT_STYLES[path]='fg=blue'
ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=61'
ZSH_HIGHLIGHT_STYLES[path_approx]='fg=magenta'
# shell
ZSH_HIGHLIGHT_STYLES[globbing]='fg=166'
ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=blue'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]=cyan
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=009
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg=009
ZSH_HIGHLIGHT_STYLES[assign]='fg=magenta'
# quotes
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=cyan'


#########################################################################
# options 
#########################################################################
# zsh optionso
# - Options are primarily referred to by name. 
# These names are case insensitive and underscores are ignored.
# For example, 'allexport' is equivalent to 'A__lleXP_ort'.
# - Comments reference the command below.
# - More information at man zshoptions.

# If a command is a dir name---and not a regular command---cd in. 
setopt autocd 
# Treat the '#', '~' and '^' chars as part of patterns for filename generation, etc.
setopt extendedglob 
# If a pattern for filename generation has no matches, print an error.
setopt nomatch
# Report the status of background jobs immediately. 
setopt notify



#########################################################################
# prompt 
#########################################################################

setopt PROMPT_SUBST      # allow for more extensive expansion in prompts
setopt TRANSIENT_RPROMPT # right prompt does not persist
# hostname: cwd [exit status] %

autoload -Uz vcs_info

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git:*' formats '%u%c%{%F{green}%}[%b]%{%f%} '
zstyle ':vcs_info:git:*' stagedstr '%{%F{yellow}%}+%{%f%}'
zstyle ':vcs_info:git:*' unstagedstr '%{%F{red}%}*%{%f%}'
precmd() {
  vcs_info
}

prompt_indicator='%{%F{yellow}%}>%{%f%}' # prompt indicator
curr_dir='%{%F{blue}%}%1~%{%f%}'         # current directory
exit_codes='%(?..%{%F{yellow}%}%?'       # exit codes
# PROMPT+='%{$%} '                       # $ indicator
PROMPT='${curr_dir} ${vcs_info_msg_0_}${prompt_indicator} '
# RPROMPT='%*'                           # time and date


# The following lines were added by compinstall
#zstyle :compinstall filename '/Users/shawn/.zshrc'
# End of lines added by compinstall

# source all config files: FIXME: old, can probably delete 
# for file in "${ZDOTDIR}"/*.zsh; do
#   source "${file}"
# done

# iterm2 shell integration
# source "${DOTFILES}/iterm2/iterm2_shell_integration.zsh"


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
