#!/bin/bash
make clean all
 
perf-report --output=result.html mpirun --report-bindings --bind-to core -np 8 ./*_c.exe 3096

perf-report --output=result.txt mpirun --report-bindings --bind-to core -np 8 ./*_c.exe 3096

