#!/usr/bin/env bash
# ---------------------------------------------------------------------------
# Global Constants
# These will be set to the value of
# the corresponding environment variable if that variable is set and
# not null, or to the default substitution listed after the :-
# We follow the convention that add-ons go in ~/opt and logs in ~/var
# For the XDG specification, one good resource is:
# https://wiki.debian.org/XDGBaseDirectorySpecification
# ---------------------------------------------------------------------------
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-${HOME}/.cache}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-${HOME}/.state}"
export XDG_BIN_HOME="${XDG_BIN_HOME:-${HOME}/.local/bin}"
export XDG_LIB_HOME="${XDG_LIB_HOME:-${HOME}/.local/lib}"
export XDG_OPT_HOME="${XDG_OPT_HOME:-${HOME}/.local/opt}"
export XDG_TMP_HOME="${XDG_TMP_HOME:-${HOME}/.local/tmp}"
export XDG_VAR_HOME="${XDG_VAR_HOME:-""${HOME}/.local/var}"
