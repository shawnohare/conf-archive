# zplug "joepvd/zsh-hints", defer:3  # Requires some additional setup.
zplug "hlissner/zsh-autopair", defer:3
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-syntax-highlighting", defer:3
# zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
# zplug "lib/completion", from:oh-my-zsh
zplug "plugins/emoji", from:oh-my-zsh
# zplug "mafredri/zsh-async", from:github, defer:0
# zplug "sindresorhus/pure", use:pure.zsh, from:github, as:theme
# zplug "sabertazimi/dragon-zsh-theme", frozen:true, as:theme
# zplug "LasaleFamine/phi-zsh-theme", as:theme
zplug "${ZDOTDIR}/plugins/theme.zsh", from:local, as:theme

zplug "zplug/zplug", hook-build:'zplug --self-manage'
