		page 60,132        
	title   Programa de despliegue de un menu    pp.192
	.model small
	.stack 64
	.data
VAR1	DB 100
SEGS	DB 00,30H,30H,':',30H,30H,':',30H,30H,'$'
PP	DB 00
Cuad    DB '++++++++++','$' 
Cuad2   DB '++++++++++','$'
Lad1	DB '+','$'	
Lad2	DB '+','$'
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
	Call ChkSal
	Call Retardo
	Call Muestra
	Call Cuadro
	inc segs+8
        cmp segs+8,3AH	;	incrementa segundos 0-59
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
	jmp tres
uno:	jmp ini	
tres:	inc segs+4
	cmp segs+4,36H
	jne ini
	call borra1
	inc segs+2
	cmp segs+2,34H
	je ajus
	cmp segs+2,3AH
	jne ini
	mov segs+2,30h
	inc segs+1
ajus:	cmp segs+1,32h
	jne uno
	cmp segs+2,34h
	jne uno
	
final:
	;AQUI TERMINA EL PROGRAMA
	mov     ax,4c00h
	int     21h
begin   endp
;------------------------------------------------------------
Borra1 	Proc	Near	
	mov segs+8,30h
	mov segs+7,30h
	mov segs+5,30h
	mov segs+4,30h
Borra1	Endp
;------------------------------------------------------------
Borra	Proc	Near	
        mov AX,0600H	;BORRAR PANTALLA
        mov BH,17h	;color de letra
        mov CX,0000h	;Resolucion	
        mov DX,184fh	;Resolicion
	Ret
Borra	Endp
;------------------------------------------------------------
Retardo Proc Near
SGN1:	MOV DX,10     ;CONTADOR EXTERNODE xx VUELTAS
DNVO:   MOV CX,0AAAAH  ;CONTADOR INTERNO DE 64k VUELTAS
MAS:    DEC CX
        CMP CX,0000
        JNE MAS
        DEC DX
        CMP DX,0000
        JNE DNVO
        RET
Retardo Endp
;------------------------------------------------------------
ChkSal	Proc	Near
	mov ah,06
	mov dl,0ffh	;PRESIONA Q PARA SALIR
	int 21h
        cmp al,'Q'
	je  final
	ret
ChkSal	Endp
;------------------------------------------------------------
Muestra	Proc	Near
	mov AH,09	;
        lea DX,segs	;MUESTRA VARIABLE SEGS
        int 21H		;
	Ret
Muestra	Endp
;------------------------------------------------------------
Cuadro	Proc	Near
      	MOV AH,02	;parte de arriba
        MOV BH,00	;	|
        MOV DH,11	;	renglon
        MOV DL,35	;       columna
        INT 10H		;	|
	mov AH,09	;
        lea DX,Cuad	
        int 21H	
	MOV AH,02	;parte de abajo
        MOV BH,00	;	|
        MOV DH,13	;	renglon
        MOV DL,35	;       columna
        INT 10H		;	|
	mov AH,09	;
        lea DX,Cuad2	
        int 21H	
	MOV AH,02	;Lado izquerdo
        MOV BH,00	;	|
        MOV DH,12	;	renglon
        MOV DL,35	;       columna
        INT 10H		;	|
	mov AH,09	;
        lea DX,Lad1	
        int 21H	
	MOV AH,02	;Lado derecho
        MOV BH,00	;	|
        MOV DH,12	;	renglon
        MOV DL,44	;       columna
        INT 10H		;	|
	mov AH,09	;
        lea DX,Lad1	
        int 21H			
ret
Cuadro	Endp
;------------------------------------------------------------
	end     begin

