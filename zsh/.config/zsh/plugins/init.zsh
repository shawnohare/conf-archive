# List of plugins to load.
# A very basic loading of plugins. Order is respected. Each plugin is
# loaded after compinit. This might cause problems and necessitate a
# return to a plugin manager such as zplug.
#
source "${ZPLUGIN_HOME}/plugins.zsh"

function load() {
  local name="${1##*/}"  # Part after last slash.
  local dir="${ZPLUGIN_HOME}/$1"
  if [[ ! -e "${dir}" ]]; then
    echo "Plugin $1 does not exist. Downloading."
    local src="https://github.com/$1"
    git clone --recursive "${src}" "${dir}"
  fi

  # Attempt to source either <name>.zsh or <name>.plugin.zsh
  local prefix="${dir}/${name}"
  source "${prefix}.zsh" > /dev/null 2>&1 || \
    source "${prefix}.plugin.zsh" > /dev/null 2>&1
}

for plugin in "${plugins[@]}"; do
  load "${plugin}"
done

