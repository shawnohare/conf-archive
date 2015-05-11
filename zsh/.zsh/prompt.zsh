setopt PROMPT_SUBST      # allow for more extensive expansion in prompts
setopt TRANSIENT_RPROMPT # right prompt does not persist
# hostname: cwd [exit status] %

autoload -Uz vcs_info

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git:*' formats '%u%c%{%F{green}%}[%b]%{%f%} '
zstyle ':vcs_info:git:*' stagedstr '%{%F{yellow}%}+%{%f%}'
zstyle ':vcs_info:git:*' unstagedstr '%{%F{red}%}*%{%f%}'
precmd() {
  vcs_info
}

PROMPT='%{%F{yellow}%}>%{%f%} '        # prompt indicator
PROMPT+='%{%F{blue}%}%1~%{%f%} '        # current directory
# PROMPT+='%(?..%{%F{yellow}%}%? '     # exit codes 
PROMPT+='${vcs_info_msg_0_}'           # git info
PROMPT+='%{$%} '                       # $ indicator
# RPROMPT='%*'                           # time and date
