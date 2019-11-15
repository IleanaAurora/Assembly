	.model small
	.stack 64
	.data
PR	DB	'ENTER: $'
STRPAR	LABEL 	BYTE
MAXLEN 	DB 60
ACTLEN	DB ?
CHARS	DB	61 DUP('$')

	.code
MAIN	proc	FAR
	mov	AX, @data
	mov	DS, AX

	call CLEAR
	call SET_CURSOR
	call REQUEST_INPUT
	call GET_INPUT
	call STORE_INPUT
	call REPLACE
	call CLEAR
	call PRINT

	mov AX, 4C00H
	int 21H
MAIN	endp

CLEAR	proc	NEAR
	mov	AX, 0600H
	mov	BH, 15H
	mov	CX, 0000H
	mov	DX, 184FH
	int	10H
	ret
CLEAR	endp

SET_CURSOR      proc    NEAR
        mov     AH, 02H
        mov     BH, 0
        mov     DH, 12
        mov     DL, 40
        int     10H
        ret
SET_CURSOR      endp

REQUEST_INPUT   proc    NEAR
        mov     AH, 09H
        lea     DX, PR
        int     21H     
        ret
REQUEST_INPUT   endp

GET_INPUT       proc    NEAR
        mov     AH, 0AH
        lea     DX,STRPAR
        int     21H
        ret
GET_INPUT       endp

STORE_INPUT	proc	NEAR
		mov	BX, 0
back:		mov	AH, 00H
		mov	AL, CHARS[BX]	;get a character at BX
		inc	BX		;increment BX
		cmp	BL, ACTLEN	;check if end-of-string
		jne	back		;if not, go back
		ret
STORE_INPUT	endp

REPLACE		proc	NEAR
		mov	BX, 0
		mov	CX, 0
again:		mov	AH, 00H
		mov	AL, CHARS[BX]	;get a character at BX
		cmp	AL, ' '
		je	change
		inc	BX		;increment BX
		cmp	BL, ACTLEN	;check if end-of-string
		jne	again		;if not, go back
		ret
change:		mov	CHARS[BX], '_'
		inc	BX
		jmp	again
REPLACE		endp

PRINT	proc	NEAR
	mov	AH, 02H
	mov	BH, 0
	mov	DH, 5
	mov	DL, 10
	int	10H
	mov	BX, 0
	mov	AH, 09H
	lea	DX, CHARS[BX]
	int	21H
	ret
PRINT	endp

		end	MAIN