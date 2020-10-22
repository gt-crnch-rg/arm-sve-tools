#!/bin/bash
make clean all
set -x

OMP_NUM_THREADS=1 OMP_PROC_BIND=spread ./mat_mult_4 1024 1024 1024 128
OMP_NUM_THREADS=2 OMP_PROC_BIND=spread ./mat_mult_4 1024 1024 1024 128
OMP_NUM_THREADS=4 OMP_PROC_BIND=spread ./mat_mult_4 1024 1024 1024 128

