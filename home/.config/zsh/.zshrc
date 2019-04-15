# zshrc is sourced by interactive shells.
# /etc/zprofile and ~/.profile are sourced before.

source "${HOME}/.profile" > /dev/null 2>&1

# ----------------------------------------------------------------------------
# Load plugins.
# We have some basic custom logic for managing plugins. Basic profiling
# suggests its only about 100-200ms faster loading than zplug.

# plug(plugin_repo, relative_path_to_source)
function plug() {
    # Get everything after last slash.
    local pkg="${SHDATA}/plugins/${1##*/}"
    local src="${pkg}/$2"
    if [[ ! -e "${src}" ]]; then
        git clone --recursive --depth 1 "https://github.com/$1" "${pkg}"
    fi
    source "${src}"
}

plug "junegunn/fzf" "shell/completion.zsh"
plug "junegunn/fzf" "shell/key-bindings.zsh"
plug "rupa/z" "z.sh"
plug "zsh-users/zsh-completions" "zsh-completions.plugin.zsh"
plug "zsh-users/zsh-autosuggestions" "zsh-autosuggestions.zsh"
plug "hlissner/zsh-autopair" "autopair.zsh"
plug "zsh-users/zsh-syntax-highlighting" "zsh-syntax-highlighting.zsh"
plug "zsh-users/zsh-history-substring-search" "zsh-history-substring-search.zsh"

# ----------------------------------------------------------------------------
fpath=(${SHDATA}/completions ${SHDATA}/plugins/zsh-completions $fpath)
autoload -U compinit && compinit

# ----------------------------------------------------------------------------
# NOTE: iterm shell integration messes with the prompt and causes
# emacs tramp mode to hang indefinitely.
# if [[ $TERM == "dumb" ]]; then
#   unsetopt zle
#   unsetopt prompt_cr
#   unsetopt prompt_subst
#   unfunction precmd
#   unfunction preexec
#   PS1='$ '
#   return
# fi

bindkey -v

# changing dirs
autoload -U chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
autoload -U zmv

# ----------------------------------------------------------------------------
# Completion (derived from http://dustri.org/b/my-zsh-configuration.html)
# Some of these might be taken care of by oh-my-zsh/lib/completion
zmodload -i zsh/complist
setopt hash_list_all
setopt completealiases
setopt always_to_end
setopt complete_in_word
setopt correct
setopt list_ambiguous

zstyle ':completion::complete:*' use-cache on               # completion caching, use rehash to clear
zstyle ':completion:*' cache-path "${SHDATA}/zsh"     # cache path
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'   # ignore case
zstyle ':completion:*' menu select=2                        # menu if nb items > 2
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}       # colorz !
zstyle ':completion:*::::' completer _expand _complete _ignored _approximate # list of completers to use

# sections completion
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

# ----------------------------------------------------------------------------
# help
autoload -Uz run-help
autoload -Uz run-help-git
autoload -Uz run-help-svn
autoload -Uz run-help-svk
unalias run-help &> /dev/null
# alias help=run-help
#
# ----------------------------------------------------------------------------
# history
HISTFILE="${SHDATA}/history"
HISTSIZE=2048                    # lines to maintain in memory
SAVEHIST=100000                  # lines to maintain in history file
setopt share_history             # share hist between sessions
setopt extended_history          # include timestamps
# setopt inc_append_history_time   # add commands as they are typed,
# setopt hist_ignore_all_dups      # no duplicate
unsetopt hist_ignore_space       # ignore space prefixed commands
setopt hist_reduce_blanks        # trim blanks
setopt hist_verify               # show before executing history commands
setopt bang_hist                 # !keyword

# ----------------------------------------------------------------------------
# zsh-autosuggestions
# ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE=fg=008
bindkey '^L' autosuggest-accept
# NOTE: Accepting an autosuggestion leads to weird highlighting.

# highlights
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
ZSH_HIGHLIGHT_STYLES[bracket-level-1]='fg=white,bold'
ZSH_HIGHLIGHT_STYLES[bracket-level-2]='fg=yellow,bold'
ZSH_HIGHLIGHT_STYLES[bracket-level-3]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[bracket-level-4]='fg=magenta,bold'
# ZSH_HIGHLIGHT_STYLES[cursor]='bg=black'
ZSH_HIGHLIGHT_STYLES[default]=none
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=red'
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=magenta,bold'
ZSH_HIGHLIGHT_STYLES[alias]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=magenta,bold'
ZSH_HIGHLIGHT_STYLES[command]='fg=magenta'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=magenta,bold'
ZSH_HIGHLIGHT_STYLES[function]='fg=blue'
ZSH_HIGHLIGHT_STYLES[commandseparator]='bold'
ZSH_HIGHLIGHT_STYLES[hashed-command]='fg=blue'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[path]='fg=blue,bold'
ZSH_HIGHLIGHT_STYLES[path_pathseparator]='fg=blue,bold'
ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=61,bold'
ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]='bold'
ZSH_HIGHLIGHT_STYLES[path_approx]='fg=magenta'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=166'
ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=bold'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=009
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg=009
ZSH_HIGHLIGHT_STYLES[assign]='fg=magenta'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=green'


# zsh-completions
# zsh-history-substring-search
# vim-like snippet keybindings for history-substring-search
bindkey '^[[A' history-substring-search-up
bindkey '^K' history-substring-search-up
bindkey '^J' history-substring-search-down
bindkey '^[[B' history-substring-search-down

HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='fg=red,bold'
# HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bg=yellow,fg=black'
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='bg=red,fg=black,bold'
# HISTORY_SUBSTRING_SEARCH_GLOBBING_FLAGS='i'
# HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=''
# HISTORY_SUBSTRING_SEARCH_FUZZY=''

# ----------------------------------------------------------------------------
# options
setopt autocd
setopt extendedglob
setopt nomatch
setopt notify

# ----------------------------------------------------------------------------
# prompt
autoload -Uz vcs_info
# autoload -U colors && colors
setopt PROMPT_SUBST
# setopt TRANSIENT_RPROMPT

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git:*' formats "(%%F{magenta}%b%f%u%c)"
# zstyle ':vcs_info:git:*' formats "(%b%u%c)"
zstyle ':vcs_info:git:*' stagedstr '%F{yellow}+%f'
zstyle ':vcs_info:git:*' unstagedstr '%F{red}✴%f'
precmd() {
  vcs_info
}



# The %{...%} delimiters tells zsh the text has zero width. Since v 4.3 it's
# probably better to use the %F{color}...%f syntax.
# user="%F{yellow}%B%n%b%f"
# machine="%B%m%b"
user="%F{green}%B%n%b%f"
machine="%m"
dir="%F{blue}%B%3~%f%b"
date="%F{cyan}%D{%Y-%m-%dT%T}%f"
indicator="❯"
PROMPT='${user}@${machine} ${dir} ${vcs_info_msg_0_}
%(?.%F{blue}.%F{red})${indicator}%f '
# %(?.%F{green}.%F{red}%? )${indicator}%f ' the %? yields output of last cmd


# Simplified prompt
# indicator="⛩️"
# PROMPT='${user}@${machine}: ${dir} ${indicator}  '

# Fun unicode we can interpolate
# ● ✺ ✴
# ⇨ → 🐉 ➤ ⛩️
# ⥲

# All the fzf script does is update path to include fzf bin and source
# completions / keybindings.
# source "${XDG_CONFIG_HOME}/fzf/fzf.zsh" > /dev/null 2>&1
