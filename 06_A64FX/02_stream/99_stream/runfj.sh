#!/bin/bash

set -x

export FLIB_SCCR_CNTL=TRUE
export FLIB_HPCFUNC=TRUE
export FLIB_HPCFUNC_INFO=TRUE
export FLIB_FASTOMP=TRUE
export FLIB_BARRIER=HARD
export OMP_NUM_THREADS=48
#export XOS_MMM_L_ARENA_LOCK_TYPE=0
export XOS_MMM_L_PAGING_POLICY=demand:demand:demand

#export FLIB_FASTOMP=TRUE
#export FLIB_HPCFUNC=TRUE
#export OMP_NUM_THREADS=48
#export XOS_MMM_L_PAGING_POLICY=demand:demand:demand
#export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/FJSVstclanga/v1.1.0/lib64

#rm -f *.exe

#fcc -c stream.c -Kfast,openmp,zfill -o stream.o -DSTREAM_ARRAY_SIZE=256000000
#fcc stream.o -Kfast,openmp,zfill -o stream.exe
#fcc -Kfast,preex -Kopenmp -Kzfill -Kstriping=4 -Kcmodel=large -DSTREAM_ARRAY_SIZE=256000000 stream.c -o stream.exe
#fcc -Kfast,openmp,zfill -Kstriping=4 -Kcmodel=large -DSTREAM_ARRAY_SIZE=256000000 stream.c -o stream.exe

# Triad:         776058.7     0.007971     0.007917     0.008017
#fcc stream.c -Kfast,openmp,zfill -o stream.exe -DSTREAM_ARRAY_SIZE=256000000

# Triad:         769431.6     0.008009     0.007985     0.008068
#fcc -c stream.c -Kfast,openmp,zfill -o stream.o -DSTREAM_ARRAY_SIZE=256000000
#fcc stream.o -Kfast,openmp,zfill -o stream.exe

# Triad:         772522.4     0.008004     0.007953     0.008066
#fcc -c -Kfast,openmp,zfill -DSTREAM_ARRAY_SIZE=256000000 -DNTIMES=20 -o stream.o stream.c
#fcc -Kfast,openmp,zfill -DSTREAM_ARRAY_SIZE=256000000 -DNTIMES=20 -o stream.exe stream.o

fcc -c -Kfast,openmp,zfill -DSTREAM_ARRAY_SIZE=256000000 -DNTIMES=20 -o stream.o stream.c
fcc -Kfast,openmp,zfill -DSTREAM_ARRAY_SIZE=256000000 -DNTIMES=20 -o stream.exe stream.o


#make clean all COMPILER=fujitsu

./stream.exe
#./stream_openmp.exe

