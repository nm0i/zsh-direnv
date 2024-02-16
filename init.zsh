#!/usr/bin/env zsh

autoload colors is-at-least

BOLD="bold"
NONE="NONE"

[[ -z "$DIRENV_HOME" ]] && export DIRENV_HOME="$HOME/.direnv"

ZSH_DIRENV_VERSION_FILE=${DIRENV_HOME}/version.txt

_zsh_direnv_log() {
  local font=$1
  local color=$2
  local msg=$3

  if [ "$font" = $BOLD ]
  then
    echo $fg_bold[$color] "[zsh-direnv-plugin] $msg" $reset_color
  else
    echo $fg[$color] "[zsh-direnv-plugin] $msg" $reset_color
  fi
}

_zsh_direnv_last_version() {
  echo $(curl -s https://api.github.com/repos/direnv/direnv/releases/latest | grep tag_name | cut -d '"' -f 4)
}

_zsh_direnv_download_install() {
    local version=$1
    local machine
    case "$(uname -m)" in
      x86_64)
        machine=amd64
        ;;
      arm64)
        machine=arm64
        ;;
      aarch64)
        machine=arm64
        ;;
      i686 | i386)
        machine=386
        ;;
      *)
        _zsh_direnv_log $BOLD "red" "Machine $(uname -m) not supported by this plugin"
        return 1
      ;;
    esac
    # if on Darwin, trim $OSTYPE to match the direnv release
    [[ "$OSTYPE" == "darwin"* ]] && local OSTYPE=darwin
    _zsh_direnv_log $NONE "blue" "  -> download and install direnv ${version}"
    curl -o "${DIRENV_HOME}/direnv" -fsSL https://github.com/direnv/direnv/releases/download/${version}/direnv.${OSTYPE%-*}-${machine}
    chmod +x "${DIRENV_HOME}/direnv"
    echo ${version} > ${ZSH_DIRENV_VERSION_FILE}
}

_zsh_direnv_install() {
  _zsh_direnv_log $NONE "blue" "#############################################"
  _zsh_direnv_log $BOLD "blue" "Installing direnv..."
  _zsh_direnv_log $NONE "blue" "-> creating direnv home dir : ${DIRENV_HOME}"
  mkdir -p ${DIRENV_HOME} || _zsh_direnv_log $NONE "green" "dir already exist"
  local last_version=$(_zsh_direnv_last_version)
  _zsh_direnv_log $NONE "blue" "-> retrieve last version of direnv..."
  _zsh_direnv_download_install ${last_version}
  if [ $? -ne 0 ]
  then
    _zsh_direnv_log $BOLD "red" "Install KO"
  else
    _zsh_direnv_log $BOLD "green" "Install OK"
  fi
  _zsh_direnv_log $NONE "blue" "#############################################"
}

update_zsh_direnv() {
  _zsh_direnv_log $NONE "blue" "#############################################"
  _zsh_direnv_log $BOLD "blue" "Checking new version of direnv..."

  local current_version=$(cat ${ZSH_DIRENV_VERSION_FILE})
  local last_version=$(_zsh_direnv_last_version)

  if is-at-least ${last_version#v*} ${current_version#v*}
  then
    _zsh_direnv_log $BOLD "green" "Already up to date, current version : ${current_version}"
  else
    _zsh_direnv_log $NONE "blue" "-> Updating direnv..."
    _zsh_direnv_download_install ${last_version}
    _zsh_direnv_log $BOLD "green" "Update OK"
  fi
  _zsh_direnv_log $NONE "blue" "#############################################"
}

_zsh_direnv_load() {
    local -r plugin_dir=${DIRENV_HOME}

    if [[ -z ${path[(r)$plugin_dir]} ]]; then
        path+=($plugin_dir)
    fi
    eval "$(direnv hook zsh)"
}

[[ ! -f "${ZSH_DIRENV_VERSION_FILE}" ]] && _zsh_direnv_install

if [[ -f "${ZSH_DIRENV_VERSION_FILE}" ]]; then
    _zsh_direnv_load
fi

unset -f _zsh_direnv_install _zsh_direnv_load
