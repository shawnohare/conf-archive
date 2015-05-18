# zshrc is loaded for interactive shells 

# The following lines were added by compinstall
#zstyle :compinstall filename '/Users/shawn/.zshrc'
# End of lines added by compinstall

# source all config files
for file in "${ZDOTDIR}"/*.zsh; do
  source "${file}"
done
