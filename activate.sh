# Usage:
# source activate.sh
# source path/to/activate.sh
# . activate.sh
# . activate.sh <venv-name>


get_venv() {
  local here=$(dirname $(readlink -f ${BASH_SOURCE}))
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
