# zsh Config Notes

## Manual Configuration 

Assuming that `DOTDIR` is defined somewhere and points to this repository:

- `mkdir $HOME/.zsh`
- Symlink zshenv: `ln -s $DOTDIR/zsh/zshenv $HOME/.zshenv`
- zshenv sets ZDOTDIR to `$HOME/.zsh`
- Symlink dotted versions of config files (e.g., zshrc, zprofile) into `$ZDOTDIR`

## Modules

Each module (zsh file) should be self-contained so that any subset
may be sourced in arbitrary order. The zshrc file simply sources all the
configuration files in this repository.
