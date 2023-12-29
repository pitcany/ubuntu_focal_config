root=/opt/AMD/aocc-compiler-4.1.0/

[[ ! -d ${root} ]] && echo "ERROR: ${root} not found" && exit 1

source ${root}/setenv_AOCC.sh

export CC=clang CXX=clang++ FC=flang

export MPI_ROOT=

flang --version
