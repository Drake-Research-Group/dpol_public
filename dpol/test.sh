#!/usr/bin/env bash

while getopts ct o; do
    case $o in
        (c) COMP="yes";;
        (t) RUN="no";;
    esac
done
shift "$((OPTIND - 1))"

MAIN="src/dbigdq.f90"
OUT="dbigdq_test"
INC=("modules")

if [[ $(uname) == "Darwin" ]]; then
  FLAGS=("-std=legacy" "-mcmodel=small")
  MOD=("build/darwin/dqmodule.o" "build/darwin/dqfun.o" "build/darwin/wavext.o")
else
  FLAGS=("-std=legacy" "-mcmodel=medium")
  MOD=("build/linux/dqmodule.o" "build/linux/dqfun.o" "build/linux/wavext.o") 
fi

TEST_IGNORE=(45)

gfortran $MAIN ${MOD[@]} -o $OUT ${FLAGS[@]} -I ${INC[@]}

if [ $RUN == "no"]
then
    echo "Did not compile due to -t (test) tag"
fi

if [ $? -eq 0 ]
then
    echo "copying test .dat file..."
    cp data/test.dat data/dall2020.dat
    clear

    if [ $COMP == "yes" ]; then
        rm ./dbigdq.out
        ./$OUT | tee ./dbigdq.out
        util compare.py ./dbigdq.out ./baseline.out ${TEST_IGNORE[@]}
    else
        ./$OUT
    fi
 
    
else
    echo "Compilation failed"
fi
