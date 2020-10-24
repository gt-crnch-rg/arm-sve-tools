include ../config.mk

# Input parameters for `make run`
MATRIX_SIZE = 1024 1024 1024
BLOCK_SIZE = 128


SRC = mm_vec.cpp

EXE_DEF       = mm_vec_$(COMPILER)_def.exe
EXE_OPT       = mm_vec_$(COMPILER)_opt.exe
EXE_OPT_NOVEC = mm_vec_$(COMPILER)_opt_novec.exe

EXE = $(EXE_DEF) $(EXE_OPT) $(EXE_OPT_NOVEC)


.PHONY: all clean run

all: $(EXE)

clean:
	rm -f *.o *.exe *.opt.yaml

run: $(EXE)
	$(call print_hline)
	$(RUN) ./$(EXE_DEF) $(MATRIX_SIZE) $(BLOCK_SIZE)
	$(call print_hline)
	$(RUN) ./$(EXE_OPT) $(MATRIX_SIZE) $(BLOCK_SIZE)
	$(call print_hline)
	$(RUN) ./$(EXE_OPT_NOVEC) $(MATRIX_SIZE) $(BLOCK_SIZE)
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

