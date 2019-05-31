
opt=-Ofast -mtune=native
arch=-march=armv8-a+sve


target=dotprod_serial dotprod_autovec dotprod_sve

all: $(target)
	../disassemble.sh $(target)

dotprod_serial: dotprod_serial.c
	armclang $(arch) $(opt) -fno-vectorize -o $@ $<

dotprod_autovec: dotprod_serial.c
	armclang $(arch) $(opt) -o $@ $<

dotprod_sve: dotprod_sve.c
	armclang $(arch) $(opt) -o $@ $<

clean: 
	rm -f $(target) *.dis
