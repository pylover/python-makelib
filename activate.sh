# Usage:
# source activate.sh
# source path/to/activate.sh
# . activate.sh
# . activate.sh <venv-name>

deactivation() {
  if [ -n "$VIRTUAL_ENV" ]; then
    if command -v deactivate > /dev/null; then
      deactivate
      unset _ACTIVATE_SCRIPT_SOURCED
      unalias deactivate 2>/dev/null || true
      echo "Virtual environment deactivated."
    else
      echo "Deactivate command not found. You may need to manually deactivate."
    fi
  else
    echo "No virtual environment is currently active."
  fi
}

if [ -n "$_ACTIVATE_SCRIPT_SOURCED" ]; then
  echo "This script has already been sourced and cannot be sourced again."
  return 1
fi

export _ACTIVATE_SCRIPT_SOURCED=true

SHELLNAME=$(basename $SHELL)
if [ "${SHELLNAME}" = "zsh" ]; then
    HERE=${0:a:h}     
elif [[ "${SHELLNAME}" = "sh"  ]] || [[ "${SHELLNAME}" = "bash" ]]; then
    HERE=$(dirname $(readlink -f ${BASH_SOURCE}))/..
else
    echo "${SHELLNAME} is not supported" >&2
    return 1
fi


get_venv() {
  local here=$(dirname $(readlink -f ${BASH_SOURCE}))/..
  local venv=$1

  if [ -z "$venv" ]; then
    venv=$(grep -r VENV ${here}/Makefile | cut -d'=' -f2 | xargs)
    if [ -z "${venv}" ]; then
      venv=$(grep -r PKG_NAME ${here}/Makefile | cut -d'=' -f2 | xargs)
    fi
  fi
  
  if [ -z "${venv}" ]; then
    echo "Cannot resolve the VENV environment variable"
    return 1
  fi

  echo $venv
}


PREFIX=${HOME}/.virtualenvs/$(get_venv $1)
source ${PREFIX}/bin/activate

alias deactivate=deactivation

unset HERE
unset PREFIX