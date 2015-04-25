	.data
RIGHT_TO_LEFT:
	.word 0x49494979
	.word 0x00000000
	.data
LEFT_TO_RIGHT:
	.word 0x4949494F
	.word 0x00000000
	
	.text
	.global _start
	
_start:
	movia	r11, RIGHT_TO_LEFT
	movia	r8, 0x10000020
	movia	r9, 0x10000050
	xor		r14, r14, r14

MOVE_LEFT:
	ldbio	r10, 0(r11)
	slli	r13, r13, 8
	or		r13, r13, r10
	stwio	r13, 0(r8)
	addi	r11, r11, 1
	ldwio	r15, 0(r9)
	bne		r15, r0, LEFT_PUSHED
	movia	r7, 300000
	addi	r14, r14, 1
	cmpeqi	r16, r14, 8
	bne		r16, r0, LEFT_RESET
LEFT_DELAY:
	subi	r7,r7,1
	bne		r7,r0, LEFT_DELAY
	br		MOVE_LEFT
LEFT_RESET:
	xor		r14, r14, r14
	movia	r11, RIGHT_TO_LEFT
	br		LEFT_DELAY

LEFT_PUSHED:
	xor		r14, r14, r14
	xor		r13, r13, r13
	movia	r11, LEFT_TO_RIGHT
WAIT_LEFT:
	ldwio	r15, 0(r9)
	bne		r15, r0, WAIT_LEFT
	br		MOVE_RIGHT
	
RIGHT_PUSHED:
	xor		r14, r14, r14
	xor		r13, r13, r13
	movia	r11, RIGHT_TO_LEFT
WAIT_RIGHT:
	ldwio	r15, 0(r9)
	bne		r15, r0, WAIT_RIGHT
	br		MOVE_LEFT
	
MOVE_RIGHT:
	ldbio	r10, 0(r11)
	slli	r10, r10, 24
	srli	r13, r13, 8
	or		r13, r13, r10
	stwio	r13, 0(r8)
	addi	r11, r11, 1
	ldwio	r15, 0(r9)
	bne		r15, r0, RIGHT_PUSHED
	movia	r7, 300000
	addi	r14, r14, 1
	cmpeqi	r16, r14, 8
	bne		r16, r0, RIGHT_RESET
RIGHT_DELAY:
	subi	r7,r7,1
	bne		r7,r0, RIGHT_DELAY
	br		MOVE_RIGHT
RIGHT_RESET:
	xor		r14, r14, r14
	movia	r11, LEFT_TO_RIGHT
	br		RIGHT_DELAY
	