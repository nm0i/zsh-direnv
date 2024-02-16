#!/usr/bin/env zsh

_zsh_direnv_load() {
    eval "$(direnv hook zsh)"
}

if command -v direnv >/dev/null
then
    _zsh_direnv_load
fi

