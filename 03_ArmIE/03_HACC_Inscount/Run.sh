#!/bin/bash
make clean all

# Run with ArmIE

armie -msve-vector-bits=128 -i libinscount_emulated.so -- ./HACCKernels

armie -msve-vector-bits=128 -i libinscount_emulated.so --from-app-only -- ./HACCKernels

