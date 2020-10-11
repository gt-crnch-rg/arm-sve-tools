NTIMES = 20

# Total memory: 24GB 
STREAM_ARRAY_SIZE = 1073741824
# Total memory: 6GB
#STREAM_ARRAY_SIZE = 268435440
# A convinent stream size: (48[cores] * 32[elem per cache line] * 400000)
#STREAM_ARRAY_SIZE = 614400000

OMP_ENV = OMP_NUM_THREADS=48 OMP_PROC_BIND=close
NUMACTL = numactl -C 0-47 -l
RUN = $(OMP_ENV) $(NUMACTL)

CC = gcc
CFLAGS = -Ofast -mcpu=a64fx -fopenmp -DSTREAM_ARRAY_SIZE=$(STREAM_ARRAY_SIZE)UL -DNTIMES=$(NTIMES)

FLAVOR = openmp
EXE = stream_$(FLAVOR).exe

EXES = $(EXE)
SRCS = $(wildcard *.c)
HDRS = $(wildcard *.h)
OBJS = $(SRCS:.c=.o)

.PHONY: all clean run

all: $(EXES)

clean:
	rm -f $(OBJS) $(EXES)

run: $(EXE)
	$(RUN) ./$^

$(EXE): stream.o kernel-$(FLAVOR).o
	$(CC) $(CFLAGS) -o $@ $^

%.o: %.c Makefile $(HDRS)
	$(CC) -c $(CFLAGS) -o $@ $<

