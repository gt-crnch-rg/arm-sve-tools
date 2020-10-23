include ../config.mk

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
	$(RUN) ./$(EXE_DEF) $(MATRIX_SIZE)
	$(RUN) ./$(EXE_OPT) $(MATRIX_SIZE)
	$(RUN) ./$(EXE_OPT_NOVEC) $(MATRIX_SIZE)

$(EXE_DEF): $(SRC)
	$(call print_version)
	$(CXX) $(CXXFLAGS_REPORT) -o $@ $<

$(EXE_OPT): $(SRC)
	$(call print_version)
	$(CXX) $(CXXFLAGS_REPORT) $(CXXFLAGS_OPT) -o $@ $<

$(EXE_OPT_NOVEC): $(SRC)
	$(call print_version)
	$(CXX) $(CXXFLAGS_REPORT) $(CXXFLAGS_OPT) $(CXXFLAGS_NOVEC) -o $@ $<

