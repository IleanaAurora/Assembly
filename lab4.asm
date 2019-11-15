	.model small
	.stack 16
	.data
PR	DB	'ENTER A POSITIVE DECIMAL BETWEEN 10 AND 49: $'
DISP	DB	'RESULT: $'
Num1	LABEL	BYTE
MAX1	DB	3
ACT1	DB	?
N1	DB	4 DUP('$')
Num2	LABEL	BYTE
MAX2	DB	3
ACT2	DB	?
N2	DB	4 DUP('$')
RES	DW	3 DUP('$')

	.code
MAIN	PROC	FAR
	mov	AX, @data
	mov	DS, AX

	call CLEAR
	call SET_CURSOR1
	call REQUEST_INPUT
	call GET_INPUT1
	call STORE_INPUT1
	call SET_CURSOR2
	call REQUEST_INPUT
	call GET_INPUT2
	call STORE_INPUT2
	call ADDNUMS
	call PRINT

	mov AX, 4C00H
	int 21H
MAIN	endp

CLEAR	proc	NEAR
	mov	AX, 0600H
	mov	BH, 71H
	mov	CX, 0000H
	mov	DX, 184FH
	int	10H
	ret
CLEAR	endp

SET_CURSOR1	proc	NEAR
		mov	AH, 02H
		mov	BH, 0
		mov	DH, 5
		mov	DL, 10
		int	10H
		ret
SET_CURSOR1	endp

SET_CURSOR2	proc	NEAR
		mov	AH, 02H
		mov	BH, 0
		mov	DH, 6
		mov	DL, 10
		int	10H
		ret
SET_CURSOR2	endp

REQUEST_INPUT	proc	NEAR
		mov	AH, 09H
		lea	DX, PR
		int	21H
		ret
REQUEST_INPUT		endp

GET_INPUT1	proc	NEAR
		mov	AH, 0AH
		lea	DX, Num1
		int	21H
		ret
GET_INPUT1	endp

GET_INPUT2	proc	NEAR
		mov	AH, 0AH
		lea	DX, Num2
		int	21H
		ret
GET_INPUT2	endp

STORE_INPUT1	proc	NEAR
		mov	AH, 00H
		mov	AL, N1[0]	;get a character at position 0
		sub	AL, 48		;AL <- AL - 48
		mov	BL, 0
		mov	BL, 10
		mul	BL		;AX <- AL * 10 (BL)
		mov	DX, 0
		mov	DX, AX
		mov	CX, 0
		mov	CL, N1[1]
		sub	CL, 48		;CX <- CX - 48
		add	CX, DX		;CX <- CX + DX
		ret
STORE_INPUT1	endp

STORE_INPUT2	proc	NEAR
		mov	AH, 00H
		mov	AL, 0
		mov	AL, N2[0]	;get a character at position 0
		sub	AL, 48		;AL <- AL - 48
		mul	BL		;AX <- AL * 10 (BL)
		mov	DX, CX
		mov	CX, 0
		mov	CL, N2[1]
		sub	CL, 48
		add	AX, CX		;AX <- AX + CX
		ret
STORE_INPUT2	endp

ADDNUMS	proc	NEAR
	add	AX, DX		;AX <- AX + DX
	mov	DX, 0
	div	BX		;AX/BX - quotient in AX, remainder in DX
	add	AX, 48
	mov	RES[0], AX
	add	DX, 48
	mov	RES[1], DX
	ret
ADDNUMS	endp

PRINT	proc	NEAR
	mov	AH, 02H
	mov	DX, 0
	mov	DH, 7
	mov	DL, 10
	int	10H
	mov	BX, 0
  	mov	AH, 09H        ; AH=9 - "print string" sub-function
	mov	DX, 0
	lea	DX, DISP
	int	21H
	lea	DX, RES[BX]
    	int	21H
	ret
PRINT	endp
	
	end	MAIN