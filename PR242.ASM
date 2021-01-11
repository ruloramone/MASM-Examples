		page 60,132        
	title   Programa de despliegue de un menu    pp.192
	.model small
	.stack 64
	.data
ASC1    DB '5'
ASC2    DB '8'
ASC3    DW '37'
ASC4    DW '86'
ASCR1   DB ?
ASCR2   DW ?
col     db      00
row     db      00
count   db      ?
lines   db      ?
attrib  db      ?
;----------------------------------------------------------------------------        
	.code
begin   proc    Far
	mov     ax,@data
	mov     DS,AX
	mov     ES,AX
        ;AQUI SE INICIA EL PROGRAMA
	
	MOV AX,00H
	MOV AX,9999H

SGN:	SUB AL,01h
	DAS
	JNC SGN
	MOV CL,AL
	MOV AL,AH
	SUB AL,01
	DAS
	MOV AH,AL
	MOV AL,CL
	SUB AL,01H	
	DAS
	CMP AX,00H
	JNZ SGN
	



	;AQUI TERMINA EL PROGRAMA
	mov     ax,4c00h
	int     21h
begin   endp
	end     begin


