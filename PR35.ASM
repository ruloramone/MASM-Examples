		page 60,132        
	title   Programa de despliegue de un menu    pp.192
	.model small
	.stack 64
	.data
CONT	DB 00,20H,30H,30H,30H,20H,30H,30H,20H,20H,'$'
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
	
ETIQ1:	INC CONT
	INC CONT+7
	CMP CONT+7,3AH
	JNE AJUSTE
	MOV CONT+7,41H
	JMP INICIO
AJUSTE:	CMP CONT+7,47H
	JNE INICIO
	MOV CONT+7,30H
	INC CONT+6
	CMP CONT+6,3AH
	JNE AJDOS
	MOV CONT+6,41H
	JMP INICIO
ETIQ:	JMP ETIQ1
AJDOS:	CMP CONT+6,47H
	JNE INICIO
	MOV CONT+6,30H
INICIO:	INC CONT+4
	CMP CONT+4,3AH
	JNE SIG
	MOV CONT+4,30H	;UNIDADES
	INC CONT+3
	CMP CONT+3,3AH
	JNE SIG
	MOV CONT+3,30H	;DECENAS
	INC CONT+2
	CMP CONT+2,3AH
	JNE SIG
	MOV CONT+2,30H	;CENTENAS
SIG:	MOV AH,09	;Esto lleva la variable cont	
	LEA DX,CONT	;A la pantalla donde se encuentra el cursor
	INT 21H		;presionar F4
	CMP CONT,0FFH
	JNE ETIQ


	;AQUI TERMINA EL PROGRAMA
	mov     ax,4c00h
	int     21h
begin   endp
	end     begin

