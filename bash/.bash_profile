# source the appropriate files
if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi

if [ -e /Users/shawn/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/shawn/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
