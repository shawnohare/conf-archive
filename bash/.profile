# These environment settings should be useable even from a clean install.

export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export DOTFILES="${HOME}/dotfiles"

# make sure usr/local/bin occurs before usr/bin
export PATH="${HOME}/bin:/usr/local/bin:$PATH"

