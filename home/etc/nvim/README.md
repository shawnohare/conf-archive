# Completion (Wed, 02 Mar 2016 09:05:42 -0800)

We use [deoplete](https://github.com/Shougo/deoplete.nvim) for
autocompletion. Another option is YouCompleteMe.

# Python 

## Pyenv 

As of Tue, 01 Mar 2016 11:03:54 -0800, it seems the best way to 
use pyenv versions of Python with Neovim is to manually install the
neovim python package using the pip associated to the appropriate version
of Python specified by pyenv.  E.g:
```
pyenv global 2.7.11 3.5.1 3.6-dev
pyenv rehash
pip install neovim
pip3 install neovim
```
The Python paths can be specified explicitly within `init.vim`, but this
has given us trouble in the past.

## Jedi

Jedi is an autocomplete engine that also performs some static analysis.
First, one needs to install it via pip (or some other means):
```
pip install jedi
pip3 install jedi
```
It can be used with deoplete via the deoplete source.  There is no need
to install vim-jedi.

