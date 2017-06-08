# ======================================================================
# init
# ======================================================================

# Set shell independent settings.
[ -e ~/.profile ] && source ~/.profile


# ===========================================================================
# plugins
# ===========================================================================
# Load plugins.
# We have some basic custom logic for managing plugins. Basic profiling
# suggests its only about 100-200ms faster loading than zplug.
# If using our custom logic:
fpath=(${ZPLUGIN_HOME}/zsh-users/zsh-completions $fpath)
autoload -U compinit && compinit
source "${ZPLUGIN_HOME}/init.zsh"
#
# If using zplug:
# fpath=(${ZPLUGIN_HOME}/zsh-users/zsh-completions $fpath)
# if [[ ! -d "${ZPLUG_HOME}" ]]; then
#   curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh| zsh
# fi
# source "${ZPLUG_HOME}/init.zsh"
# zplug check --verbose || zplug install
# zplug load


# NOTE: iterm shell integration messes with the prompt and causes
# emacs tramp mode to hang indefinitely. There are some attempts to fix
# this throughout.
# TODO: We should determine whether emacs tramp move works with shell
# integration turned off.
if [[ $TERM == "dumb" ]]; then
  unsetopt zle
  unsetopt prompt_cr
  unsetopt prompt_subst
  unfunction precmd
  unfunction preexec
  PS1='$ '
  return
fi

# ======================================================================
# bindkeys
# ======================================================================
# vim normal mode keybindings
bindkey -v

# changing dirs
autoload -U chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs


# ======================================================================
# Completion (derived from http://dustri.org/b/my-zsh-configuration.html)
# ======================================================================
# Some of these might be taken care of by oh-my-zsh/lib/completion
zmodload -i zsh/complist
setopt hash_list_all            # hash everything before completion
setopt completealiases          # complete alisases
setopt always_to_end            # when completing from the middle of a word, move the cursor to the end of the word
setopt complete_in_word         # allow completion from within a word/phrase
setopt correct                  # spelling correction for commands
setopt list_ambiguous           # complete as much of a completion until it gets ambiguous.

zstyle ':completion::complete:*' use-cache on               # completion caching, use rehash to clear
zstyle ':completion:*' cache-path "${ZDOTDIR}/.cache"              # cache path
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
zstyle ':completion:*' users $users

#generic completion with --help
compdef _gnu_generic gcc
compdef _gnu_generic gdb

# -------------------------------------------------------------------------
# help
# -------------------------------------------------------------------------
autoload -Uz run-help
autoload -Uz run-help-git
autoload -Uz run-help-svn
autoload -Uz run-help-svk
unalias run-help
# alias help=run-help

# ======================================================================
# history
# ======================================================================

HISTFILE="${XDG_STATE_HOME}/zsh_history"
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


# ===========================================================================
# zsh-autosuggestions
# ===========================================================================

# export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE=fg=246

# ===========================================================================
# zsh-completions
# ===========================================================================

# ===========================================================================
# zsh-history-substring-search
# ===========================================================================
# vim-like snippet keybindings for history-substring-search
bindkey '^[[A' history-substring-search-up
bindkey '^K' history-substring-search-up
bindkey '^J' history-substring-search-down
bindkey '^[[B' history-substring-search-down


# ===========================================================================
#  zsh-syntax-highlighting
# ===========================================================================
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
ZSH_HIGHLIGHT_STYLES[bracket-level-1]='fg=blue'
ZSH_HIGHLIGHT_STYLES[bracket-level-2]='fg=166'
ZSH_HIGHLIGHT_STYLES[bracket-level-3]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[bracket-level-4]='fg=magenta'
ZSH_HIGHLIGHT_STYLES[cursor]='bg=black'
ZSH_HIGHLIGHT_STYLES[default]=none
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=red'
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[alias]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=green'
ZSH_HIGHLIGHT_STYLES[command]='fg=green'
ZSH_HIGHLIGHT_STYLES[function]='fg=magenta'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=violet'
ZSH_HIGHLIGHT_STYLES[commandseparator]=none
ZSH_HIGHLIGHT_STYLES[hashed-command]='fg=blue'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[path]='fg=blue'
ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=61'
ZSH_HIGHLIGHT_STYLES[path_approx]='fg=magenta'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=166'
ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=blue'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]=cyan
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=009
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg=009
ZSH_HIGHLIGHT_STYLES[assign]='fg=magenta'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=cyan'


# ======================================================================
# options
# ======================================================================
setopt autocd
setopt extendedglob
setopt nomatch
setopt notify



# ======================================================================
# prompt
# ======================================================================
# FIXME this does not work it seems.  Delete?
# Avoid emacs hanging when attempting to connect remotely.
# https://www.emacswiki.org/emacs/TrampMode#t
[[ $TERM == "dumb" ]] && unsetopt zle && PS1='$ ' && return

autoload -Uz vcs_info
autoload -U colors && colors
setopt PROMPT_SUBST
# setopt TRANSIENT_RPROMPT

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git:*' formats "%s:${fg_bold[magenta]}%b${reset_color}%u%c"
zstyle ':vcs_info:git:*' stagedstr '%{%F{yellow}%}+%{%f%}'
zstyle ':vcs_info:git:*' unstagedstr '%{%F{red}%}✴%{%f%}'
precmd() {
  vcs_info
}
# ● ✺ ✴

user="${fg_bold[green]}%n${reset_color}"
machine="%B%m%b"
dir="${fg_bold[blue]}%3~${reset_color}"
date="${fg_bold[cyan]}%D{%Y-%m-%dT%T}${reset_color}"
indicator=">%{${reset_color}%}"
PROMPT='${user}@${machine}: ${dir} ${vcs_info_msg_0_}
%(?.${fg_bold[magenta]}.${fg_bold[red]})${indicator} '
# Some other start symbols
# ⇨ → 🐉 ➤ ⛩️
# ⥲
#

# Emacs hangs when connecting remotely via tramp mode.
# if [[ "$TERM" != "dumb" ]] &&  [ -e "${HOME}/.iterm2_shell_integration.zsh" ]; then
#   source "${HOME}/.iterm2_shell_integration.zsh"
# fi

# fzf is installed as a vim-plugin
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
