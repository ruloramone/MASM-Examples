		page 60,132        
	title   Programa de despliegue de un menu    pp.192
	.model small
	.stack 64
	.data
VAR1	DB 100
SEGS	DB 00,30H,30H,':',30H,30H,':',30H,30H,'$'
PP	DB 00
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
        MOV DH,12	;	|
        MOV DL,35	;    COLORES
        INT 10H		;	|

	Call Checar
	Call Muestra

	inc segs+8
	inc segs+8
			;INCREMENTA SEGUNDOS 0 A 59
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

		



	;AQUI TERMINA EL PROGRAMA

	mov     ax,4c00h
	int     21h
begin   endp

;------------------------------------------------------------
Borra	Proc	Near	
        mov AX,0600H	;BORRAR PANTALLA
        mov BH,17h	;	|
        mov CX,0000h	;	|
        mov DX,184fh
	Ret
Borra	Endp

;------------------------------------------------------------
Checar	Proc	Near
	MOV AH,2CH	;HORA
	INT 21H		;OBTIENE LA HORA
	MOV PP,DH	;CH-HORAS CL-MINUTOS DH-SEGUNDOS
oTRO:	MOV AH,2CH	;LEER DE 
	INT 21H		;NUEVO
	CMP PP,DH	;COMPARAR SI HA PASADO UN SEGUNDO
	JE OTRO		;SALTA SI TODAVIA NO CAMBIA	
	Ret	
Checar	Endp
;------------------------------------------------------------
Muestra	Proc	Near
	mov AH,09	;
        lea DX,segs	;MUESTRA VARIABLE SEGS
        int 21H		;
	Ret
Muestra	Endp
;------------------------------------------------------------

	end     begin

