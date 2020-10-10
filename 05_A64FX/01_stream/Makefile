NTIMES = 20

# Total memory: 96GB
#STREAM_ARRAY_SIZE = 4294967296
# Total memory: 48GB
#STREAM_ARRAY_SIZE = 2147483648
# Total memory: 24GB 
STREAM_ARRAY_SIZE = 1073741824
# Total memory: 6GB
#STREAM_ARRAY_SIZE = 268435456

CC = gcc
CFLAGS = -Ofast -mcpu=native -fopenmp -DSTREAM_ARRAY_SIZE=$(STREAM_ARRAY_SIZE)UL -DNTIMES=$(NTIMES)

EXES = stream_vanilla.exe
SRCS = $(wildcard *.c)
HDRS = $(wildcard *.h)
OBJS = $(SRCS:.c=.o)

.PHONY: all clean

all: $(EXES)

clean:
	rm -f $(OBJS) $(EXES)

stream_vanilla.exe: stream.o kernel-vanilla.o
	$(CC) $(CFLAGS) -o $@ $^

%.o: %.c $(HDRS)
	$(CC) -c $(CFLAGS) -o $@ $<

