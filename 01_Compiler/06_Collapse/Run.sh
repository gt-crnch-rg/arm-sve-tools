#!/bin/bash
make clean all
OMP_NUM_THREADS=2 OMP_PROC_BIND=spread ./mat_mult_6 1024 1024 1024 128

