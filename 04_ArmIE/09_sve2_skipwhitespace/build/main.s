	.text
	.file	"main.c"
	.globl	main                    // -- Begin function main
	.p2align	5
	.type	main,@function
main:                                   // @main
	.cfi_startproc
// %bb.0:
	str	x21, [sp, #-48]!        // 8-byte Folded Spill
	stp	x20, x19, [sp, #16]     // 16-byte Folded Spill
	stp	x29, x30, [sp, #32]     // 16-byte Folded Spill
	add	x29, sp, #32            // =32
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w21, -48
	adrp	x20, .L.str
	add	x20, x20, :lo12:.L.str
	add	x21, x20, #20           // =20
	mov	x0, x20
	mov	x1, x21
	bl	calc_skipwhitespace_ref
	mov	x19, x0
	mov	x0, x20
	mov	x1, x21
	bl	calc_skipwhitespace_opt
	ldrb	w8, [x19]
	ldrb	w9, [x0]
	cmp	w8, w9
	b.ne	.LBB0_2
// %bb.1:
	adrp	x0, .Lstr.6
	add	x0, x0, :lo12:.Lstr.6
	bl	puts
	b	.LBB0_3
.LBB0_2:
	mov	x20, x0
	adrp	x0, .Lstr
	add	x0, x0, :lo12:.Lstr
	bl	puts
	adrp	x0, .L.str.3
	adrp	x1, .L.str
	add	x0, x0, :lo12:.L.str.3
	add	x1, x1, :lo12:.L.str
	bl	printf
	adrp	x0, .L.str.4
	add	x0, x0, :lo12:.L.str.4
	mov	x1, x19
	bl	printf
	adrp	x0, .L.str.5
	add	x0, x0, :lo12:.L.str.5
	mov	x1, x20
	bl	printf
.LBB0_3:
	ldp	x29, x30, [sp, #32]     // 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]     // 16-byte Folded Reload
	mov	w0, wzr
	ldr	x21, [sp], #48          // 8-byte Folded Reload
	ret
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc
                                        // -- End function
	.type	.L.str,@object          // @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"         test string"
	.size	.L.str, 21

	.type	.L.str.3,@object        // @.str.3
.L.str.3:
	.asciz	"INPUT STRING: %s\n"
	.size	.L.str.3, 18

	.type	.L.str.4,@object        // @.str.4
.L.str.4:
	.asciz	"REFERENCE STRING POINTER: %s\n"
	.size	.L.str.4, 30

	.type	.L.str.5,@object        // @.str.5
.L.str.5:
	.asciz	"OPTIMIZED STRING POINTER: %s\n"
	.size	.L.str.5, 30

	.type	.Lstr,@object           // @str
.Lstr:
	.asciz	"TEST FAILED"
	.size	.Lstr, 12

	.type	.Lstr.6,@object         // @str.6
.Lstr.6:
	.asciz	"TEST PASSED"
	.size	.Lstr.6, 12


	.ident	"Arm C/C++/Fortran Compiler version 20.3 (build number 543) (based on LLVM 9.0.1)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
