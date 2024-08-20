# Usage:
# source activate.sh
# source path/to/activate.sh
# . activate.sh
# . activate.sh <venv-name>


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
   local venv=$1
  
   if [ -z "$venv" ]; then
     venv=$(grep -w VENV_NAME ${HERE}/Makefile | cut -d'=' -f2 | xargs)
     if [ -z "${venv}" ]; then
       venv=$(grep -w PKG_NAME ${HERE}/Makefile | cut -d'=' -f2 | xargs)
     fi
   fi
   
   if [ -z "${venv}" ]; then
     echo "Cannot resolve the VENV_NAME environment variable"
     return 1
   fi
  
   echo $venv
} 
  

PREFIX=${HOME}/.virtualenvs/$(get_venv $1)
source ${PREFIX}/bin/activate
unset HERE
unset PREFIX
