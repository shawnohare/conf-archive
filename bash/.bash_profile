MKL_NUM_THREADS=1
export MKL_NUM_THREADS

# source the appropriate files
if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi

source $HOME/.profile
source $HOME/.aliases
if [ -e /Users/shawn/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/shawn/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
