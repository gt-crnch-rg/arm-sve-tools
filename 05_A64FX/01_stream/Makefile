NTIMES = 20

# Total memory: 24GB 
#STREAM_ARRAY_SIZE = 1073741808
# Total memory: 6GB
#STREAM_ARRAY_SIZE = 268435440

# A highly convinent stream size: (48[cores] * 32[elem per cache line] * 1000000)
STREAM_ARRAY_SIZE = 1228800000

OMP_ENV = OMP_NUM_THREADS=48 OMP_PROC_BIND=close
NUMACTL = numactl -C 0-47 -l


CC = gcc
CFLAGS = -Ofast -mcpu=a64fx -fopenmp -DSTREAM_ARRAY_SIZE=$(STREAM_ARRAY_SIZE)UL -DNTIMES=$(NTIMES)

VANILLA_EXE = stream_vanilla.exe
ACLE_EXE = stream_acle.exe
ZFILL_EXE = stream_zfill.exe

EXES = $(VANILLA_EXE) $(ACLE_EXE) $(ZFILL_EXE)
SRCS = $(wildcard *.c)
HDRS = $(wildcard *.h)
OBJS = $(SRCS:.c=.o)

.PHONY: all clean run_vanilla run_zfill

all: $(EXES)

clean:
	rm -f $(OBJS) $(EXES)

run_vanilla: $(VANILLA_EXE)
	$(OMP_ENV) $(NUMACTL) ./$^

run_acle: $(ACLE_EXE)
	$(OMP_ENV) $(NUMACTL) ./$^

run_zfill: $(ZFILL_EXE)
	$(OMP_ENV) $(NUMACTL) ./$^

$(VANILLA_EXE): stream.o kernel-vanilla.o
	$(CC) $(CFLAGS) -o $@ $^

$(ACLE_EXE): stream.o kernel-acle.o
	$(CC) $(CFLAGS) -o $@ $^

$(ZFILL_EXE): stream.o kernel-zfill.o
	$(CC) $(CFLAGS) -o $@ $^

%.o: %.c Makefile $(HDRS)
	$(CC) -c $(CFLAGS) -o $@ $<

