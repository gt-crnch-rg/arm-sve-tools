#!/bin/bash
./Clean.sh

rm -rf 12_neon 12_sve 

echo ""
echo " == Building for NEON =="
echo ""
echo ""
armclang -O3 -g -mcpu=native -march=armv8-a 12_neon_vs_sve.c -Rpass=loop-vectorize -Rpass-missed=loop-vectorize -Rpass-analysis=loop-vectorize -o 12_neon

echo ""
echo ""
echo ""
echo " == Building for SVE =="
echo ""
echo ""
armclang -O3 -g -mcpu=native -march=armv8-a+sve 12_neon_vs_sve.c -Rpass=loop-vectorize -Rpass-missed=loop-vectorize -Rpass-analysis=loop-vectorize -o 12_sve

echo ""
echo ""

echo " == Executing NEON == "
echo ""
armie -msve-vector-bits=512 -i libinscount_emulated.so -- ./12_neon 100000 | grep "emulated instructions"
echo ""
echo " == Executing SVE == "
echo ""
echo ""
armie -msve-vector-bits=512 -i libinscount_emulated.so -- ./12_sve 100000 | grep "emulated instructions"
