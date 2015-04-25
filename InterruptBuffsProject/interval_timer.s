	.extern	INDEX
	.extern	HEX_PATTERN
	.extern	AB_PATTERN
	.extern	C_PATTERN
	
	.global	INTERVAL_TIMER_ISR
INTERVAL_TIMER_ISR:
	subi	sp, sp, 32
	stw		r8, 0(sp)
	stw		r10, 4(sp)
	stw		r11, 8(sp)
	stw		r12, 12(sp)
	stw		r13, 16(sp)
	stw		r14, 20(sp)
	stw		r15, 24(sp)
	stw		ra, 28(sp)
	
	movia	r8, 0x10002000
	sthio	r0, 0(r8)
	
	movia	r15, 0x10000020
	movia	r11, INDEX
	ldw		r12, 0(r11)
	
	cmpgei	r13, r12, 18
	bne		r0, r13, DO_AB
	
	ldwio	r14, 0(r15)
	slli	r14, r14, 8
	
	movia	r10, HEX_PATTERN
	add		r10, r10, r12
	
	ldb		r8, 0(r10)
	or		r14, r14, r8
	stwio	r14, 0(r15)
	
	addi	r12, r12, 1
	stw		r12, 0(r11)
	br		INTERVAL_END
DO_AB:
	cmpgei	r13, r12, 24
	bne		r0, r13, DO_C
	movia	r13, 1061109567
	
	movia	r10, AB_PATTERN
	ldw		r8, 0(r10)
	stwio	r8, 0(r15)
	
	addi	r12, r12, 1
	stw		r12, 0(r11)
	
	nor		r8,r8,r8
	and		r8,r8,r13
	stw		r8, 0(r10)
	br		INTERVAL_END
DO_C:
	ldw		r13, 0(r15)
	beq		r13, r0, C_ON
	stwio	r0, 0(r15)
	br		RESET
C_ON:
	movia	r10, C_PATTERN
	ldw		r8, 0(r10)
	stwio	r8,	0(r15)
RESET:
	addi	r12, r12, 1
	cmpeqi	r13, r12, 31
	bne		r13, r0, RESET_B
	stw		r12, 0(r11)
	br		INTERVAL_END
RESET_B:
	stw		r0, 0(r11)
	stw		r0, 0(r15)
INTERVAL_END:
	ldw		r8, 0(sp)
	ldw		r10, 4(sp)
	ldw		r11, 8(sp)
	ldw		r12, 12(sp)
	ldw		r13, 16(sp)
	ldw		r14, 20(sp)
	ldw		r15, 24(sp)
	ldw		ra, 28(sp)
	addi	sp, sp, 32
	ret
	.end
	
	