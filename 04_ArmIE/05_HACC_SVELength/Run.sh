#!/bin/bash
make clean all

# Run with ArmIE
echo "Scaling study for different SVE vector lengths"

for i in 128 256 512 1024 2048
do
  echo "HACCKernels with emulated SVE vector length of "$i" bits - Instruction Count"
  armie -msve-vector-bits="$i" -i libinscount_emulated.so -- ./HACCKernels 100 2>&1 | grep "instructions executed"
  echo ""
done
