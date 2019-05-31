#!/bin/bash
make clean trisol.exe
 
mpirun --report-bindings --bind-to core -np 8 ./trisol.exe

ddt --connect mpirun --report-bindings --bind-to core -np 8 ./trisol.exe
