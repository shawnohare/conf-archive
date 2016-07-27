
source "${HOME}/.config/shell/profile.sh"
source "${HOME}/.config/shell/path.sh"

if [ -e /Users/shawn/.nix-profile/etc/profile.d/nix.sh ]; then 
  . /Users/shawn/.nix-profile/etc/profile.d/nix.sh; 
fi # added by Nix installer

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
