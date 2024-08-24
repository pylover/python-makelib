# Usage:
# source activate.sh
# source activate.sh <venv-name>


get_venv() {
   local venv=$1
  
   if [ -z "$venv" ]; then
     venv=$(grep -w VENV_NAME Makefile | cut -d'=' -f2 | xargs)
     if [ -z "${venv}" ]; then
       venv=$(grep -w PKG_NAME Makefile | cut -d'=' -f2 | xargs)
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
unset PREFIX
