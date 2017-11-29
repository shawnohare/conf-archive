# ======================================================================
# prompt
# ======================================================================
# FIXME this does not work it seems.  Delete?
# Avoid emacs hanging when attempting to connect remotely.
# https://www.emacswiki.org/emacs/TrampMode#t
[[ $TERM == "dumb" ]] && unsetopt zle && PS1='$ ' && return

autoload -Uz vcs_info
# autoload -U colors && colors
setopt PROMPT_SUBST
# setopt TRANSIENT_RPROMPT

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git:*' formats "%%F{magenta}%b%f%u%c"
zstyle ':vcs_info:git:*' stagedstr '%F{yellow}+%f'
zstyle ':vcs_info:git:*' unstagedstr '%F{red}✴%f'
precmd() {
  vcs_info
}



# The %{...%} delimiters tells zsh the text has zero width. Since v 4.3 it's
# probably better to use the %F{color}...%f syntax.
user="%F{green}%B%n%b%f"
machine="%B%m%b"
dir="%F{blue}%3~%f"
date="%F{cyan}%D{%Y-%m-%dT%T}%f"
indicator=">"
PROMPT='${user}@${machine} ${dir} ${vcs_info_msg_0_}
%(?.%F{green}.%F{red}%? )${indicator}%f '


# Simplified prompt
# indicator="⛩️"
# PROMPT='${user}@${machine}: ${dir} ${indicator}  '

# Fun unicode we can interpolate
# ● ✺ ✴
# ⇨ → 🐉 ➤ ⛩️
# ⥲
#

# Emacs hangs when connecting remotely via tramp mode.
# if [[ "$TERM" != "dumb" ]] &&  [ -e "${HOME}/.iterm2_shell_integration.zsh" ]; then
#   source "${HOME}/.iterm2_shell_integration.zsh"
# fi
