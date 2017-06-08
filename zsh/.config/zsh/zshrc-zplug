
# Set shell independent settings.
[ -e ~/.profile ] && source ~/.profile

if [[ ! -d "${ZPLUG_HOME}" ]]; then
  curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh| zsh
fi

source "${ZPLUG_HOME}/init.zsh"


# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
  zplug install
fi

zplug load

# vim normal mode keybindings
bindkey -v

# changing dirs
autoload -U chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
