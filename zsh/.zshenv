# `.zshenv' is sourced on all invocations of the shell, unless the -f option 
# is set. It should contain commands to set the command search path, plus 
# other important environment variables. `.zshenv' should not contain
# commands that produce output or assume the shell is attached to a tty.
#
# XDG
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"

# zsh
export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"
export HISTFILE="${XDG_DATA_HOME}/zsh/history"

# User
export DOTFILES="${HOME}/dotfiles"
export DEPS="${DOTFILES}/deps"

export EDITOR="nvim"
export ECLIPSE_HOME="${HOME}/Applications/Eclipse.app/Contents/Eclipse"
export VISUAL="nvim"
export BROWSER="safari"
export BASH="/usr/local/bin/bash"


# Neovim
export NVIM_TUI_ENABLE_TRUE_COLOR=1
export NVIM_TUI_ENABLE_CURSOR_SHAPE=1
export NVIM_PYTHON_LOG_FILE="${HOME}/var/log/nvim-python.log"
