# External modules/add-ons to zsh
# Should be the final thing sourced by zshrc.


# ===========================================================================
# zsh-autosuggestions
# ===========================================================================

# FIXME had some issues playing nice with history-substring-search
#zle-line-init() {
#    zle autosuggest-start
#  }
#zle -N zle-line-init
#export AUTOSUGGESTION_HIGHLIGHT_COLOR=fg=246

# ===========================================================================
# zsh-completions
# ===========================================================================
# fpath=(/usr/local/share/zsh-completions $fpath)
fpath=(${DEPS}/zsh-users/zsh-completions $fpath)

# ===========================================================================
# zsh-history-substring-search
# ===========================================================================
# vim-like snippet keybindings for history-substring-search
source ${DEPS}/zsh-users/zsh-history-substring-search/zsh-history-substring-search.zsh
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
