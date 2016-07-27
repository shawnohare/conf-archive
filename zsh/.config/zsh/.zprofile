# Run automatically (before zshrc) if the shell is a login shell.
# Login: The shell is run as part of the login of the user to the system.
# Typically used to do any configuration to establish a work-environment.

# ==========================================================================
# PATH 
# ==========================================================================

if [ -f "${XDG_CONFIG_HOME}/profile/path" ]; then
  source "${XDG_CONFIG_HOME}/profile/path" 
fi

