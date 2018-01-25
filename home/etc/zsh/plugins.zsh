# Load plugins. Installation is a simple git clone.
# compaudit complains if group has write access  for /usr/local/share, hence
# the sudo when cloning.
#
# Install and load a plugin.
# zplug(plugin_repo, relative_path_to_source)
function zplug() {
  local plugin="${ZSHPLUGIN_HOME}/$1/$2"
  if [[ ! -e "${plugin}" ]]; then
      git clone --recursive "https://$1" "${ZSHPLUGIN_HOME}/$1"
  fi
  source "${plugin}"
}

zplug "github.com/junegunn/fzf" "shell/completion.zsh"
zplug "github.com/junegunn/fzf" "shell/key-bindings.zsh"
zplug "github.com/rupa/z" "z.sh"
zplug "github.com/zsh-users/zsh-completions" "zsh-completions.plugin.zsh"
zplug "github.com/zsh-users/zsh-autosuggestions" "zsh-autosuggestions.zsh"
zplug "github.com/hlissner/zsh-autopair" "autopair.zsh"
zplug "github.com/zsh-users/zsh-syntax-highlighting" "zsh-syntax-highlighting.zsh"
zplug "github.com/zsh-users/zsh-history-substring-search" "zsh-history-substring-search.zsh"

# function zshplug() {
#   local plugin="${zshplugIN_HOME}/$1"
#   if [[ ! -e "${plugin}" ]]; then
#     local repo="${1[1,(ws:/:)3]}" # split on / and get first 3 elements.
#     git clone --recursive "https://${repo}" "${zshplugIN_HOME}/${repo}"
#   fi
#   source "${plugin}"
# }

# plug "github.com/junegunn/fzf/shell/completion.zsh"
# plug "github.com/junegunn/fzf/shell/key-bindings.zsh"
# plug "github.com/rupa/z/z.sh"
# plug "github.com/zsh-users/zsh-completions/zsh-completions.plugin.zsh"
# plug "github.com/zsh-users/zsh-autosuggestions/zsh-autosuggestions.zsh"
# plug "github.com/hlissner/zsh-autopair/autopair.zsh"
# plug "github.com/zsh-users/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
# plug "github.com/zsh-users/zsh-history-substring-search/zsh-history-substring-search.zsh"

