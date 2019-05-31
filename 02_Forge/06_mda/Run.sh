#!/bin/bash
make clean; make

mpirun --report-bindings --bind-to core -n 4 ./imbpow.exe : -n 4 ./ovstr.exe

ddt --connect mpirun --report-bindings --bind-to core -n 4 ./imbpow.exe : -n 4 ./ovstr.exe

