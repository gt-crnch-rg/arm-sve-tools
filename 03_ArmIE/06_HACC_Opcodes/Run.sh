#!/bin/bash
make clean all

armie -msve-vector-bits=512 -i libopcodes_emulated.so -- ./HACCKernels 200

export LLVM_MC="$(dirname $(which armclang))/../llvm-bin/llvm-mc"
awk '{print $3}' undecoded.txt | enc2instr.py -mattr=+sve | awk -F: '{print $2}' | paste undecoded.txt /dev/stdin


