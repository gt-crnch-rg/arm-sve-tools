CXX = g++
CXXFLAGS = -mcpu=a64fx

ifndef FLAVOR
$(error FLAVOR not defined)
endif
EXE = fmla_$(FLAVOR).exe

EXES = fmla_neon128.exe fmla_sve512.exe fmla_a64fx.exe
SRCS = $(wildcard *.cc)
HDRS = $(wildcard *.h)
OBJS = $(SRCS:.cc=.o)

.PHONY: all clean run

all: $(EXE)

clean:
	rm -f $(OBJS) $(EXES)

run: $(EXE)
	$(RUN) ./$^

$(EXE): fmla-$(FLAVOR).o
	$(CXX) $(CXXFLAGS) -o $@ $^

%.o: %.cc Makefile $(HDRS)
	$(CXX) -c $(CXXFLAGS) -o $@ $<

