
opt=-Ofast
cpu=-mcpu=native
arch=-march=armv8.2-a+sve

target=vec_add_cpu vec_add_arch vec_add_acle

all: $(target)
	../disassemble.sh $(target)

vec_add_arch: vec_add.c
	armclang $(arch) $(opt) -o $@ $<

vec_add_cpu: vec_add.c
	armclang $(cpu) $(opt) -o $@ $<

vec_add_acle: vec_add_acle.c
	armclang $(arch) $(opt) -o $@ $<

clean: 
	rm -f $(target) *.dis
