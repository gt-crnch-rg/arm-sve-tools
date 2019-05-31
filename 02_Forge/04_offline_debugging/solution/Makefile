include ../../common/make.def

DEBUG=1

CFLAGS=-g
LFLAGS=-lm

ifeq ($(DEBUG),1)
CFLAGS+=-O0 -DDEBUG
else
CFLAGS+=-O3
endif

SRC_C=$(wildcard *.c)
SRC_F=$(wildcard *.f90)
BIN_C=$(SRC_C:%.c=%_c.exe)
BIN_F=$(SRC_F:%.f90=%_f90.exe)


all: $(BIN_C) $(BIN_F)

%_c.exe: %.c
	$(CC) $(CFLAGS) -std=c99 $< -o $@ $(LFLAGS)

%_f90.exe: %.f90
	$(FC) $(CFLAGS) -cpp $< -o $@ $(LFLAGS)

clean:
	-rm -f $(BIN_C) $(BIN_F) res*.mat
