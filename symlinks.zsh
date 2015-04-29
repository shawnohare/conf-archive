#!/bin/bash
ln -s ~/dotfiles/aliases ~/.aliases
ln -s ~/dotfiles/vim ~/.vim
ln -s ~/dotfiles/bash_profile ~/.bash_profile
ln -s ~/dotfiles/profile ~/.profile
ln -s ~/dotfiles/tmux/tmux.conf ~/.tmux.conf

# zsh config files are dotted to limit extraneous symlinks
mkdir ~/.zsh
ln -s ~/dotfiles/zsh/zshenv ~/.zshenv
ln -s ~/dotfiles/zsh/zshrc $ZDOTDIR/.zshrc
ln -s ~/dotfiles/zsh/zprofile $ZDOTDIR/.zprofile
