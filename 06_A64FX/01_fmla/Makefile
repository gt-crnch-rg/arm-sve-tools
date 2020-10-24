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
	./$^

run-perf: $(EXE)
	# r8028: FP_FMA_SPEC: architecturally executed floating-point 
	#        fused multiply-add and multiply-subtract operations
	# r11:   CPU_CYCLES: This event counts every cycle
	# r23:   STALL_FRONTEND: every cycle counted by the CPU_CYCLES 
	#        event on that no operation was issued because there 
	#        are no operations available to issue for this PE from 
	#        the frontend.
	# r24:   STALL_BACKEND: every cycle counted by the CPU_CYCLES 
	#        event on that no operation was issued because the 
	#        backend is unable to accept any operations.
	# r191:  1INST_COMMIT: cycles where one instruction is committed.
	# r192:  2INST_COMMIT: cycles where two instructions are committed.
	# r193:  3INST_COMMIT: cycles where three instructions are committed.
	# r194:  4INST_COMMIT: cycles where four instructions are committed.
	perf stat -e r8028,r11,r23,r24,r191,r192,r193,r194 ./$(EXE)

$(EXE): fmla-$(FLAVOR).o
	$(CXX) $(CXXFLAGS) -o $@ $^

%.o: %.cc Makefile $(HDRS)
	$(CXX) -c $(CXXFLAGS) -o $@ $<

