	.text
	.file	"main.c"
	.globl	main                    // -- Begin function main
	.p2align	5
	.type	main,@function
main:                                   // @main
	.cfi_startproc
// %bb.0:
	stp	x22, x21, [sp, #-48]!   // 16-byte Folded Spill
	stp	x20, x19, [sp, #16]     // 16-byte Folded Spill
	stp	x29, x30, [sp, #32]     // 16-byte Folded Spill
	add	x29, sp, #32            // =32
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w21, -40
	.cfi_offset w22, -48
	mov	w0, #256
	mov	w1, #4
	mov	w22, #256
	bl	calloc
	mov	x19, x0
	mov	w0, #256
	mov	w1, #4
	bl	calloc
	adrp	x21, image
	add	x21, x21, :lo12:image
	mov	x20, x0
	mov	w2, #262144
	mov	x0, x19
	mov	x1, x21
	bl	calc_histogram_ref
	mov	w2, #262144
	mov	x0, x20
	mov	x1, x21
	bl	calc_histogram_opt
	mov	x8, xzr
	whilelo	p1.s, xzr, x22
	mov	z0.s, #0                // =0x0
	ptrue	p0.s
	.p2align	5
.LBB0_1:                                // =>This Inner Loop Header: Depth=1
	ld1w	{ z1.s }, p1/z, [x19, x8, lsl #2]
	ld1w	{ z2.s }, p1/z, [x20, x8, lsl #2]
	incw	x8
	cmpne	p1.s, p1/z, z1.s, z2.s
	mov	z1.s, p1/z, #1          // =0x1
	whilelo	p1.s, x8, x22
	add	z0.s, z0.s, z1.s
	b.mi	.LBB0_1
// %bb.2:
	uaddv	d0, p0, z0.s
	mov	x0, x19
	fmov	x21, d0
	bl	free
	mov	x0, x20
	bl	free
	cbz	w21, .LBB0_4
// %bb.3:
	adrp	x0, .Lstr.3
	add	x0, x0, :lo12:.Lstr.3
	bl	puts
	adrp	x0, .L.str.2
	add	x0, x0, :lo12:.L.str.2
	mov	w1, w21
	bl	printf
	b	.LBB0_5
.LBB0_4:
	adrp	x0, .Lstr
	add	x0, x0, :lo12:.Lstr
	bl	puts
.LBB0_5:
	ldp	x29, x30, [sp, #32]     // 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]     // 16-byte Folded Reload
	mov	w0, wzr
	ldp	x22, x21, [sp], #48     // 16-byte Folded Reload
	ret
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc
                                        // -- End function
	.type	.L.str.2,@object        // @.str.2
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.2:
	.asciz	"NUMBER OF ERRORS: %d\n"
	.size	.L.str.2, 22

	.type	.Lstr,@object           // @str
.Lstr:
	.asciz	"TEST PASSED"
	.size	.Lstr, 12

	.type	.Lstr.3,@object         // @str.3
.Lstr.3:
	.asciz	"TEST FAILED"
	.size	.Lstr.3, 12


	.ident	"Arm C/C++/Fortran Compiler version 20.3 (build number 543) (based on LLVM 9.0.1)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym image
