#!/bin/bash
make clean all
 
map --profile mpirun --report-bindings --bind-to core -np 8 ./*_c.exe 3096

map --export=profile.json *.map
