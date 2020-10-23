#!/bin/bash
make clean all


#Run with ArmIE

echo "Vector add - Scaling with different VL"
for vl in 128 256 512 1024 2048
do
    echo "Vector length $vl - Instruction count"
    echo "			Total	SVE"
    echo -n "NEON autovec:   	"
    armie -msve-vector-bits=$vl -i libinscount_emulated.so -- ./vec_add_cpu 2>&1 | awk '/instructions executed/ {printf("%i\t%i\n", $1,$6)}'
    echo -n "SVE autovec:    	"
    armie -msve-vector-bits=$vl -i libinscount_emulated.so -- ./vec_add_arch 2>&1 | awk '/instructions executed/ {printf("%i\t%i\n", $1,$6)}'
    echo -n "SVE ACLE:       	"
    armie -msve-vector-bits=$vl -i libinscount_emulated.so -- ./vec_add_acle 2>&1 | awk '/instructions executed/ {printf("%i\t%i\n", $1,$6)}'
    echo ""
done


