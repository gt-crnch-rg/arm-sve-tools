#------------------------------------------------------------------------------------
# Copyright (C) Arm Limited, 2019-2020 All rights reserved.
#
# The example code is provided to you as an aid to learning when working
# with Arm-based technology, including but not limited to programming tutorials.
#
# Arm hereby grants to you, subject to the terms and conditions of this Licence,
# a non-exclusive, non-transferable, non-sub-licensable, free-of-charge copyright
# licence, to use, copy and modify the Software solely for the purpose of internal
# demonstration and evaluation.
#
# You accept that the Software has not been tested by Arm therefore the Software
# is provided "as is", without warranty of any kind, express or implied. In no
# event shall the authors or copyright holders be liable for any claim, damages
# or other liability, whether in action or contract, tort or otherwise, arising
# from, out of or in connection with the Software or the use of Software.
#------------------------------------------------------------------------------------

COMPILER ?= gnu

#############################################################################
# GNU compiler flags
#############################################################################
ifeq (gnu,$(COMPILER))

LIBRARY ?= cblas

CC = gcc
CXX = g++
FC = gfortran

FLAGS_VERSION = --version

CFLAGS_OPT    = -Ofast -mcpu=native
CFLAGS_NOVEC  = -fno-tree-vectorize
CFLAGS_REPORT = -fopt-info-all-vec
CFLAGS_OPENMP = -fopenmp

CXXFLAGS_OPT    = $(CFLAGS_OPT)
CXXFLAGS_NOVEC  = $(CFLAGS_NOVEC)
CXXFLAGS_REPORT = $(CFLAGS_REPORT)
CXXFLAGS_OPENMP = $(CFLAGS_OPENMP)

FFLAGS_OPT    = $(CFLAGS_OPT)
FFLAGS_NOVEC  = $(CFLAGS_NOVEC)
FFLAGS_REPORT = $(CFLAGS_REPORT)
FFLAGS_OPENMP = $(CFLAGS_OPENMP)

else
#############################################################################
# Arm compiler flags
#############################################################################
ifeq (arm,$(COMPILER))

LIBRARY ?= armpl

CC = armclang
CXX = armclang++
FC = armflang

FLAGS_VERSION = --version

CFLAGS_OPT    = -Ofast -mcpu=native
CFLAGS_NOVEC  = -fno-vectorize
CFLAGS_REPORT = -Rpass=\(loop-vectorize\) -Rpass-missed=\(loop-vectorize\)
CFLAGS_OPENMP = -fopenmp

CXXFLAGS_OPT    = $(CFLAGS_OPT)
CXXFLAGS_NOVEC  = $(CFLAGS_NOVEC)
CXXFLAGS_REPORT = $(CFLAGS_REPORT)
CXXFLAGS_OPENMP = $(CFLAGS_OPENMP)

FFLAGS_OPT    = $(CFLAGS_OPT)
FFLAGS_NOVEC  = $(CFLAGS_NOVEC)
FFLAGS_REPORT = $(CFLAGS_REPORT)
FFLAGS_OPENMP = $(CFLAGS_OPENMP)

else
#############################################################################
# Fujitsu compiler flags
#############################################################################
ifeq (fujitsu,$(COMPILER))

LIBRARY ?= ssl2

CC = fcc
CXX = FCC
FC = frt

FLAGS_VERSION = --version

CFLAGS_OPT    = -Kfast
CFLAGS_NOVEC  = -KNOSVE
CFLAGS_REPORT = 
CFLAGS_OPENMP = -Kopenmp -Nfjomplib

CXXFLAGS_OPT    = $(CFLAGS_OPT)
CXXFLAGS_NOVEC  = $(CFLAGS_NOVEC)
CXXFLAGS_REPORT = $(CFLAGS_REPORT)
CXXFLAGS_OPENMP = $(CFLAGS_OPENMP)

FFLAGS_OPT    = $(CFLAGS_OPT)
FFLAGS_NOVEC  = $(CFLAGS_NOVEC)
FFLAGS_REPORT = $(CFLAGS_REPORT)
FFLAGS_OPENMP = $(CFLAGS_OPENMP)

else
#############################################################################
# Cray compiler flags
#############################################################################
ifeq (cray,$(COMPILER))

CC = cc
CXX = CC
fc = ftn

VERSION_FLAG = --version

else
#############################################################################
# Help message
#############################################################################
ifeq (help,$(COMPILER))

$(info COMPILER can be one of: gnu, arm, fujitsu, cray)
$(info  * gnu: GNU Compiler)
$(info  * arm: Arm Compiler for Linux)
$(info  * fujitsu: Fujitsu Compiler)
$(info  * cray: Cray Compiler)
$(error )

else
#############################################################################
# Error handling
#############################################################################

$(error Invalid parameter: COMPILER=$(COMPILER))

#############################################################################
endif
endif
endif
endif
endif
#############################################################################


#############################################################################
# Generic CBLAS library flags
#############################################################################
ifeq (cblas,$(LIBRARY))

CFLAGS_LIBRARY   = -DUSE_CBLAS
CXXFLAGS_LIBRARY = -DUSE_CBLAS
FFLAGS_LIBRARY   = -DUSE_CBLAS
LDFLAGS_LIBRARY  = -lcblas -lm

else
#############################################################################
# Arm Performance Library (ArmPL) library flags
#############################################################################
ifeq (armpl,$(LIBRARY))

ifeq (arm,$(COMPILER))
# The Arm compiler automatically knows where to find ArmPL and will 
# automatically enable OpenMP if the -fopenmp flag is present
CFLAGS_LIBRARY   = -armpl -DUSE_ARMPL
CXXFLAGS_LIBRARY = -armpl -DUSE_ARMPL
FFLAGS_LIBRARY   = -armpl -DUSE_ARMPL
LDFLAGS_LIBRARY  = -armpl
else
# If not using the Arm compiler, make sure to load the ArmPL module.
# ARMPL_INCLUDES and ARMPL_LIBRARIES are set by the ArmPL modulefile
CFLAGS_LIBRARY   = -I$(ARMPL_INCLUDES) -DUSE_ARMPL
CXXFLAGS_LIBRARY = -I$(ARMPL_INCLUDES) -DUSE_ARMPL
FFLAGS_LIBRARY   = -I$(ARMPL_INCLUDES) -DUSE_ARMPL
LDFLAGS_LIBRARY  = -L$(ARMPL_LIBRARIES) -larmpl -lamath -lastring
endif

else
#############################################################################
# Fujitsu SSL II library flags
#############################################################################
ifeq (ssl2,$(LIBRARY))

ifeq (fujitsu,$(COMPILER))
CFLAGS_LIBRARY   = -SSL2 -DUSE_SSL2
CXXFLAGS_LIBRARY = -SSL2 -DUSE_SSL2
FFLAGS_LIBRARY   = -SSL2 -DUSE_SSL2
LDFLAGS_LIBRARY  = -SSL2
else
$(error SSL2 can only be used with the Fujitsu compiler)
endif

else
#############################################################################
# Error handling
#############################################################################

$(error Invalid parameter: LIBRARY=$(LIBRARY))

#############################################################################
endif
endif
endif
#############################################################################

print_hline = @echo "------------------------------------------------"
print_version = $(CC) $(FLAGS_VERSION)
print_banner = $(call print_hline) @echo $1 $(call print_hline)


