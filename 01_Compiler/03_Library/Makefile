include ../config.mk

MATRIX_SIZE = 1024 1024 1024

SRC = mm_lib.cpp

EXE = mm_lib_$(COMPILER).exe


.PHONY: all clean run

all: $(EXE)

clean:
	rm -f *.o *.exe *.opt.yaml

run: $(EXE)
	$(RUN) ./$(EXE) $(MATRIX_SIZE)

$(EXE): $(SRC)
	$(call print_version)
	$(CXX) $(CXXFLAGS_REPORT) $(CXXFLAGS_OPT) $(CXXFLAGS_LIBRARY) -o $@ $< $(LDFLAGS_LIBRARY)
