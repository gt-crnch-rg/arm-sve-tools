	.text
	.file	"main.c"
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3               // -- Begin function main
.LCPI0_0:
	.xword	4572414629547868160     // double 0.004999999888241291
.LCPI0_1:
	.xword	4572414629676717179     // double 0.0050000000000000001
	.text
	.globl	main
	.p2align	5
	.type	main,@function
main:                                   // @main
	.cfi_startproc
// %bb.0:
	stp	d9, d8, [sp, #-96]!     // 16-byte Folded Spill
	stp	x28, x25, [sp, #16]     // 16-byte Folded Spill
	stp	x24, x23, [sp, #32]     // 16-byte Folded Spill
	stp	x22, x21, [sp, #48]     // 16-byte Folded Spill
	stp	x20, x19, [sp, #64]     // 16-byte Folded Spill
	stp	x29, x30, [sp, #80]     // 16-byte Folded Spill
	add	x29, sp, #80            // =80
	sub	sp, sp, #2064           // =2064
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w21, -40
	.cfi_offset w22, -48
	.cfi_offset w23, -56
	.cfi_offset w24, -64
	.cfi_offset w25, -72
	.cfi_offset w28, -80
	.cfi_offset b8, -88
	.cfi_offset b9, -96
	mov	x0, xzr
	bl	time
                                        // kill: def $w0 killed $w0 killed $x0
	bl	srand
	mov	w20, #56963
	mov	w21, #16960
	mov	w22, #16384
	mov	w23, #55050
	mov	x19, xzr
	movk	w20, #17179, lsl #16
	movk	w21, #15, lsl #16
	movk	w22, #50460, lsl #16
	movk	w23, #15395, lsl #16
	add	x24, sp, #1040          // =1040
	add	x25, sp, #16            // =16
	.p2align	5
.LBB0_1:                                // =>This Inner Loop Header: Depth=1
	bl	rand
	smull	x8, w0, w20
	lsr	x9, x8, #63
	asr	x8, x8, #50
	add	w8, w8, w9
	msub	w8, w8, w21, w0
	scvtf	s0, w8
	fmov	s8, w22
	fmov	s9, w23
	fmadd	s0, s0, s9, s8
	fcvt	h0, s0
	str	h0, [x24, x19]
	bl	rand
	smull	x8, w0, w20
	lsr	x9, x8, #63
	asr	x8, x8, #50
	add	w8, w8, w9
	msub	w8, w8, w21, w0
	scvtf	s0, w8
	fmadd	s0, s0, s9, s8
	fcvt	h0, s0
	str	h0, [x25, x19]
	add	x19, x19, #2            // =2
	cmp	x19, #1024              // =1024
	b.ne	.LBB0_1
// %bb.2:
	add	x1, sp, #1040           // =1040
	add	x2, sp, #16             // =16
	add	x3, sp, #12             // =12
	mov	w0, #512
	bl	calc_vecdot_ref
	add	x1, sp, #1040           // =1040
	add	x2, sp, #16             // =16
	add	x3, sp, #8              // =8
	mov	w0, #512
	bl	calc_vecdot_opt
	ldp	s1, s0, [sp, #8]
	mov	x8, #4636737291354636288
	adrp	x0, .L.str
	add	x0, x0, :lo12:.L.str
	fsub	s1, s0, s1
	fdiv	s0, s1, s0
	fabs	s0, s0
	fcvt	d0, s0
	fmov	d1, x8
	adrp	x8, .LCPI0_0
	fmul	d8, d0, d1
	ldr	d0, [x8, :lo12:.LCPI0_0]
	bl	printf
	adrp	x8, .LCPI0_1
	ldr	d0, [x8, :lo12:.LCPI0_1]
	adrp	x8, .Lstr
	adrp	x9, .Lstr.4
	add	x8, x8, :lo12:.Lstr
	add	x9, x9, :lo12:.Lstr.4
	fcmp	d8, d0
	csel	x0, x9, x8, lt
	bl	puts
	adrp	x0, .L.str.3
	add	x0, x0, :lo12:.L.str.3
	mov	v0.16b, v8.16b
	bl	printf
	mov	w0, wzr
	add	sp, sp, #2064           // =2064
	ldp	x29, x30, [sp, #80]     // 16-byte Folded Reload
	ldp	x20, x19, [sp, #64]     // 16-byte Folded Reload
	ldp	x22, x21, [sp, #48]     // 16-byte Folded Reload
	ldp	x24, x23, [sp, #32]     // 16-byte Folded Reload
	ldp	x28, x25, [sp, #16]     // 16-byte Folded Reload
	ldp	d9, d8, [sp], #96       // 16-byte Folded Reload
	ret
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc
                                        // -- End function
	.type	.L.str,@object          // @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"ERROR TOLERANCE = %f%%\n"
	.size	.L.str, 24

	.type	.L.str.3,@object        // @.str.3
.L.str.3:
	.asciz	"ERROR = %f%%\n"
	.size	.L.str.3, 14

	.type	.Lstr,@object           // @str
.Lstr:
	.asciz	"TEST FAILED"
	.size	.Lstr, 12

	.type	.Lstr.4,@object         // @str.4
.Lstr.4:
	.asciz	"TEST PASSED"
	.size	.Lstr.4, 12


	.ident	"Arm C/C++/Fortran Compiler version 20.3 (build number 543) (based on LLVM 9.0.1)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
