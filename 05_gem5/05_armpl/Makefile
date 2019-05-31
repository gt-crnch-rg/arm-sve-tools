# Update as needed
ARM_COMPILER = arm-hpc-compiler-19.1
GCC_COMPILER = gcc-8.2.0
ARCH = armv8-a+sve
OS = RHEL-7
SYSLIB = /usr/lib64

# Set to ARM_COMPILER or GCC_COMPILER
COMPILER = $(ARM_COMPILER)
#COMPILER = $(GCC_COMPILER)

GCC_LIB = /opt/arm/$(GCC_COMPILER)_Generic-AArch64_$(OS)_aarch64-linux/lib64
GCC_SYSLIB = /opt/arm/$(GCC_COMPILER)_Generic-AArch64_$(OS)_aarch64-linux/lib/gcc/aarch64-linux-gnu/$(subst gcc-,,$(GCC_COMPILER))
COMPILER_LIB = /opt/arm/$(COMPILER)_Generic-AArch64_$(OS)_aarch64-linux/lib

ifneq (,$(findstring arm,$(COMPILER)))
CC = armclang++
CFLAGS = -DDEBUG=1 -std=c++11 -Ofast -march=$(ARCH) -fsimdmath -armpl
CFLAG_VEC_REPORT = -Rpass=\(loop-vectorize\|inline\)=
ARMPL_LIB = -lflang -larmpl_lp64
else
CC = g++
CFLAGS = -DDEBUG=1 -std=c++11 -Ofast -march=$(ARCH)
CFLAG_VEC_REPORT = -fopt-info-all=
ARMPL_LIB = -lpthread -larmpl_lp64
endif

ifeq (,$(findstring $(subst -$(lastword $(subst -, ,$(COMPILER))),,$(COMPILER)),$(ARMPL_LIBRARIES)))
$(error Please load the ArmPL environment module that matches your compiler: $(COMPILER))
endif

AS              = as
ASFLAGS         = -march=$(ARCH)

LD              = ld
LDFLAGS         = \
		-Bstatic -X -EL -maarch64linux --fix-cortex-a53-843419 \
		$(SYSLIB)/crt1.o $(SYSLIB)/crti.o $(GCC_SYSLIB)/crtbegin.o

LIBS            = \
                -L$(SYSLIB) -L$(COMPILER_LIB) -L$(GCC_LIB) -L$(GCC_SYSLIB) -L$(ARMPL_LIBRARIES) \
		-lstdc++ -lm -lgomp -ldl --start-group -lgcc -lgcc_eh $(ARMPL_LIB) -lc --end-group \
		$(GCC_SYSLIB)/crtend.o $(SYSLIB)/crtn.o

TARGET = $(wildcard *.cpp)
EXES  = $(TARGET:.cpp=.axf)

.PHONY: clean all

all default: $(EXES)

%.axf: %.cpp
	$(CC) $(CFLAGS) -S -o $(basename $@).s $<
	$(CC) $(CFLAGS) $(CFLAG_VEC_REPORT)$(basename $@)_vec_report.log -c $<
	$(CC) $(CFLAGS) -c -o $(basename $@).o $<
	$(LD) $(LDFLAGS) $(basename $@).o $(LIBS) -o $@

clean:
	rm -rf *.axf *.o *.s *.lst m5out *.log
