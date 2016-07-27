# Shawn O'Hare's Dotfiles

## Introduction

These dotfiles are organized to take advantage of the GNU `stow` symlink
farm manager.  For example, executing `stow git` from the dotfiles root
directory will symlink the version controlled git configuration files to
the correct location.  

Dotfiles are generally organized topically.


## Cloning

To clone this repository along with its submodule dependencies, use
```bash
git clone --recursive https://github.com/shawnohare/dotfiles.git
```

## profile

The `profile` dir contains common shell exports, aliases, and etc. that make
up our shell profile. It is sourced by `~.bash_profile`, `~.bashrc`, and
`~/.zshenv`

## Git 

These files live in `${XDG_CONFIG_HOME}/git` and represent the global
user configuration settings.  Local or private settings go in the
`config.local` file, which is loaded by the `config` file.
