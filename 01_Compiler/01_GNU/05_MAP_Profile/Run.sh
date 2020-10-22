#!/bin/bash
make clean all
OMP_NUM_THREADS=2 OMP_PROC_BIND=spread map --profile --no-mpi ./mat_mult_5 2048 2048 2048 128
