# Usage:
# source activate.sh
# source activate.sh <venv-name>


usage() {
  echo "Usage: source activate.sh [VENV]" >&2
}


get_venv() {
  local venv=$1
  
  if [ -z "$venv" ]; then
    venv=$(grep -w VENV_NAME Makefile | head -n1 | cut -d'=' -f2 | xargs)
    if [ -z "${venv}" ]; then
      venv=$(grep -w PKG_NAME Makefile | head -n1 | cut -d'=' -f2 | xargs)
    fi
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
