NTIMES = 10

STREAM_ARRAY_SIZE = 10000000

OMP_ENV = OMP_NUM_THREADS=1 OMP_PROC_BIND=close
NUMACTL = numactl -m 0 -C 0
RUN = $(OMP_ENV) $(NUMACTL)

CC = gcc
CFLAGS = -Ofast -mcpu=a64fx -fopenmp -DSTREAM_ARRAY_SIZE=$(STREAM_ARRAY_SIZE)UL -DNTIMES=$(NTIMES)

FLAVOR = triad
EXE = stream_$(FLAVOR).exe

SRCS = $(wildcard *.c)
HDRS = $(wildcard *.h)
OBJS = $(SRCS:.c=.o)

.PHONY: all clean run

all: $(EXE)

clean:
	rm -f $(OBJS) $(EXE)

run: run-perf

run-perf: $(EXE)
	# r11:   CPU_CYCLES: This event counts every cycle
	# r23:   STALL_FRONTEND: every cycle counted by the CPU_CYCLES 
	#        event on that no operation was issued because there 
	#        are no operations available to issue for this PE from 
	#        the frontend.
	# r24:   STALL_BACKEND: every cycle counted by the CPU_CYCLES 
	#        event on that no operation was issued because the 
	#        backend is unable to accept any operations.
	# r184:  every cycle that no instruction was committed because 
	#        the oldest and uncommitted load/store/prefetch operation 
	#        waits for L1D cache, L2 cache and memory access.
	# r8085: executed operations that read from memory due to SVE 
	#        and Advanced SIMD load instructions.
	# r8086: executed operations that write to memory due to SVE 
	#        and Advanced SIMD store instructions.
	$(RUN) perf stat -e r11,r23,r24,r184,r8085,r8086 ./$(EXE)

$(EXE): stream.o kernel-$(FLAVOR).o
	$(CC) $(CFLAGS) -o $@ $^

%.o: %.c Makefile $(HDRS)
	$(CC) -c $(CFLAGS) -o $@ $<

