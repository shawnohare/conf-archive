# zshrc is sourced by interactive shells.
# /etc/zprofile and ~/.zprofile are sourced before.

# aliases
export ISHELL="zsh"

# ============================================================================
# aliases
# ============================================================================
case "${OSTYPE}" in
    linux*)
        alias ls="ls --color -GF"
        ;;
    **)
        if [ $(command -v gls) 1> /dev/null ]; then
            alias ls="gls --color -GF"
        else
            alias ls="ls -GF"
        fi
        ;;
esac

alias la="ls -GFlashi"
alias ll="ls -GFlshi"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias emc="emacsclient"
alias code="code-insiders"
alias oni="oni2"
alias vi="nvim"
alias pyv="conda activate"





# ----------------------------------------------------------------------------
# Load plugins.
# We have some basic custom logic for managing plugins. Basic profiling
# suggests its only about 100-200ms faster loading than zplug.

# plug(github_repo, relative_path_to_source)
function plug() {
    # Get everything after last slash.
    # local pkg="${ZSHPLUGINS}/${1##*/}"
    local pkg="${ZSHPLUGINS}/$1"
    if [[ ! -e "${pkg}" ]]; then
        git clone --recursive --depth 1 "https://github.com/$1" "${pkg}"
    fi
    source "${pkg}/$2"
}

plug "junegunn/fzf"                           "shell/completion.zsh"
plug "junegunn/fzf"                           "shell/key-bindings.zsh"
# NOTE: z.lua can be used instead or z.sh
# plug "rupa/z"                                 "z.sh"
# when using z-lua installed via nix:
# eval "$(z --init enhanced zsh 2&> /dev/null)"
# But it's also available as a zsh plugin it seems.
plug "skywind3000/z.lua"                      "z.lua.plugin.zsh"
plug "zsh-users/zsh-completions"              "zsh-completions.plugin.zsh"
plug "zsh-users/zsh-autosuggestions"          "zsh-autosuggestions.zsh"
plug "hlissner/zsh-autopair"                  "autopair.zsh"
plug "zsh-users/zsh-syntax-highlighting"      "zsh-syntax-highlighting.zsh"
plug "zsh-users/zsh-history-substring-search" "zsh-history-substring-search.zsh"
plug "esc/conda-zsh-completion"               "conda-zsh-completion.plugin.zsh"


# source "${PYENV_ROOT}/completions/pyenv.zsh"
# ----------------------------------------------------------------------------
fpath=(${ZSHDATA}/completions ${ZSHPLUGINS}/zsh-users/zsh-completions ${PYENV_ROOT}/completions $fpath)
fpath+=${ZSHDATA}/conda-zsh-completion
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
zstyle ':completion:*' cache-path "${ZSHDATA}/zsh"     # cache path
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
HISTFILE="${ZSHDATA}/history"
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

# ----------------------------------------------------------------------------
# highlights

# Set which highlighters to use.
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor root)

# Bracket highlights
ZSH_HIGHLIGHT_STYLES[cursor-matchingbracket]='fg=black,bg=yellow'
ZSH_HIGHLIGHT_STYLES[bracket-error]='fg=red,bold'
ZSH_HIGHLIGHT_STYLES[bracket-level-1]='fg=white,bold'
ZSH_HIGHLIGHT_STYLES[bracket-level-2]='fg=yellow,bold'
ZSH_HIGHLIGHT_STYLES[bracket-level-3]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[bracket-level-4]='fg=magenta,bold'

# Cursor highlights.  Not setting can cause invisible cursor in vi mode.
ZSH_HIGHLIGHT_STYLES[cursor]='bg=black'

# Main highlights
ZSH_HIGHLIGHT_STYLES[unknown-token]='none'
ZSH_HIGHLIGHT_STYLES[reserved-word]='none'
ZSH_HIGHLIGHT_STYLES[alias]='none'
ZSH_HIGHLIGHT_STYLES[suffix-alias]='none'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=magenta,bold'
ZSH_HIGHLIGHT_STYLES[function]='fg=blue'
ZSH_HIGHLIGHT_STYLES[command]='fg=magenta'
ZSH_HIGHLIGHT_STYLES[precommand]='none'
ZSH_HIGHLIGHT_STYLES[commandseparator]='none'
ZSH_HIGHLIGHT_STYLES[hashed-command]='none'
ZSH_HIGHLIGHT_STYLES[path]='none'
ZSH_HIGHLIGHT_STYLES[path_pathseparator]='none'

# ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=red'
# ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=magenta,bold'
# ZSH_HIGHLIGHT_STYLES[alias]='fg=yellow'
# ZSH_HIGHLIGHT_STYLES[builtin]='fg=magenta,bold'
# ZSH_HIGHLIGHT_STYLES[command]='fg=magenta'
# ZSH_HIGHLIGHT_STYLES[precommand]='fg=magenta,bold'
# ZSH_HIGHLIGHT_STYLES[function]='fg=blue'
# ZSH_HIGHLIGHT_STYLES[commandseparator]='bold'
# ZSH_HIGHLIGHT_STYLES[hashed-command]='fg=blue'
# ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=yellow'
# ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=yellow'
# ZSH_HIGHLIGHT_STYLES[path]='fg=blue,bold'
# ZSH_HIGHLIGHT_STYLES[path_pathseparator]='fg=blue,bold'
# ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=61,bold'
# ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]='bold'
# ZSH_HIGHLIGHT_STYLES[path_approx]='fg=magenta'
# ZSH_HIGHLIGHT_STYLES[globbing]='fg=166'
# ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=bold'
# ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='fg=cyan'
# ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=009
# ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg=009
# ZSH_HIGHLIGHT_STYLES[assign]='fg=magenta'
# ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=cyan'
# ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=green'

# prefixes of existing filenames
ZSH_HIGHLIGHT_STYLES[path_prefix]='none'
# path separators in prefixes of existing filenames (/); if unset, path_prefix is used (default)
ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]='none'
# globbing expressions (*.txt)
ZSH_HIGHLIGHT_STYLES[globbing]='none'
# history expansion expressions (!foo and ^foo^bar)
ZSH_HIGHLIGHT_STYLES[history-expansion]='none'
# command substitutions ($(echo foo))
ZSH_HIGHLIGHT_STYLES[command-substitution]='none'
# an unquoted command substitution ($(echo foo))
ZSH_HIGHLIGHT_STYLES[command-substitution-unquoted]='none'
# a quoted command substitution ("$(echo foo)")
ZSH_HIGHLIGHT_STYLES[command-substitution-quoted]='none'
# command substitution delimiters ($( and ))
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]='none'
# an unquoted command substitution delimiters ($( and ))
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter-unquoted]='none'
# a quoted command substitution delimiters ("$( and )")
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter-quoted]='none'
# process substitutions (<(echo foo))
ZSH_HIGHLIGHT_STYLES[process-substitution]='none'
# process substitution delimiters (<( and ))
ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]='none'
# single-hyphen options (-o)
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='none'
# double-hyphen options (--option)
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='none'
# backtick command substitution (`foo`)
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='none'
# unclosed backtick command substitution (`foo)
ZSH_HIGHLIGHT_STYLES[back-quoted-argument-unclosed]='none'
# backtick command substitution delimiters (`)
ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]='none'
# single-quoted arguments ('foo')
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=14'
# unclosed single-quoted arguments ('foo)
ZSH_HIGHLIGHT_STYLES[single-quoted-argument-unclosed]='fg=red'
# double-quoted arguments ("foo")
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=cyan'
# unclosed double-quoted arguments ("foo)
ZSH_HIGHLIGHT_STYLES[double-quoted-argument-unclosed]='fg=red'
# dollar-quoted arguments ($'foo')
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='none'
# unclosed dollar-quoted arguments ($'foo)
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument-unclosed]='none'
# two single quotes inside single quotes when the RC_QUOTES option is set ('foo''bar')
ZSH_HIGHLIGHT_STYLES[rc-quote]='none'
# parameter expansion inside double quotes ($foo inside "")
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='none'
# backslash escape sequences inside double-quoted arguments (\" in "foo\"bar")
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]='none'
# backslash escape sequences inside dollar-quoted arguments (\x in $'\x48')
ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]='none'
# parameter assignments (x=foo and x=( ))
ZSH_HIGHLIGHT_STYLES[assign]='none'
# redirection operators (<, >, etc)
ZSH_HIGHLIGHT_STYLES[redirection]='none'
# comments, when setopt INTERACTIVE_COMMENTS is in effect (echo # foo)
ZSH_HIGHLIGHT_STYLES[comment]='none'
# named file descriptor
ZSH_HIGHLIGHT_STYLES[named-fd]='none'
# a command word other than one of those enumerated above (other than a command, precommand, alias, function, or shell builtin command).
ZSH_HIGHLIGHT_STYLES[arg0]='none'
ZSH_HIGHLIGHT_STYLES[default]='none'

# ----------------------------------------------------------------------------

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


# ============================================================================
# post rc actions
# ============================================================================

# ----------------------------------------------------------------------------
# rbenv
# ----------------------------------------------------------------------------
# if command -v rbenv >/dev/null 2>&1; then
#   eval "$(rbenv init -)"
# fi

# ----------------------------------------------------------------------------
# Nix
# Multi-user installs source the nix-daemon.sh in /etc profiles but
# single-user installs do not modify those files. Moreover, a multi-user
# install does not appear to provide the nix.sh script in the user profile link
# ----------------------------------------------------------------------------
# if [ -d $HOME/.nix-profile/etc/profile.d ]; then
#   for i in $HOME/.nix-profile/etc/profile.d/*.sh; do
#     if [ -r $i ]; then
#       source $i
#     fi
#   done
# fi

# ----------------------------------------------------------------------------
# python
# ----------------------------------------------------------------------------
# source "${XDG_DATA_HOME}/pyenv/init.${ISHELL}" 2&> /dev/null
# source "${XDG_DATA_HOME}/conda/init.${ISHELL}" 2&> /dev/null

source <(conda shell.${ISHELL} hook 2&> /dev/null)
source "${MAMBA_ROOT_PREFIX}/etc/profile.d/mamba.sh" 2&> /dev/null

# conda init does not seem to do this if an env is already activated.
if [ ! -z "${CONDA_PREFIX+x}" ]; then
    export PATH="${CONDA_PREFIX}/bin:$PATH"
fi

# pyenv init script always prepends shims to path.
source <(pyenv init - --no-rehash ${ISHELL} 2&> /dev/null)

# ----------------------------------------------------------------------------
# starship
# ----------------------------------------------------------------------------
source <(starship init ${ISHELL} --print-full-init 2&> /dev/null)


# ----------------------------------------------------------------------------
# finish
export ZSHRC_SET=1

# All the fzf script does is update path to include fzf bin and source
# completions / keybindings.
# source "${XDG_CONFIG_HOME}/fzf/fzf.zsh" > /dev/null 2>&1
# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# export PATH="$HOME/.local/opt/pypoetry/bin:$PATH"

