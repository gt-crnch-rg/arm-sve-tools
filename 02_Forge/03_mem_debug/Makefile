####### Definitions
include ../common/make.def

OBJECTS = mod_trisol.o trisol.o gendata.o solve.o check.o matnrm.o \
          numroc.o dlaruv.o 
CFLAGS = -O0 -g
LFLAGS = 
TARGET = trisol.exe


####### Implicit rules

.SUFFIXES: .f90 .f
.f.o:
	$(FC) -c $(CFLAGS) -o $@ $<
.f90.o:
	$(FC) -c $(CFLAGS) -o $@ $<

####### Target

$(TARGET) : $(OBJECTS)
	$(FC) $(CFLAGS)  $(OBJECTS) -o $(TARGET) $(LFLAGS)

####### Clean

.PHONY : clean
clean :
	-rm -f $(TARGET) core $(OBJECTS) *~ *.mod
