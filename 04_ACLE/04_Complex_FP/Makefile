
opt=-Ofast
arch=-march=armv8-a+sve


target=complex_dotprod_fmla complex_dotprod_fcmla

all: $(target)

complex_dotprod_fmla: complex_dotprod_fmla.c
	armclang $(arch) $(opt) -o $@ $<

complex_dotprod_fcmla: complex_dotprod_fcmla.c
	armclang $(arch) $(opt) -o $@ $<

clean: 
	rm -f $(target) *.dis
