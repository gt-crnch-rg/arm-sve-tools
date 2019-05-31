#!/bin/bash
make clean all
 
mpirun --report-bindings --bind-to core -np 8 ./trisol.exe
