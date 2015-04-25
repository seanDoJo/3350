	.text
	.global _start
_start:
	movia	sp, 0x007FFFFC
	movia	r16, 0x10002000
	movia	r12, 0x1900000
	movia	r19, 0x10000010
	movi	r18, 0b10000
	stwio	r18, 0(r19)
	sthio	r12, 8(r16) 
	srli	r12, r12, 16
	sthio	r12, 0xC(r16)
	
	movi	r15, 0b0111
	sthio	r15, 4(r16)

	movia	r15, 0x10000050
	movi	r7, 0b0110
	stwio	r7, 8(r15)

	movi	r7, 0b011
	wrctl	ienable, r7
	movi	r7, 1
	wrctl	status, r7
IDLE:
	br	IDLE

	.data
	.global HEX_PATTERN
HEX_PATTERN:
	.align 4
	.word 0x30307976	/*HEll*/
	.word 0x3E7C003F	/*O bU*/
	.word 0x406D7171	/*FFS-*/
	.word 0x00004040	/*--  */
	.word 0x00000000	/*  */
	.global	AB_PATTERN
AB_PATTERN:
	.word 0x09090909
	.global	C_PATTERN
C_PATTERN:
	.word 0x7F7B7F7F
	.global LED_SPEED
LED_SPEED:
	.word 0b10000
	.global INDEX
INDEX:
	.align 4
	.word 0x0
	.global CURRENT_SPEED
CURRENT_SPEED:
	.word 0x1900000
	
	.end