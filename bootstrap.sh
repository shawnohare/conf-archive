#! /usr/bin/env bash

# Init basic profile.
CONF="${CONF:-${HOME}/conf}"

readonly branch="${CONF_BRANCH:-master}"
readonly repo="https://github.com/shawnohare/conf.git"

if [ ! -d "${CONF}" ]; then
  echo "Cloning ${repo}"
  git clone -b "${branch} "--recursive "${repo}" "${CONF}"
fi

if [ ! -d "${CONF}" ]; then
  >&2 echo "Error: Could not clone config repo."
  exit 1
fi

cd "${CONF}"
git checkout "${branch}"

source "${CONF}/src/.env"
source "${CONF}/src/.profile"

mkdir -p "${USER_BIN_HOME}"
mkdir -p "${USER_CONFIG_HOME}"
mkdir -p "${USER_CACHE_HOME}"
mkdir -p "${USER_DATA_HOME}"
mkdir -p "${USER_SRC_HOME}"
mkdir -p "${USER_TMP_HOME}"
mkdir -p "${USER_VAR_HOME}"

"${CONF}/bin/link"

# Install toolchains and packages related to those toolchains.
for tool in python nix go rust; do
  dir="${CONF}/bin/${tool}"
  "${dir}/install"
  exec bash -l
  "${dir}/pkgs"
done

# TODO: Check for platform, do platform specific install here.

