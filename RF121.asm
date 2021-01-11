		page 60,132        
	title   Programa de despliegue de un menu    pp.192
	.model small
	.stack 64
	.data
VAR1	DB 100
SEGS	DB 00,30H,30H,'$'
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



	MOV AH,2CH
	INT 21H		;OBTIENE LA HORA
OTRO:	MOV SEGS,DH	;ch-hora,cl-minutos
	MOV AH,2CH	;DH-seg
	INT 21H
	CMP SEGS,DH
	JE OTRO	
	INC BX
	JMP OTRO



		;AQUI TERMINA EL PROGRAMA
	mov     ax,4c00h
	int     21h
begin   endp
	end     begin

