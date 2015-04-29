# zsh Config Notes

## Getting Started

- Make $HOME/.zsh directory
- Symlink zshenv to $HOME/.zshenv.
- zshenv sets ZDOTDIR to  $HOME/.zsh
- Symlink dotted versions of config files (e.g., zshrc) into $HOME/$ZDOTDIR/

## Modules

Each module (zsh file) should be self-contained so that any subset
may be sourced in arbitrary order.
