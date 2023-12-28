# locale
export LANG=C.UTF-8

# XDG
export XDG_CONFIG_HOME=${HOME}/.config
export XDG_CACHE_HOME=${HOME}/.cache
export XDG_DATA_HOME=${HOME}/.local/share
export XDG_STATE_HOME=${HOME}/.local/state

# set PATH so it includes user's private bin if it exists
if [ -d "${HOME}/.local/bin" ] ; then
    PATH="${HOME}/.local/bin:${PATH}"
fi
