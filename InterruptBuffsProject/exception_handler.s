	.section .reset, "ax"
	movia	r2, _start
	jmp		r2


	.section .exceptions, "ax"
	.global EXCEPTION_HANDLER
EXCEPTION_HANDLER:
	subi	sp, sp, 16
	stw		et, 0(sp)
	rdctl	et, ctl4
	beq		et, r0, SKIP_EA_DEC
	
	subi	ea, ea, 4
	
SKIP_EA_DEC:
	stw		ea, 4(sp)
	stw		ra, 8(sp)
	stw		r22, 12(sp)
	rdctl	et, ctl4
	bne		et, r0, CHECK_TIMER
	br		END_ISR

CHECK_TIMER:
	andi	r22, et, 0b1
	beq		r22, r0, CHECK_BUTTONS
	call	INTERVAL_TIMER_ISR
	br		END_ISR

CHECK_BUTTONS:
	andi	r22, et, 0b10
	beq		r22, r0, END_ISR
	call	PUSHBUTTON_ISR
	br		END_ISR
	
END_ISR:
	ldw		et, 0(sp)
	ldw		ea, 4(sp)
	ldw		ra, 8(sp)
	ldw		r22, 12(sp)
	addi	sp, sp, 16
	eret
	.end
	