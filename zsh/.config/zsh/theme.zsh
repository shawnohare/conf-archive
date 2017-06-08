#!/usr/bin/env zsh
#
declare -r green="%{$fg_bold[green]%}"
declare -r blue="%{$fg_bold[blue]%}"
declare -r red="%{$fg_bold[red]%}"
declare -r yellow="%{$fg_bold[yellow]%}"
declare -r cyan="%{$fg_bold[cyan]%}"
declare -r magenta="%{$fg_bold[magenta]%}"
declare -r white="%{$fg_bold[white]%}"
declare -r reset_color="%{$reset_color%}"

# Git sometimes goes into a detached head state. git_prompt_info doesn't
# return anything in this case. So wrap it in another function and check
# for an empty string.
function _git_prompt_info() {
  if git rev-parse --git-dir > /dev/null 2>&1; then
    if [[ -z $(git_prompt_info) ]]; then
      echo -n "${blue}detached-head${rest_color}$(git_prompt_status)"
    else
      echo -n "$(git_prompt_info)$(git_prompt_short_sha)$(git_prompt_status)"
    fi
  else
    echo -n "${reset_color}"
  fi
}

# Format for git_prompt_info()
ZSH_THEME_GIT_PROMPT_PREFIX="${yellow}git:${magenta}"
ZSH_THEME_GIT_PROMPT_SUFFIX="${yellow}${reset_color}"
ZSH_THEME_GIT_PROMPT_DIRTY="${red}✘"
ZSH_THEME_GIT_PROMPT_CLEAN=""
# symbols: ✔

# Format for git_prompt_status()
ZSH_THEME_GIT_PROMPT_ADDED="${green}+"
ZSH_THEME_GIT_PROMPT_MODIFIED="${blue}!"
ZSH_THEME_GIT_PROMPT_DELETED="${red}-"
ZSH_THEME_GIT_PROMPT_RENAMED="${magenta}>"
ZSH_THEME_GIT_PROMPT_UNMERGED="${yellow}#"
ZSH_THEME_GIT_PROMPT_UNTRACKED="${cyan}?"

# Format for git_prompt_ahead()
ZSH_THEME_GIT_PROMPT_AHEAD="${white}^"

# Format for git_prompt_long_sha() and git_prompt_short_sha()
ZSH_THEME_GIT_PROMPT_SHA_BEFORE="[${magenta}"
ZSH_THEME_GIT_PROMPT_SHA_AFTER="]${reset_color}"

user="${green}%n"
separator="${reset_color}@"
machine="${magenta}%m${reset_color}"
dir="${blue}%3~${reset_color}"
date="${cyan}%D{%Y-%m-%dT%T}${reset_color}"
prompt_symb="→${reset_color}"
# Some other start symbols
# ⇨ → 🐉 ➤

PROMPT='${user}${separator}${machine} ${dir} $(_git_prompt_info)
%(?.${fg_bold[green]}.${fg_bold[red]})${prompt_symb} '
# RPROMPT='$(_git_prompt_info)'
