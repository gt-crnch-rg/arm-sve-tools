#!/bin/bash
make clean; make

mpirun --report-bindings --bind-to core -np 4 ./cpi.exe

mpirun --report-bindings --bind-to core -np 8 ./cpi.exe
 
ddt --connect mpirun --report-bindings --bind-to core -np 8 ./cpi.exe

