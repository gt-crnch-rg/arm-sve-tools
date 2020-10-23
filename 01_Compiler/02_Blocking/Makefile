include ../config.mk

MATRIX_SIZE = 1024 1024 1024
BLOCK_SIZE = 128

SRC = mm_blk.cpp

EXE_DEF       = mm_blk_$(COMPILER)_def.exe
EXE_OPT       = mm_blk_$(COMPILER)_opt.exe
EXE_OPT_NOVEC = mm_blk_$(COMPILER)_opt_novec.exe

EXE = $(EXE_DEF) $(EXE_OPT) $(EXE_OPT_NOVEC)


.PHONY: all clean run

all: $(EXE)

clean:
	rm -f *.o *.exe *.opt.yaml

run: $(EXE)
	$(RUN) ./$(EXE_DEF) $(MATRIX_SIZE) $(BLOCK_SIZE)
	$(RUN) ./$(EXE_OPT) $(MATRIX_SIZE) $(BLOCK_SIZE)
	$(RUN) ./$(EXE_OPT_NOVEC) $(MATRIX_SIZE) $(BLOCK_SIZE)

$(EXE_DEF): $(SRC)
	$(call print_version)
	$(CXX) $(CXXFLAGS_REPORT) -o $@ $<

$(EXE_OPT): $(SRC)
	$(call print_version)
	$(CXX) $(CXXFLAGS_REPORT) $(CXXFLAGS_OPT) -o $@ $<

$(EXE_OPT_NOVEC): $(SRC)
	$(call print_version)
	$(CXX) $(CXXFLAGS_REPORT) $(CXXFLAGS_OPT) $(CXXFLAGS_NOVEC) -o $@ $<

