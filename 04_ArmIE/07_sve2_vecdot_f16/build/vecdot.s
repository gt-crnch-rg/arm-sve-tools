	.text
	.file	"vecdot.c"
	.globl	calc_vecdot_ref         // -- Begin function calc_vecdot_ref
	.p2align	5
	.type	calc_vecdot_ref,@function
calc_vecdot_ref:                        // @calc_vecdot_ref
	.cfi_startproc
// %bb.0:
	cmp	x0, #1                  // =1
	b.lt	.LBB0_5
// %bb.1:
	cntw	x8
	mvn	x8, x8
	cmp	x0, x8
	b.ls	.LBB0_6
// %bb.2:
	fmov	s0, wzr
	.p2align	5
.LBB0_3:                                // =>This Inner Loop Header: Depth=1
	ldr	h1, [x1], #2
	ldr	h2, [x2], #2
	subs	x0, x0, #1              // =1
	fcvt	s1, h1
	fcvt	s2, h2
	fmadd	s0, s2, s1, s0
	b.ne	.LBB0_3
// %bb.4:
	str	s0, [x3]
	ret
.LBB0_5:
	fmov	s0, wzr
	str	s0, [x3]
	ret
.LBB0_6:
	mov	x8, xzr
	whilelo	p0.s, xzr, x0
	mov	z0.s, #0                // =0x0
	ptrue	p1.s
	.p2align	5
.LBB0_7:                                // =>This Inner Loop Header: Depth=1
	ld1h	{ z1.s }, p0/z, [x1, x8, lsl #1]
	ld1h	{ z2.s }, p0/z, [x2, x8, lsl #1]
	incw	x8
	fcvt	z1.s, p1/m, z1.h
	fcvt	z2.s, p1/m, z2.h
	fmla	z0.s, p0/m, z2.s, z1.s
	whilelo	p0.s, x8, x0
	b.mi	.LBB0_7
// %bb.8:
	faddv	s0, p1, z0.s
	str	s0, [x3]
	ret
.Lfunc_end0:
	.size	calc_vecdot_ref, .Lfunc_end0-calc_vecdot_ref
	.cfi_endproc
                                        // -- End function

	.ident	"Arm C/C++/Fortran Compiler version 20.3 (build number 543) (based on LLVM 9.0.1)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
