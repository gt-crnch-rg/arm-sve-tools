#!/bin/bash
make clean all

# Run with ArmIE

armie -msve-vector-bits=128 -i libinscount_emulated.so -- ./HACCKernels

# The option "-only_from_app" workls only if DynamoRIO is invoked directly
export ARMIE_PATH=/opt/arm/arm-instruction-emulator-19.1_Generic-AArch64_RHEL-7_aarch64-linux
export ARMIE_PATH=$(dirname `which armie`)/..
$ARMIE_PATH/bin64/drrun -client $ARMIE_PATH/lib64/release/libsve_512.so 0 "" -client $ARMIE_PATH/samples/bin64/libinscount_emulated.so 1 "-only_from_app" -max_bb_instrs 32 -max_trace_bbs 4 -- ./HACCKernels
