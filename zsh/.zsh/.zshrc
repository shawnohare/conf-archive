# zshrc is loaded for interactive shells 

# The following lines were added by compinstall
#zstyle :compinstall filename '/Users/shawn/.zshrc'
# End of lines added by compinstall

# source all config files
for file in "${ZDOTDIR}"/*.zsh; do
  source "${file}"
done

# iterm2 shell integration
# source "${DOTFILES}/iterm2/iterm2_shell_integration.zsh"


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
