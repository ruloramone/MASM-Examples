			page 60,132
	title   Programa de despliegue de un menu    pp.192
	.model small
	.stack 64
	.data
var     DB 00
segs    DB 00,30H,30H,3AH,30H,30H,3AH,30H,30H,"$"
ASC1    DB '5'
ASC2    DB '08'
PP	DB 00
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
       ;aqui inicia el programa
inicio:
		mov ax,01h
		mov dx,378h
		out dx,ax
		call salirq
		call Retardo
		mov ax,03h
		mov dx,378h
		out dx,ax
		call salirq
		call Retardo
jmp inicio
final:
    ;AQUI TERMINAMI PROGRAMA
	mov     ax,4c00h
	int     21h
begin   endp
;--------------------------------------
Retardo	Proc	Near
	MOV AH,2CH	;HORA
	INT 21H		;OBTIENE LA HORA
	MOV PP,DH	;CH-HORAS CL-MINUTOS DH-SEGUNDOS
oTRO:	MOV AH,2CH	;LEER DE 
;	call salirq
	INT 21H		;NUEVO
	CMP PP,DH	;COMPARAR SI HA PASADO UN SEGUNDO
	JE OTRO		;SALTA SI TODAVIA NO CAMBIA	
	Ret	
Retardo	Endp
;---------------------------------------------------------------------------------------
Salirq	Proc	Near
	mov ah,06
	mov dl,0ffh	;PRESIONA Q PARA SALIR
	int 21h
    cmp al,'Q'
	je  final
	ret
Salirq	Endp

;rutina de entrada
;mov ax, 00h
;mov dx, 379h
;in al, dx

	end     begin


