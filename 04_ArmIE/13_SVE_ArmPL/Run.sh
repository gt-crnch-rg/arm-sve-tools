#!/bin/bash
make clean all


echo " == Executing Auto Vec Mat Mult == "
echo ""
armie -msve-vector-bits=512 -i libinscount_emulated.so -- ./mat_mult_blocked 512 512 512 128 | grep "emulated instructions"
echo ""
echo " == Executing ArmPL Mat Mult == "
echo ""
echo ""
armie -msve-vector-bits=512 -i libinscount_emulated.so -- ./mat_mult_armpl 512 512 512 128 | grep "emulated instructions"
echo ""
echo " == Executing SVE ArmPL Mat Mult == "
echo ""
echo ""
armie -msve-vector-bits=512 -i libinscount_emulated.so -- ./mat_mult_armpl_sve 512 512 512 128 | grep "emulated instructions"

