#!/bin/bash
echo " Building with vectorisation reports: at O3"
echo ""

make -f Makefile.O3 clean all

echo ""
echo ""

echo " Building with vectorisation reports: at Ofast"
echo ""

make -f Makefile.Ofast clean all

# Run with ArmIE

armie -msve-vector-bits=512 -i libinscount_emulated.so -- ./HACCKernels_Ofast 

