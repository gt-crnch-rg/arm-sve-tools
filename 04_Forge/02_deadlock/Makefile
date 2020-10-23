####### Definitions
include ../common/make.def

OBJECTS = cpi.o
CFLAGS = -g -O0
LFLAGS = 
TARGET = cpi.exe

####### Implicit rules

.SUFFIXES: .f90
.f90.o:
	$(FC) -c $(CFLAGS) -o $@ $<

####### Target

$(TARGET) : $(OBJECTS)
	$(FC) $(CFLAGS)  $(OBJECTS) -o $(TARGET) $(LFLAGS)

####### Clean

.PHONY : clean
clean :
	-rm -f $(TARGET) core $(OBJECTS) *~
