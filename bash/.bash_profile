# source the appropriate files

if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi
if [ -e /home/admin/.nix-profile/etc/profile.d/nix.sh ]; then . /home/admin/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
