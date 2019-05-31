#!/bin/bash
make clean all SVE=1

OMP_NUM_THREADS=1 armie -e libmemtrace_sve_512.so -i libmemtrace_simple.so -- ./accelerate_sve -nx 500 -ny 500 -its 10
