#!/bin/bash
make clean all


#Run with ArmIE

echo "Serial"
./reduction_max_serial
echo "Scaling with different VL"
for vl in 128 256 512 1024 2048
do
    echo "Reduction with emulated SVE vector length of $vl"
    armie -msve-vector-bits=$vl -i libinscount_emulated.so --from-app-only -- ./reduction_max_sve 2>&1 | grep "instructions executed"
done
