		page 60,132        
	title   Programa de despliegue de un menu    pp.192
	.model small
	.stack 64
	.data
VAR1	DB 100
SEGS	DB 00,30H,30H,':',30H,30H,':',30H,30H,'$'
PP	DB 00
final	db 00	
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
	
	Call Borra

        int 10H		;	|
ini:    MOV AH,02	;POSICIONAR CURSOR
        MOV BH,00	;	|
        MOV DH,12	;renglon
        MOV DL,35	;columna
        INT 10H		;	|
	Call Retardo
	Call Muestra
        inc Bx
        cmp Bx,15180h
	je  iniz 	
	inc segs+8		;INCREMENTA SEGUNDOS 0 A 59
        cmp segs+8,3AH	;	|
        jne ini		;	|
        mov segs+8,30H	;	|
	inc segs+7	;	|
        cmp segs+7,36H	;	|
        jne ini
	mov segs+8,30h
	mov segs+7,30h
	inc segs+5
	cmp segs+5,3AH
	jne ini
	mov segs+5,30H
	inc segs+4
	cmp segs+4,36H
	jne ini
	Call Borra1
	jmp esp1
iniz:	jmp ini3	
esp1:	nop
	inc segs+2
	cmp segs+2,3Ah
	jne ini
	mov segs+2,30h
	inc segs+1
	cmp segs+1,33h
	jne ini2
	cmp segs+2,35h
	jne ini2
	mov segs+8,30h
	mov segs+7,30h
	mov segs+5,30h
	mov segs+4,30h
	mov segs+2,30h
	mov segs+1,30h
	jmp ini3	
ini2:	jmp ini
ini3:	nop
	

	;AQUI TERMINA EL PROGRAMA

	mov     ax,4c00h
	int     21h
begin   endp

;------------------------------------------------------------
Borra1	Proc	Near
	mov segs+8,30h
	mov segs+7,30h
	mov segs+5,30h
	mov segs+4,30h
Borra1  Endp

;------------------------------------------------------------
Borra	Proc	Near	
        mov AX,0600H	;BORRAR PANTALLA
        mov BH,17h	;	|
        mov CX,0000h	;	|
        mov DX,184fh
	Ret
Borra	Endp

;------------------------------------------------------------
Retardo Proc Near
SGN1:	MOV DX,10      ;CONTADOR EXTERNODE xx VUELTAS
DNVO:   MOV CX,0FFFH  ;CONTADOR INTERNO DE 64k VUELTAS
MAS:    DEC CX
        CMP CX,0000
        JNE MAS
        DEC DX
        CMP DX,0000
        JNE DNVO
        RET
Retardo Endp

;------------------------------------------------------------
Muestra	Proc	Near
	mov AH,09	;
        lea DX,segs	;MUESTRA VARIABLE SEGS
        int 21H		;
	Ret
Muestra	Endp
;------------------------------------------------------------

	end     begin

