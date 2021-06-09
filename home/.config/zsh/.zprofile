# Run automatically (before zshrc) if the shell is a login shell.
# Login: The shell is run as part of the login of the user to the system.
# Typically used to do any configuration to establish a work-environment.
# An session of zsh used by a terminal emulator is typically both login and
# interactive, whereas an invocation of zsh is purely interactive.

# FIXME: Since tmux runs as a login shell, not re-sourcing the local overrides
# can be problematic.
# if [ -z "${PROFILE_SET}" ]; then
#     source "${HOME}/.profile" > /dev/null 2>&1
# fi


[ -e "${HOME}/.profile" ] && source "${HOME}/.profile"

# Remove duplicate path entries. Order can get wonky though. Avoid!
# typeset -aU path
# path=($path)
# export PATH


# eval "$(direnv hook zsh)"
