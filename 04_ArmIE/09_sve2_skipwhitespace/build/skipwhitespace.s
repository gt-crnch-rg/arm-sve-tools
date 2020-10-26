	.text
	.file	"skipwhitespace.c"
	.globl	calc_skipwhitespace_ref // -- Begin function calc_skipwhitespace_ref
	.p2align	5
	.type	calc_skipwhitespace_ref,@function
calc_skipwhitespace_ref:                // @calc_skipwhitespace_ref
	.cfi_startproc
// %bb.0:
	cmp	x0, x1
	b.eq	.LBB0_6
// %bb.1:
	mov	x9, #9728
	mov	w8, #1
	movk	x9, #1, lsl #32
	.p2align	5
.LBB0_2:                                // =>This Inner Loop Header: Depth=1
	ldrb	w10, [x0]
	cmp	w10, #32                // =32
	b.hi	.LBB0_6
// %bb.3:                               //   in Loop: Header=BB0_2 Depth=1
	lsl	x10, x8, x10
	tst	x10, x9
	b.eq	.LBB0_6
// %bb.4:                               //   in Loop: Header=BB0_2 Depth=1
	add	x0, x0, #1              // =1
	cmp	x0, x1
	b.ne	.LBB0_2
// %bb.5:
	mov	x0, x1
.LBB0_6:
	ret
.Lfunc_end0:
	.size	calc_skipwhitespace_ref, .Lfunc_end0-calc_skipwhitespace_ref
	.cfi_endproc
                                        // -- End function

	.ident	"Arm C/C++/Fortran Compiler version 20.3 (build number 543) (based on LLVM 9.0.1)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
