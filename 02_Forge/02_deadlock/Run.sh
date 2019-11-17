#!/bin/bash
set -x #echo on

make clean; make

mpirun --report-bindings --bind-to core -np 4 ./cpi.exe

mpirun --report-bindings --bind-to core -np 8 ./cpi.exe &

ddt --connect
echo "Remember to kill this deadlock application with Ctrl+C after closing the debugger otherwise it will consume CPU cycles"
wait
