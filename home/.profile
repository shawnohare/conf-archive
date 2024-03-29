# Executed by the command interpreter for login shells.
# Historically, processing heavy setup is performed here, while transient
# settings that are not inherited are put in rc files so they can be re-read by
# every new interactive shell invocation.
#
# This can contain environmental variables, PATH, and some plugin init scripts
# (e.g., pyenv and nix).  It should be sourced by the shell's corresponding
# file if it exists, (e.g., .bash_profile, .zprofile).
#
# Non-inheritted settings, like aliases are in ~/.config/sh/init.sh and sourced
# from the shell specific rc file (e.g., .bashrc, .zshrc)

if [ -z "${ENV_SET+x}" ]; then
    source "${HOME}/.env" 2&> /dev/null
fi



# ----------------------------------------------------------------------------
# Linuxbrew
# On linux systems with Linuxbrew installed, augment path and set env.
# Linuxbrew is used primarily to get newer versions of software.
# if [ -d ~/.linuxbrew ]; then
#     eval $(~/.linuxbrew/bin/brew shellenv)
# elif [ -d /home/linuxbrew ]; then
#     eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
# fi

# NOTE: Many programs that require some form of init need to go in their
# respective RC files, as many of the effects will not carry over to
# interactive, non-login shells (such as wrapper function definitions).

# added by Snowflake SnowSQL installer v1.2
export PATH=/Applications/SnowSQL.app/Contents/MacOS:$PATH
