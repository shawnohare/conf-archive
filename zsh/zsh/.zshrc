#  Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000
setopt appendhistory autocd extendedglob nomatch notify
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/Users/shawn/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# zsh scripts installed by homebrew
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/local/opt/zsh-history-substring-search/zsh-history-substring-search.zsh
#----------------------------------------------------------------------#
# Setup for zsh-history-substring-search
#----------------------------------------------------------------------#
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
#----------------------------------------------------------------------#
# Files to source
#----------------------------------------------------------------------#
source .profile
