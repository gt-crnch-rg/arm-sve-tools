include ../config.mk

MATRIX_SIZE = 2048 2048 2048
BLOCK_SIZE = 128

SRC = mm_omp.cpp


EXE_SER = mm_$(COMPILER)_ser.exe
EXE_OMP = mm_$(COMPILER)_omp.exe

EXE = $(EXE_SER) $(EXE_OMP)

ifeq (fujitsu,$(COMPILER))
# The Fujitsu compiler and SSL 2 require additional environment variables
export FLIB_SCCR_CNTL=TRUE
export FLIB_HPCFUNC=TRUE
export FLIB_HPCFUNC_INFO=TRUE
export FLIB_BARRIER=HARD
export FLIB_FASTOMP=TRUE
export PARALLEL=48
endif

.PHONY: all clean run

all: $(EXE)

clean:
	rm -f *.o *.exe *.opt.yaml

run: $(EXE)
	./$(EXE_SER) $(MATRIX_SIZE) $(BLOCK_SIZE)
	OMP_NUM_THREADS=1 ./$(EXE_OMP) $(MATRIX_SIZE) $(BLOCK_SIZE)
	OMP_NUM_THREADS=2 ./$(EXE_OMP) $(MATRIX_SIZE) $(BLOCK_SIZE)
	OMP_NUM_THREADS=4 ./$(EXE_OMP) $(MATRIX_SIZE) $(BLOCK_SIZE)
	OMP_NUM_THREADS=8 ./$(EXE_OMP) $(MATRIX_SIZE) $(BLOCK_SIZE)

$(EXE_SER): $(SRC)
	$(call print_version)
	$(CXX) $(CXXFLAGS_REPORT) $(CXXFLAGS_OPT) $(CXXFLAGS_LIBRARY) -o $@ $< $(LDFLAGS_LIBRARY)

$(EXE_OMP): $(SRC)
	$(call print_version)
	$(CXX) $(CXXFLAGS_REPORT) $(CXXFLAGS_OPT) $(CXXFLAGS_OPENMP) $(CXXFLAGS_LIBRARY) -o $@ $< $(LDFLAGS_LIBRARY)
