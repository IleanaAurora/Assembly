	.model small
	.stack 32
	.data
A	DW 10 DUP (?)
RES	DW	?

	.code
MAIN 	proc	FAR
	mov AX, @data
	mov DS, AX

	call INIT
	call AVG

	mov AX, 4C00H
	int 21H
MAIN	endp

INIT	proc	NEAR
	LEA SI, A	;get the starting address of the array A and stick it into SI (source index)
	MOV CX, 10	;initialize the number of iterations of the loop (outer loop performs 10 iterations)
	MOV AX, 1
	MOV BX, 1
	AGAIN:	MUL AX
		MOV [SI], AX
		ADD SI, 2
		ADD BX, 2
		MOV AX, BX
		LOOP AGAIN
		
		ret
INIT	endp

AVG	proc	NEAR
	LEA DI, A	;get the starting address of the array A and stick it into SI (source index)
	MOV CX, 10	;initialize the number of iterations of the loop (outer loop performs 10 iterations)
	MOV AX, 0
	BACK:	ADD AX, [DI]
		ADD DI, 2
		LOOP BACK
	MOV BX, 10
	DIV BX
	MOV RES, AX

		ret
AVG	endp

	end MAIN