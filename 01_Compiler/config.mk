COMPILER ?= gnu

ifeq (gnu,$(COMPILER))

CC = gcc
CXX = g++
FC = gfortran

FLAGS_VERSION = --version

FLAGS_REPORT = -fopt-info-vec-loop

FLAGS_DEBUG = -g

CFLAGS_OPT    = -Ofast -mcpu=native
CFLAGS_NOVEC  = -fno-tree-vectorize
CFLAGS_REPORT = $(FLAGS_REPORT)

CXXFLAGS_OPT    = -Ofast -mcpu=native
CXXFLAGS_NOVEC  = -fno-tree-vectorize
CXXFLAGS_REPORT = $(FLAGS_REPORT)

FFLAGS_OPT    = -Ofast -mcpu=native
FFLAGS_NOVEC  = -fno-tree-vectorize
FFLAGS_REPORT = $(FLAGS_REPORT)

else
ifeq (arm,$(COMPILER))

CC = armclang
CXX = armclang++
FC = armflang

FLAGS_VERSION = --version

FLAGS_REPORT = -Rpass=\(loop-vectorize\|loop-unroll\) 

FLAGS_DEBUG = -g

CFLAGS_OPT    = -Ofast -mcpu=native
CFLAGS_NOVEC  = -fno-vectorize
CFLAGS_REPORT = $(FLAGS_REPORT)

CXXFLAGS_OPT    = -Ofast -mcpu=native
CXXFLAGS_NOVEC  = -fno-vectorize
CXXFLAGS_REPORT = $(FLAGS_REPORT)

FFLAGS_OPT    = -Ofast -mcpu=native
FFLAGS_NOVEC  = -fno-vectorize
FFLAGS_REPORT = $(FLAGS_REPORT)

else
ifeq (fujitsu,$(COMPILER))

CC = fcc
CXX = FCC
FC = frt

VERSION_FLAG = --version

else
ifeq (cray,$(COMPILER))

CC = cc
CXX = CC
fc = ftn

VERSION_FLAG = --version

$(error Invalid parameter: COMPILER=$(COMPILER))

endif
endif
endif
endif

print_version = @echo "------------------------------------------------" && $(CC) $(FLAGS_VERSION)
