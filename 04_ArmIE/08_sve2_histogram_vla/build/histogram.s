	.text
	.file	"histogram.c"
	.globl	calc_histogram_ref      // -- Begin function calc_histogram_ref
	.p2align	5
	.type	calc_histogram_ref,@function
calc_histogram_ref:                     // @calc_histogram_ref
	.cfi_startproc
// %bb.0:
	cbz	w2, .LBB0_3
// %bb.1:
	mov	w8, w2
	.p2align	5
.LBB0_2:                                // =>This Inner Loop Header: Depth=1
	ldrb	w9, [x1], #1
	subs	x8, x8, #1              // =1
	lsl	x9, x9, #2
	ldr	w10, [x0, x9]
	add	w10, w10, #1            // =1
	str	w10, [x0, x9]
	b.ne	.LBB0_2
.LBB0_3:
	ret
.Lfunc_end0:
	.size	calc_histogram_ref, .Lfunc_end0-calc_histogram_ref
	.cfi_endproc
                                        // -- End function

	.ident	"Arm C/C++/Fortran Compiler version 20.3 (build number 543) (based on LLVM 9.0.1)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
