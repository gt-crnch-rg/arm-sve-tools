#!/bin/bash
set -x #echo on

make clean all
 
map --profile mpirun --report-bindings --bind-to core -np 8 ./*_c.exe 3096

map --export=profile.json *.map

map --connect *.map
