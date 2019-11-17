#!/bin/bash
make clean all
set -x
OMP_NUM_THREADS=16 OMP_PROC_BIND=spread ./mat_mult_6 1024 1024 1024 128

