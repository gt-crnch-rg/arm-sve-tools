
opt=-Ofast
arch=-march=armv8-a+sve


target=reduction_max_serial reduction_max_sve

all: $(target)
	../disassemble.sh $(target)

reduction_max_serial: reduction_max_serial.c
	armclang $(arch) $(opt) -o $@ $<

reduction_max_sve: reduction_max_sve.c
	armclang $(arch) $(opt) -o $@ $<

clean: 
	rm -f $(target) *.dis
