## ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash, if ~/.bash_profile or ~/.bash_login exists.
# See /usr/share/doc/bash/examples/startup-files for examples.

# ======================================================================
# Exports
# ======================================================================

# XDG
# For the XDG specification, one good resource is:
# https://wiki.debian.org/XDGBaseDirectorySpecification
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache" # can be wiped after reboot, non-essential
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_STATE_HOME="${HOME}/.local/state" # can persist after reboot: logs
# personal XDG-like vars
export XDG_BIN_HOME="${HOME}/.local/bin"
export XDG_LIB_HOME="${HOME}/.local/lib"
export XDG_OPT_HOME="${HOME}/.local/opt"
export XDG_VAR_HOME="${HOME}/.local/var"

# User
export DOTFILES="${HOME}/dotfiles"

# General
export BASH="/usr/local/bin/bash"
export BROWSER="safari"
export ECLIPSE_HOME="${HOME}/Applications/Eclipse.app/Contents/Eclipse"
export EDITOR="nvim"
export SCREENRC="${XDG_CONFIG_HOME}/screen/screenrc"
export VISUAL="nvim"

# colors
# All of these settings enable consistent coloring of the most frequently
# used parts of the CLI. For historical reasons 'ls', 'less', 'grep', and
# the completion menu all require separate color settings.

# Enable command line color
export CLICOLOR=1
# Define colors for the 'ls' command on BSD/Darwin
export LSCOLORS='exfxcxdxbxGxDxabagacad'
# Define colors for the zsh completion system
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=36;01:cd=33;01:su=31;40;07:sg=36;40;07:tw=32;40;07:ow=33;40;07:'

# neovim
# NOTE: 2016-08-02T13:19:45-0700
# truecolor support for neovim can be toggled in init.vim config file now,
# but we still export this variable to support older versions
export NVIM_TUI_ENABLE_TRUE_COLOR=1

# The pager 'less' (the default pager for man-pages) depends on
# the (obsolete) TERMCAP library for color capabilities. Exporting
# the following parameters provides for colored man-page display.
export LESS_TERMCAP_mb=$'\E[01;31m'    # begins blinking = LIGHT_RED
export LESS_TERMCAP_md=$'\E[0;34m'     # begins bold = BLUE
export LESS_TERMCAP_me=$'\E[0m'        # ends mode = NO_COLOR
export LESS_TERMCAP_se=$'\E[0m'        # ends standout-mode = NO_COLOR
export LESS_TERMCAP_so=$'\E[00;47;30m' # begins standout-mode = REVERSE_WHITE
export LESS_TERMCAP_ue=$'\E[0m'        # ends underline = NO_COLOR
export LESS_TERMCAP_us=$'\E[01;32m'    # begins underline = LIGHT_GREEN

# The following provide color highlighing by default for GREP
# export GREP_COLOR='37;45'
export GREP_OPTIONS='--color=auto'



# =========================================================================
# aliases
# =========================================================================
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias ls="ls -GF"
alias la="ls -GFlash"
alias ll="ls -GFlsh"

# linux specific aliases
# In particular, the non-BSD versions of ls do not support -G for color
if [[ $OSTYPE =~ linux ]]; then
  alias la="ls --color -Flash"
  alias ll="ls --color -Flsh"
  alias ls="ls --color -F"
fi


# =========================================================================
# path
# Set in a function so we have greater control over when exactly the path
# is built
# =========================================================================

# Generic binaries
# Make sure ~/bin, and usr/local/bin occurs before usr/bin.
PATH="${HOME}/bin:${XDG_BIN_HOME}:/usr/local/bin:/usr/local/sbin:$PATH"

# --------------------------------------------------------------------------
# Haskell
# FIXME: 2016-07-31T11:38:47-0700
# This needs to be updated to reflect best haskell practices.
# --------------------------------------------------------------------------

# GHC For MAC OS X
# Add GHC 7.10.1 to the PATH, via https://ghcformacosx.github.io/
export GHC_DOT_APP="${HOME}/Applications/ghc-7.10.1.app"
if [[ -d "$GHC_DOT_APP" ]]; then
  PATH="${GHC_DOT_APP}/Contents/bin:${PATH}"
  PATH="${HOME}/.cabal/bin:${PATH}"
fi

# Look for haskell tools installed by stack
# FIXME: remove?
# PATH="${HOME}/.stack/programs/:${PATH}"
# Use haskell tools in the current sandbox/stack maintained dir. FIXME remove?
# PATH=".cabal-sandbox/bin:${PATH}"
PATH=".stack_work:${PATH}"

# --------------------------------------------------------------------------
# iterm
# --------------------------------------------------------------------------
# if [ -e "${XDG_CONFIG_HOME}/iterm/iterm2_shell_integration.`basename $SHELL`" ]; then
#   source "${XDG_CONFIG_HOME}/iterm/iterm2_shell_integration.`basename $SHELL`"
# fi
if [ -e "${HOME}/.iterm2_shell_integration.`basename $SHELL`" ]; then
  source "${HOME}/.iterm2_shell_integration.`basename $SHELL`"
fi

# --------------------------------------------------------------------------
# golang
# --------------------------------------------------------------------------
export GOPATH="${HOME}/dev/go"
PATH="${GOPATH}/bin:${PATH}"

# --------------------------------------------------------------------------
# Python
# --------------------------------------------------------------------------

# pyenv
export PYENV_ROOT="${XDG_BIN_HOME}/stow/pyenv"
# pyenv init will use PYENV_ROOT or default to ~/.pyenv
if hash pyenv > /dev/null; then eval "$(pyenv init -)"; fi
#

# --------------------------------------------------------------------------
# nix
# --------------------------------------------------------------------------
nix_profile_script="${HOME}/.nix-profile/etc/profile.d/nix.sh"
if [ -e ${nix_profile_script} ]; then
  . ${nix_profile_script}
fi
export PATH
