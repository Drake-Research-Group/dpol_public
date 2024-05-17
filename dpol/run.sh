#!/usr/bin/env bash

MAIN="src/dbigdq.f90"
OUT="dbigdq"
INC=("modules")

FLAGS=("-std=legacy" "-mcmodel=medium")
MOD=("build/linux/dqmodule.o" "build/linux/dqfun.o" "build/linux/wavext.o") 

gfortran $MAIN ${MOD[@]} -o $OUT ${FLAGS[@]} -I ${INC[@]}

if [ $? -eq 0 ]
then
  # python scripts/date.py > data/DATE.DAT
  # ./dbigdq
else
  echo "Compilation failed"
fi
