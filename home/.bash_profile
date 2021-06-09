# source the appropriate files

if [ -z "${PROFILE_SET+x}" ]; then
    source "${HOME}/.profile" > /dev/null 2>&1
fi

