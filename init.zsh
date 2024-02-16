#!/usr/bin/env zsh

_zsh_direnv_load() {
    eval "$(direnv hook zsh)"
}

_zsh_direnv_dir() {
    [[ -v DIRENV_DIR ]] && print " ${DIRENV_DIR##*/}"
}

command -v direnv && _zsh_direnv_load

