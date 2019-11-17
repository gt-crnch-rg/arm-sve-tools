#include ../common/make.def
FC=mpifort

all: imbpow ovstr
# Flags for compiler inlining: MAP works whether inlining is on or off,
# but you'll typically see more intuitive stacks with it turned off.
# The major compilers are discussed here:
#
# Intel: -g -fno-inline-functions -fno-omit-frame-pointer -O3 is recommended.
#
# PGI: -g -O3 -Meh_frame -Mframe is recommended.
#
# GNU: -g -O3 -fno-inline is recommended. You might be lucky without -fno-inline,
# as it should produce enough information to unwind those calls. You will see
# my_function [inlined] in the MAP stack for functions that were inline.
# -fno-inline-functions appears with newer gnu compilers, just to confuse

# gnu
# intel
#	${MPIF90} -g -fno-inline-functions -fno-omit-frame-pointer -O3 slow.f90 -o slow_f -lm -lrt
# pgi
#	${MPIF90} -g -Meh_frame -Mframe -O3 slow.f90 -o slow_f -lm -lrt
imbpow: imbpow.f90
	$(FC) -g -O3 -fno-inline imbpow.f90 -o imbpow.exe -lm -lrt
ovstr: ovstr.f90
	$(FC) -g -O3 -fno-inline ovstr.f90 -o ovstr.exe -lm -lrt

clean:
	-rm -f ./imbpow.exe ./ovstr.exe
