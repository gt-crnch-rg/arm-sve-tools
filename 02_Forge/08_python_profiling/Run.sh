#!/bin/bash
mpirun --report-bindings --bind-to core -np 8 python ./diffusion-fv-2d.py

map --profile mpirun --report-bindings --bind-to core -np 8 python ./diffusion-fv-2d.py


