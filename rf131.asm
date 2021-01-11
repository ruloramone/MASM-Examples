		page 60,132
	title   Programa de despliegue de un menu    pp.192
	.model small
	.stack 64
	.data

hora 	label	byte
long 	DB	"5"
longact	DB	?
ascii	DB 00,30H,30H,30H,30H,30H,30H,30H,30H,'$'
asciz	DB 00,30H,30H,30H,30H,30H,30H,30H,30H,'$'
ascix	DB 00,30H,30H,30H,30H,30H,30H,30H,30H,'$'
VAR1	DB 100
SEGS	DB 00,30H,30H,':',30H,30H,':',30H,30H,'$'
PP		DB 00
Cuad    DB '++++++++++','$'
Lad1	DB '+','$'
Salir	DB 'Presiona Q para salir..','$'
fijar	DB 'Presiona H para fijar hora : Formato--> HHMM','$'
auno	DB 'Presiona Z para aplicar la alarma 1','$'
alert1	db 'alarma 1 activada','$'
alert2	db 'fin de alarma 1','$'
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
;---------------------------------------------------------------------------
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
		Call aplic
		Call Retardo
		Call Muestra
		Call Cuadro
		Call Fuego
		Call hielo

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
		jmp zeta
rock:	MOV AH, 0AH
		LEA DX,hora
		INT 21H
		call punk
		jmp ini
alarm1:	MOV AH, 0AH
		LEA DX,hora
		INT 21H
		mov bh,ascii+0
		mov asciz+0,bh
		mov bh,ascii+1
		mov asciz+1,bh
		mov bh,ascii+2
		mov asciz+2,bh
		mov bh,ascii+3
		mov asciz+3,bh		
		call Fuego
		MOV AH, 0AH
		LEA DX,hora			;apagado de la alarma
		INT 21H	
		mov bh,ascii+0
		mov ascix+0,bh
		mov bh,ascii+1
		mov ascix+1,bh
		mov bh,ascii+2
		mov ascix+2,bh
		mov bh,ascii+3
		mov ascix+3,bh		
		call hielo
		jmp ini
zeta:
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
aplic	Proc	Near
		mov ah,06
		mov dl,0ffh	
		int 21h
        cmp al,'H'	;presiona H para fijar hora
		je  zero
		cmp al,'Q'	;presiona Q para salir
		je rocket
		cmp al,'Z'	;presiona Z para fijar alarma
		je cloud
		jmp metal
zero:	jmp rock
rocket:	jmp final
cloud:	jmp alarm1
metal:	ret
aplic	Endp
;------------------------------------------------------------
punk	Proc	Near
		mov BH,ascii+0	;mover el contenido de ascii a segs
		mov Segs+1,BH
		mov BH,ascii+1
		mov Segs+2,BH
		mov BH,ascii+2	;mover el contenido de ascii a segs
		mov Segs+4,BH
		mov BH,ascii+3
		mov Segs+5,BH
		ret
punk	endp
;------------------------------------------------------------
Fuego	Proc	Near
		mov BH,asciz+0		;detectando la alarma
		cmp bh, segs+1
		je wii
		jmp hell
wii:	mov bh,asciz+1
		cmp bh,segs+2
		je wii2
		jmp hell
wii2:	mov bh,asciz+2
		cmp bh,segs+4
		je wii3
		jmp hell
wii3:	mov bh,asciz+3
		cmp bh,segs+5
		je wii4
		jmp hell
wii4:	call crash1		
hell:	
	ret
		
Fuego 	Endp
;------------------------------------------------------------
hielo	Proc	Near
		mov bh,ascix+0
		cmp bh,segs+1		
		je xbox1
		jmp devil
xbox1:	mov bh,ascix+1
		cmp bh,segs+2
		je xbox2
		jmp devil
xbox2:	mov bh,ascix+2
		cmp bh,segs+4
		je xbox3
xbox3:	mov bh,ascix+3
		cmp bh,segs+5
		je xbox4
		jmp devil
xbox4:	call crash2
devil:
		ret
hielo	Endp
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
        lea DX,Cuad
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
		MOV AH,02	;leyenda
        MOV BH,00	;	presiona Q para salir
        MOV DH,10	;
        MOV DL,20	;
        INT 10H		;
		mov AH,09	;
        lea DX,Salir
        int 21H
		MOV AH,02	;leyenda
        MOV BH,00	;	Presiona H para fijar hora : Formato--> HHMM
        MOV DH,09	;
        MOV DL,20	;
        INT 10H		;
		mov AH,09	;
        lea DX,Fijar
        int 21H
		MOV AH,02	;leyenda
        MOV BH,00	;	Presiona Z para aplicar alarma 1 : 
        MOV DH,08	;
        MOV DL,20	;
        INT 10H		;
		mov AH,09	;
        lea DX,auno
        int 21H
ret
Cuadro	Endp
;------------------------------------------------------------
	Proc	Near
		MOV AH,02	;leyenda
        MOV BH,00	;	alerta visual 1
        MOV DH,14	;
        MOV DL,20	;
        INT 10H		;
		mov AH,09	;
        lea DX,alert1
		int 21h
		ret
crash1	endp
;------------------------------------------------------------
crash2	Proc	Near
		MOV AH,02	;leyenda
        MOV BH,00	;	alerta visual 1
        MOV DH,15	;
        MOV DL,20	;
        INT 10H		;
		mov AH,09	;
        lea DX,alert2
		int 21h
		ret
crash2	endp
;------------------------------------------------------------
	end     begin

