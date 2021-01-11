		page 60,132        
	title   Programa de despliegue de un menu    pp.192
	.model small
	.stack 64
	.data
VAR1	DB 100
SEGS	DB 30H,30H,'$'
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

	INC SEGS+2
	CMP SEGS+2,3AH
	JNE ETIQ3
	
	MOV AH,09	;Esto lleva la variable cont	
	LEA DX,SEGS	;A la pantalla donde se encuentra el cursor
	INT 21H		;presionar F4
	









	
ETIQ2:	MOV CX,0FFFFH
	
ETIQ: 	NOP
	NOP
	NOP
	DEC CX
	CMP CX,0000H
	JNE ETIQ
	DEC VAR1



	
	

	;AQUI TERMINA EL PROGRAMA
	mov     ax,4c00h
	int     21h
begin   endp
	end     begin

