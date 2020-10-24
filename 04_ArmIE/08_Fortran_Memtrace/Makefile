

CC=armclang
FC=armflang

ARCH=armv8-a
ACC=accelerate

ifdef SVE
  ARCH=armv8-a+sve
  ACC=accelerate_sve
endif

FFLAGS = -g -Ofast -fno-stack-arrays -march=$(ARCH)
CFLAGS = -g -Ofast -march=$(ARCH)

all: accelerate

timer: timer_c.c
	$(CC) -c $(CFLAGS) timer_c.c

profiler: profiler_c.c
	$(CC) -c $(CFLAGS) profiler_c.c

accelerate: timer profiler profiler.f90 set_data.f90 accelerate_kernel.f90 timer.f90 accelerate_driver.f90
	$(FC) -o $(ACC) $(FFLAGS) timer_c.o profiler_c.o profiler.f90 set_data.f90 accelerate_kernel.f90 timer.f90 accelerate_driver.f90

clean:
	rm -f accelerate *.o *.mod
