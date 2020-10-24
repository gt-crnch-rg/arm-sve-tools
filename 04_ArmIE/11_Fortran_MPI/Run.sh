#!/bin/bash
./Clean.sh

cd CloverLeaf_ref

make COMPILER=ARM

cp clover_leaf ../

cd ../

OMP_NUM_THREADS=2 OMP_PROC_BIND=spread mpirun -np 4 armie -msve-vector-bits=512 -i libopcodes_emulated.so -- ./clover_leaf

