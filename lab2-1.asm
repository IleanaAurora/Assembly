	.model small
	.stack 32
	.data
A	DW 11, 6, 8, 13, 5, 7, 9, 10, 3, 19, 20, 15, 4, 2, 1, 16, 12, 14, 18, 17
MIN	DW	?

	.code
MAIN	proc	FAR
	mov AX, @data
	mov DS, AX

	call FindMin

	mov AX, 4C00H
	int 21
MAIN endp

FINDMIN	proc	NEAR
	LEA SI, A
	MOV CX, 20
OUTER:		MOV MIN, SI
		MOV DX, CX
		DEC DX
		MOV DI, SI
		ADD DI, 2
	INNER:	MOV AX, [SI]
		CMP AX, [DI]
		JNGE PAST_SWAP
		MOV MIN, DI
		MOV BX, [DI]
		MOV [DI], AX
		MOV [SI], BX

PAST_SWAP:	ADD DI, 2
		DEC DX
		CMP DX, 0
		JNE INNER

		ADD SI, 2
	LOOP OUTER
	RET
FINDMIN endp
	
	end MAIN