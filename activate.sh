# Usage:
# source activate.sh
# source activate.sh <venv-name>
# HERE=`dirname "$(readlink -f "$BASH_SOURCE")"`
# HERE="$(cd "$(dirname "$0")" && pwd)"
HERE="$(realpath $(dirname ${BASH_SOURCE[0]}))"


usage() {
  echo "Usage: source activate.sh [VENV]" >&2
}


get_venv() {
  local venv=$1
  local mkfile=${HERE}/Makefile

  if [ -z "$venv" ]; then
    venv=$(make -sC ${HERE} venvname | xargs)
  fi
  
  if [ -z "${venv}" ]; then
    venv=$(basename $(realpath .))
  fi
  
  echo $venv
}


VENV_NAME=$(get_venv $1)
if [ -z "${VENV_NAME}" ]; then
  echo "Cannot resolve the virtual environment name."
  usage
  return 1
fi


VENV_PATH=${HOME}/.virtualenvs/${VENV_NAME}
if [ ! -d "${VENV_PATH}" ]; then
  echo "Virtual environment ${VENV_PATH} does not exists" >&2
  usage
  return 1
fi


source ${VENV_PATH}/bin/activate
unset VENV_PATH
unset VENV_NAME
