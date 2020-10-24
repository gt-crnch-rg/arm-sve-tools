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

include ../config.mk

# Input parameters for `make run`
MATRIX_SIZE = 1024 1024 1024


SRC = mm.cpp

EXE_DEF       = mm_$(COMPILER)_def.exe
EXE_OPT       = mm_$(COMPILER)_opt.exe
EXE_OPT_NOVEC = mm_$(COMPILER)_opt_novec.exe

EXE = $(EXE_DEF) $(EXE_OPT) $(EXE_OPT_NOVEC)


.PHONY: all clean run

all: $(EXE)

clean:
	rm -f *.o *.exe *.opt.yaml

run: $(EXE)
	$(call print_hline)
	$(RUN) ./$(EXE_DEF) $(MATRIX_SIZE)
	$(call print_hline)
	$(RUN) ./$(EXE_OPT) $(MATRIX_SIZE)
	$(call print_hline)
	$(RUN) ./$(EXE_OPT_NOVEC) $(MATRIX_SIZE)
	$(call print_hline)

$(EXE_DEF): $(SRC)
	$(call print_hline)
	$(call print_version)
	$(CXX) $(CXXFLAGS_REPORT) -o $@ $<
	$(call print_hline)

$(EXE_OPT): $(SRC)
	$(call print_hline)
	$(call print_version)
	$(CXX) $(CXXFLAGS_REPORT) $(CXXFLAGS_OPT) -o $@ $<
	$(call print_hline)

$(EXE_OPT_NOVEC): $(SRC)
	$(call print_hline)
	$(call print_version)
	$(CXX) $(CXXFLAGS_REPORT) $(CXXFLAGS_OPT) $(CXXFLAGS_NOVEC) -o $@ $<
	$(call print_hline)

