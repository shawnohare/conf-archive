# Some notes from the 4.12.0-0 installer script.
# Installs Mambaforge 4.12.0-0

# -b           run install in batch mode (without manual intervention),
#              it is expected the license terms (if any) are agreed upon
# -f           no error if install prefix already exists
# -h           print this help message and exit
# -p PREFIX    install prefix, defaults to $PREFIX, must not contain spaces.
# -s           skip running pre/post-link/install scripts
# -u           update an existing installation
# -t           run package tests after installation (may install conda-build)
installer="Mambaforge-$(uname)-$(uname -m).sh"
if [ ! -e "${installer}" ]; then
    wget "https://github.com/conda-forge/miniforge/releases/latest/download/${installer}"
fi
bash "${installer}" -bs -p ${MAMBA_ROOT_PREFIX}
