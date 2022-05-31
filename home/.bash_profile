# source the appropriate files

if [ -z "${PROFILE_SET+x}" ]; then
    source "${HOME}/.profile" > /dev/null 2>&1
fi


export PATH="$HOME/.local/opt/pypoetry/bin:$PATH"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/user/.local/opt/conda/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/user/.local/opt/conda/etc/profile.d/conda.sh" ]; then
        . "/Users/user/.local/opt/conda/etc/profile.d/conda.sh"
    else
        export PATH="/Users/user/.local/opt/conda/bin:$PATH"
    fi
fi
unset __conda_setup

if [ -f "/Users/user/.local/opt/conda/etc/profile.d/mamba.sh" ]; then
    . "/Users/user/.local/opt/conda/etc/profile.d/mamba.sh"
fi
# <<< conda initialize <<<

