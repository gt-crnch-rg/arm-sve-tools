#!/bin/bash
make clean all


#Run with ArmIE

echo "Dot Product - Scaling with different VL"
for vl in 128 256 512 1024 2048
do
    echo "Serial  with vector length $vl"
    armie -msve-vector-bits=$vl -i libinscount_emulated.so --from-app-only -- ./dotprod_serial 2>&1 | grep "instructions executed"
    echo "Autovec with vector length $vl"
    armie -msve-vector-bits=$vl -i libinscount_emulated.so --from-app-only -- ./dotprod_autovec 2>&1 | grep "instructions executed"
    echo "ACLE    with vector length $vl"
    armie -msve-vector-bits=$vl -i libinscount_emulated.so --from-app-only -- ./dotprod_sve 2>&1 | grep "instructions executed"
done

