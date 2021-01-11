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



     ;RETARDO DE TIEMPO

SIG:	CALL PS1
        CALL SGN1
        INC SEGS
        INC SEGS+2
        CMP SEGS+2,3AH
	JNE UNO
	INC SEGS+1
	CMP SEGS+1,36H
	JNE UNO
	
UNO:	MOV AH,09	;Esto lleva la variable cont	
        LEA DX,SEGS     ;A la pantalla donde se encuentra el cursor
	INT 21H		;presionar F4
        CMP SEGS,3DH
	JNE SIG

	
        	
PS1:	MOV AH,02       ;POSICIONA CURSOR EN RENGLON 10 COL 40
        MOV BH,00
        MOV DH,10       ;RENGLON
        MOV DL,40       ;COLUMNA
        INT 10H
	RET

SGN1:	MOV DX,100      ;CONTADOR EXTERNODE xx VUELTAS
DNVO:   MOV CX,0FFFFH  ;CONTADOR INTERNO DE 64k VUELTAS
MAS:    DEC CX
        CMP CX,0000
        JNE MAS
        DEC DX
        CMP DX,0000
        JNE DNVO
        RET

	;AQUI TERMINA EL PROGRAMA
	mov     ax,4c00h
	int     21h
begin   endp
	end     begin

