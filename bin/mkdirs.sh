#! /usr/bin/env bash


mkdir -p "${XDG_BIN_HOME}"
mkdir -p "${XDG_CONFIG_HOME}"
mkdir -p "${XDG_CACHE_HOME}"
mkdir -p "${XDG_DATA_HOME}"
mkdir -p "${XDG_OPT_HOME}"
mkdir -p "${XDG_SRC_HOME}"
mkdir -p "${HOME}/tmp"
mkdir -p "${XDG_DATA_HOME}/man/man1"
mkdir -p "${XDG_DATA_HOME}/man/man2"
mkdir -p "${XDG_DATA_HOME}/man/man4"
mkdir -p "${XDG_DATA_HOME}/man/man4"
mkdir -p "${XDG_DATA_HOME}/man/man5"
mkdir -p "${XDG_DATA_HOME}/man/man6"
mkdir -p "${XDG_DATA_HOME}/man/man7"
mkdir -p "${XDG_DATA_HOME}/man/man8"
mkdir -p "${XDG_DATA_HOME}/man/man8"

# Could pass these the -h option in BSD to avoid creating a new level of links.
# But invalid for GNU ln.
rm -f "${HOME}/bin" && ln -sf "${XDG_BIN_HOME}" "${HOME}/bin"
ln -sf "${XDG_CONFIG_HOME}" "${HOME}/etc"
ln -sf "${XDG_DATA_HOME}" "${HOME}/share"
ln -sf "${XDG_OPT_HOME}" "${HOME}/opt"
ln -sf "${XDG_SRC_HOME}" "${HOME}/src"
ln -sf "${XDG_VAR_HOME}" "${HOME}/var"
# bins
ln -sf "${POETRY_HOME}/bin/poetry" "${XDG_BIN_HOME}/poetry"
ln -sf "${CONDA_ROOT}/condabin/conda" "${XDG_BIN_HOME}/conda"
ln -sf "${CONDA_ROOT}/condabin/mamba" "${XDG_BIN_HOME}/mamba"
