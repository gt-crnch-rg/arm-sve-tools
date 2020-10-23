#!/bin/bash
make clean all

#Run with ArmIE

echo "Dot Product - Scaling with different VL"
for vl in 128 256 512 1024 2048
do
    echo "FLMA  with vector length $vl"
    armie -msve-vector-bits=$vl -i libinscount_emulated.so -- ./complex_dotprod_fmla 2>&1 | grep "instructions executed"
    echo "FCMLA with vector length $vl"
    armie -msve-vector-bits=$vl -i libinscount_emulated.so -- ./complex_dotprod_fcmla 2>&1 | grep "instructions executed"
done
