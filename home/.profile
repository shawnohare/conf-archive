# Executed by the command interpreter for login shells.
# Historically, processing heavy setup is performed here, while transient
# settings that are not inherited are put in rc files so they can be re-read by
# every new interactive shell invocation.
# 
# This can contain environmental variables, PATH, and some plugin init scripts
# (e.g., pyenv and nix).  It should be sourced by the shell's corresponding
# file if it exists, (e.g., .bash_profile, .zprofile).
#
# Non-inheritted settings, like aliases our custom ~/.config/rc.sh and sourced
# from the shell specific rc file (e.g., .bashrc, .zshrc)

# Basic home configuration.
export CONF_HOME="${HOME}/conf"

# - XDG_CONFIG_HOME application configuration and some state 
# - XDG_DATA_HOME typically houses more static data files such as fonts.
#   We store application data here for apps that typically dump everything into
#   "~/.{app}", such as pyenv, go, etc. Another candidate location is ~/opt
#   or ~/.local/opt
export XDG_BIN_HOME="${HOME}/.local/bin"
export XDG_CACHE_HOME="${HOME}/.cache"  # application config and state
export XDG_CONFIG_HOME="${HOME}/.config"  # application config and state
export XDG_DATA_HOME="${HOME}/.local/share" 

# Misc vars forcing apps to adhere to the dir structure above.
# NOTE: Some apps, like ansible, appear to not respect AWS vars.
# export AWS_CONFIG_FILE="${XDG_CONFIG_HOME}/aws/config"
# export AWS_SHARED_CREDENTIALS_FILE="${XDG_CONFIG_HOME}/aws/credentials"
export IPYTHONDIR="${XDG_CONFIG_HOME}/ipython"
export NIXPKGS_CONFIG="${XDG_CONFIG_HOME}/nixpkgs/config.nix"
export PYSPARK_DRIVER_PYTHON="ipython"
export SCREENRC="${XDG_CONFIG_HOME}/screen/screenrc"
export SPACEMACSDIR="${XDG_CONFIG_HOME}/spacemacs"

# Optional packages that tend to utilize a single dir.
# export PYTHONUSERBASE="${XDG_OPT_HOME}"
export CARGO_HOME="${XDG_DATA_HOME}/cargo"
# Cargo install root (without trailing bin/)
# export CARGO_INSTALL_ROOT="${XDG_BIN_HOME}"
export GOPATH="${XDG_DATA_HOME}/go"
export GOBIN="${XDG_BIN_HOME}"
export PYENV_ROOT="${XDG_DATA_HOME}/pyenv"
export RUSTUP_HOME="${XDG_DATA_HOME}/rustup" # Might be superfluous.
# export SPARK_HOME="/opt/spark"
export STACK_ROOT="${XDG_DATA_HOME}/stack"

# export BASH="/usr/local/bin/bash"
# Setting the BROWSER env var can break fish's help command.
# export BROWSER="safari"
export EDITOR="nvim"
export VISUAL="nvim"

# colors
# All of these settings enable consistent coloring of the most frequently
# used parts of the CLI. For historical reasons 'ls', 'less', 'grep', and
# the completion menu all require separate color settings.

# Enable command line color
export CLICOLOR=1
# Define solarized colors for the 'ls' command on BSD/Darwin
# export LSCOLORS='ExfxcxdxbxGxDxabagacad'
# Define colors for the zsh completion system
# export LS_COLORS='di=01;34:ln=35:so=32:pi=33:ex=31:bd=36;01:cd=33;01:su=31;40;07:sg=36;40;07:tw=32;40;07:ow=33;40;07:'

# Solarized colors
# NOTE: This can be autogenerated from a file via dircolors.
# export LS_COLORS="no=00;38;5;244:rs=0:di=01;34:ln=01;38;5;35:mh=00:pi=48;5;230;38;5;136;01:so=48;5;230;38;5;136;01:do=48;5;230;38;5;136;01:bd=48;5;230;38;5;244;01:cd=48;5;230;38;5;244;01:or=48;5;235;38;5;160:su=48;5;160;38;5;230:sg=48;5;136;38;5;230:ca=30;41:tw=48;5;64;38;5;230:ow=48;5;235;38;5;33:st=48;5;33;38;5;230:ex=01;38;5;64:*.tar=00;38;5;61:*.tgz=01;38;5;61:*.arj=01;38;5;61:*.taz=01;38;5;61:*.lzh=01;38;5;61:*.lzma=01;38;5;61:*.tlz=01;38;5;61:*.txz=01;38;5;61:*.zip=01;38;5;61:*.z=01;38;5;61:*.Z=01;38;5;61:*.dz=01;38;5;61:*.gz=01;38;5;61:*.lz=01;38;5;61:*.xz=01;38;5;61:*.bz2=01;38;5;61:*.bz=01;38;5;61:*.tbz=01;38;5;61:*.tbz2=01;38;5;61:*.tz=01;38;5;61:*.deb=01;38;5;61:*.rpm=01;38;5;61:*.jar=01;38;5;61:*.rar=01;38;5;61:*.ace=01;38;5;61:*.zoo=01;38;5;61:*.cpio=01;38;5;61:*.7z=01;38;5;61:*.rz=01;38;5;61:*.apk=01;38;5;61:*.gem=01;38;5;61:*.jpg=00;38;5;136:*.JPG=00;38;5;136:*.jpeg=00;38;5;136:*.gif=00;38;5;136:*.bmp=00;38;5;136:*.pbm=00;38;5;136:*.pgm=00;38;5;136:*.ppm=00;38;5;136:*.tga=00;38;5;136:*.xbm=00;38;5;136:*.xpm=00;38;5;136:*.tif=00;38;5;136:*.tiff=00;38;5;136:*.png=00;38;5;136:*.svg=00;38;5;136:*.svgz=00;38;5;136:*.mng=00;38;5;136:*.pcx=00;38;5;136:*.dl=00;38;5;136:*.xcf=00;38;5;136:*.xwd=00;38;5;136:*.yuv=00;38;5;136:*.cgm=00;38;5;136:*.emf=00;38;5;136:*.eps=00;38;5;136:*.CR2=00;38;5;136:*.ico=00;38;5;136:*.tex=01;38;5;245:*.rdf=01;38;5;245:*.owl=01;38;5;245:*.n3=01;38;5;245:*.ttl=01;38;5;245:*.nt=01;38;5;245:*.torrent=01;38;5;245:*.xml=01;38;5;245:*Makefile=01;38;5;245:*Rakefile=01;38;5;245:*build.xml=01;38;5;245:*rc=01;38;5;245:*1=01;38;5;245:*.nfo=01;38;5;245:*README=01;38;5;245:*README.txt=01;38;5;245:*readme.txt=01;38;5;245:*.md=01;38;5;245:*README.markdown=01;38;5;245:*.ini=01;38;5;245:*.yml=01;38;5;245:*.cfg=01;38;5;245:*.conf=01;38;5;245:*.c=01;38;5;245:*.cpp=01;38;5;245:*.cc=01;38;5;245:*.log=00;38;5;240:*.bak=00;38;5;240:*.aux=00;38;5;240:*.lof=00;38;5;240:*.lol=00;38;5;240:*.lot=00;38;5;240:*.out=00;38;5;240:*.toc=00;38;5;240:*.bbl=00;38;5;240:*.blg=00;38;5;240:*~=00;38;5;240:*#=00;38;5;240:*.part=00;38;5;240:*.incomplete=00;38;5;240:*.swp=00;38;5;240:*.tmp=00;38;5;240:*.temp=00;38;5;240:*.o=00;38;5;240:*.pyc=00;38;5;240:*.class=00;38;5;240:*.cache=00;38;5;240:*.aac=00;38;5;166:*.au=00;38;5;166:*.flac=00;38;5;166:*.mid=00;38;5;166:*.midi=00;38;5;166:*.mka=00;38;5;166:*.mp3=00;38;5;166:*.mpc=00;38;5;166:*.ogg=00;38;5;166:*.ra=00;38;5;166:*.wav=00;38;5;166:*.m4a=00;38;5;166:*.axa=00;38;5;166:*.oga=00;38;5;166:*.spx=00;38;5;166:*.xspf=00;38;5;166:*.mov=01;38;5;166:*.mpg=01;38;5;166:*.mpeg=01;38;5;166:*.m2v=01;38;5;166:*.mkv=01;38;5;166:*.ogm=01;38;5;166:*.mp4=01;38;5;166:*.m4v=01;38;5;166:*.mp4v=01;38;5;166:*.vob=01;38;5;166:*.qt=01;38;5;166:*.nuv=01;38;5;166:*.wmv=01;38;5;166:*.asf=01;38;5;166:*.rm=01;38;5;166:*.rmvb=01;38;5;166:*.flc=01;38;5;166:*.avi=01;38;5;166:*.fli=01;38;5;166:*.flv=01;38;5;166:*.gl=01;38;5;166:*.m2ts=01;38;5;166:*.divx=01;38;5;166:*.webm=01;38;5;166:*.axv=01;38;5;166:*.anx=01;38;5;166:*.ogv=01;38;5;166:*.ogx=01;38;5;166:"
# eval `dircolors "${HOME}/etc/dircolors/conf"`

# The pager 'less' (the default pager for man-pages) depends on
# the terminfo termcap interface for color capabilities. Exporting
# the following parameters provides for colored man-page display.
export MANCOLOR=1
export LESSHISTFILE="${XDG_CONFIG_HOME}/less/history"
export LESS_TERMCAP_mb=$(printf "\033[01;31m")    # begins blinking = LIGHT_RED
export LESS_TERMCAP_md=$(printf "\033[00;34m")     # begins bold = BLUE
export LESS_TERMCAP_me=$(printf "\033[0m")        # ends mode = NO_COLOR
export LESS_TERMCAP_so=$(printf "\033[00;47;30m") # begins standout-mode = REVERSE_WHITE
export LESS_TERMCAP_se=$(printf "\033[0m")        # ends standout-mode = NO_COLOR
export LESS_TERMCAP_us=$(printf "\033[00;32m")    # begins underline = LIGHT_GREEN
export LESS_TERMCAP_ue=$(printf "\033[0m")        # ends underline = NO_COLOR

# The following provide color highlighing by default for GREP
# export GREP_COLOR='37;45'
# NOTE: GREP_OPTIONS is deprecated.
# export GREP_OPTIONS='--color=auto'


# =========================================================================
# path
# =========================================================================

# Make sure usr/local/bin occurs before usr/bin.
PATH="/usr/local/opt/bin:/usr/local/bin:/usr/local/sbin:$PATH"

PATH="${CARGO_HOME}/bin:${PATH}"

# Local bins
PATH="${HOME}/bin:${XDG_BIN_HOME}:${PATH}"

# Ruby
# if command -v rbenv >/dev/null 2>&1; then
#   eval "$(rbenv init -)"
# fi

# Python
# pyenv init will use PYENV_ROOT or default to ~/.pyenv
PATH="${PYENV_ROOT}/bin:${PATH}"
if [ -e "${PYENV_ROOT}/bin/pyenv" ]; then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

# Multi-user installs source the nix-daemon.sh in /etc profiles but
# single-user installs do not modify those files. Moreover, a multi-user
# install does not appear to provide the nix.sh script in the user profile link
if [ -e "${HOME}/.nix-profile/etc/profile.d/nix.sh" ]; then
  . "${HOME}/.nix-profile/etc/profile.d/nix.sh"
fi
