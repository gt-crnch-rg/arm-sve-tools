
opt=-Ofast
arch=-march=armv8-a+sve


target=gather_struct_serial gather_struct_sve

all: $(target)
	../disassemble.sh $(target)

gather_struct_serial: gather_struct_serial.c
	armclang $(arch) $(opt) -o $@ $<
	
gather_struct_sve: gather_struct_sve.c
	armclang $(arch) $(opt) -o $@ $<

clean: 
	rm -f $(target) *.dis
