	.model small
	.stack 16
	.data
A	DW	29
B	DW	73
RES	DW	?

	.code
MAIN	proc	FAR
	mov AX, @data
	mov DS, AX

	mov AX, A
	mov BX, B
	add AX, BX	; AX <- AX + BX
	mov DX, 10
	mul DX		; AX <- AX * DX
	mov CX, 3
	div CX		; AX <- AX / CX 	Remainder -> DX
	mov RES, DX	; Put remainder of conversion into the RES variable in memory
	mov CX, RES	; Move RES variable to CX register
	mov A, CX	; Move CX register into the A variable in memory

	mov AX, 4C00H
	int 21H		; Give control back to the OS (and indicate success)
MAIN	endp

	end MAIN