	.data
AB_PATTERN:
	.word 0x09090909
	.data
C_PATTERN:
	.word 0x7F7B7F7F
	.data
HEX_PATTERN:
	.word 0x30307976	/*HEll*/
	.word 0x3E7C003F	/*O bU*/
	.word 0x406D7171	/*FFS-*/
	.word 0x00004040	/*--  */
	.hword 0x0000		/*  */
	.text
	.global	_start
_start:
	
	movia	r15, 0x10000020
	movia	r16, HEX_PATTERN
	xor		r9, r9, r9
	
DISPLAY_BUFFS:
	ldb		r10, 0(r16)
	slli	r17, r17, 8
	or		r17, r17, r10
	stwio	r17, 0(r15)
	addi	r16, r16, 1
	addi	r9, r9, 1
	movia	r7, 300000
	cmpeqi	r11, r9, 19
	bne		r0, r11, DISPLAY_AB
BUFF_DELAY:
	subi	r7,r7,1
	bne		r7,r0, BUFF_DELAY
	br		DISPLAY_BUFFS

RESET_BASE:
	movia	r16, HEX_PATTERN
	movia	r7, 800000
	xor		r9, r9, r9
	xor		r17,r17,r17
	br 		BUFF_DELAY
	
DISPLAY_AB:
	xor		r17, r17, r17
	movia	r16, AB_PATTERN
	ldw		r10, 0(r16)
	movia	r13, 1061109567
	br		AB_DELAY
DO_AB:
	stwio	r10, 0(r15)
	addi	r17,r17,1
	movia	r7, 500000
	nor		r10,r10,r10
	and		r10,r10,r13
	cmpeqi	r11, r17, 6
	bne		r11,r0,DISPLAY_C
AB_DELAY:
	subi	r7,r7,1
	bne		r7,r0, AB_DELAY
	br		DO_AB
	
DISPLAY_C:
	xor		r17, r17, r17
	movia	r16, C_PATTERN
	ldw		r10, 0(r16)
	br		C_DELAY
DO_C:
	stwio	r10, 0(r15)
	movia	r7, 500000
	addi	r17,r17,1
	cmpeqi	r11, r17, 6
	bne		r11,r0,RESET_BASE
	bne		r10,r0,C_OFF
	ldw		r10, 0(r16)
	br		C_DELAY
C_OFF:
	mov 	r10, r0
C_DELAY:
	subi	r7,r7,1
	bne		r7,r0, C_DELAY
	br		DO_C
	.end

	
