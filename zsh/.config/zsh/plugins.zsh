# Github repo names. Corresponds to the directories in $ZPLUGIN_HOME.
# Form should be plug "username/reponame" [args]
# Modelled after zplug.
# Args:
#     use: File to source.

plug "rupa/z" use="z.sh"
# plug "aperezdc/zsh-fzy" # like fzf
plug "junegunn/fzf" use="shell/completion.zsh"
plug "junegunn/fzf" use="shell/key-bindings.zsh"
# enhancd is like z, but things like cd .. don't seem to work?
# plug "b4b4r07/enhancd" use="init.sh"
plug "zsh-users/zsh-completions"
plug "zsh-users/zsh-autosuggestions"
# plug  "zsh-users/zaw"
plug "hlissner/zsh-autopair" use="autopair.zsh"
plug "zsh-users/zsh-syntax-highlighting"
plug "zsh-users/zsh-history-substring-search"
