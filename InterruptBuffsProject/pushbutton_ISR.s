	.extern CURRENT_SPEED
	.extern LED_SPEED
	.global	PUSHBUTTON_ISR
PUSHBUTTON_ISR:
	subi	sp, sp, 36
	stw		ra, 0(sp)
	stw		r10, 4(sp)
	stw		r11, 8(sp)
	stw		r12, 12(sp)
	stw		r13, 16(sp)
	stw		r14, 20(sp)
	stw		r15, 24(sp)
	stw		r9, 28(sp)
	stw		r8, 32(sp)
	
	movia	r8, 0x10002000
	
	movia	r10, 0x10000050
	ldwio	r11, 0xC(r10)
	stwio	r0,  0xC(r10) 
	
	movia	r10, CURRENT_SPEED
CHECK_KEY1:
	andi	r13, r11, 0b0010
	beq		r13, zero, CHECK_KEY2
	ldw		r14, 0(r10)
	movia	r9, 0x2800000
	cmpge	r15, r14, r9
	bne		r15, r0, MIN_REACHED
	
	movi	r9, 0b1000
	sthio	r9, 4(r8)
	movia	r9, 0x500000
	add		r14, r14, r9
	stw		r14, 0(r10)
	sthio	r14, 8(r8)
	srli	r14, r14, 16
	sthio	r14, 12(r8)
	movi	r9, 0b0111
	sthio	r9, 4(r8)
	sthio	r0, 0(r8)
	movia	r9, LED_SPEED
	ldw		r14, 0(r9)
	srli	r14, r14, 1
	stw		r14, 0(r9)
	movia	r9, 0x10000010
	stwio	r14, 0(r9)

MIN_REACHED:
	br		END_PUSHBUTTON_ISR

CHECK_KEY2:
	andi	r13, r11, 0b0100
	beq		r13, zero, END_PUSHBUTTON_ISR
	ldw		r14, 0(r10)
	movia	r9, 0xA00000
	cmple	r15, r14, r9
	bne		r15, r0, MAX_REACHED
	
	movi	r9, 0b1000
	sthio	r9, 4(r8)
	movia	r9, 0x500000
	sub		r14, r14, r9
	stw		r14, 0(r10)
	sthio	r14, 8(r8)
	srli	r14, r14, 16
	sthio	r14, 12(r8)
	movi	r9, 0b0111
	sthio	r9, 4(r8)
	sthio	r0, 0(r8)
	movia	r9, LED_SPEED
	ldw		r14, 0(r9)
	slli	r14, r14, 1
	stw		r14, 0(r9)
	movia	r9, 0x10000010
	stwio	r14, 0(r9)

MAX_REACHED:
	br		END_PUSHBUTTON_ISR

END_PUSHBUTTON_ISR:
	ldw		ra,  0(sp)
	ldw		r10, 4(sp)
	ldw		r11, 8(sp)
	ldw		r12, 12(sp)
	ldw		r13, 16(sp)
	ldw		r14, 20(sp)
	ldw		r15, 24(sp)
	ldw		r9, 28(sp)
	ldw		r8, 32(sp)
	addi	sp,  sp, 20

	ret
	.end