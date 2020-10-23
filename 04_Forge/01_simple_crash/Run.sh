#!/bin/bash
set -x #echo on

make clean all
mpirun --report-bindings --bind-to core -np 8 ./mmult1_f90.exe

make clean all DEBUG=1
ddt --connect mpirun --report-bindings --bind-to core -np 8 ./mmult1_f90.exe
