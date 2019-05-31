include ../common/make.def

#GNU
CFLAGS=-g -O0 -fno-inline
#intel
#CFLAGS=-g -O0 -fno-inline-functions
#PGI
#CFLAGS=-g -O0 -Meh_frame -Mframe

LFLAGS=-lm -lrt

all: imbpow ovstr

imbpow: imbpow.f90
	$(FC) ${CFLAGS} imbpow.f90 -o imbpow.exe ${LFLAGS}

ovstr: ovstr.f90
	$(FC) ${CFLAGS} ovstr.f90 -o ovstr.exe ${LFLAGS}

clean:
	-rm -f ./imbpow.exe ./ovstr.exe
