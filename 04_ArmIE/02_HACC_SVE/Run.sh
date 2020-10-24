#!/bin/bash
make clean all

# Will fail - due to SVE instructions

./HACCKernels

# Run with ArmIE

armie -msve-vector-bits=128 -- ./HACCKernels
