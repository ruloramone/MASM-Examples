			page 60,132
	title   Programa de despliegue de un menu    pp.192
	.model small
	.stack 64
	.data
var     DB 00
segs    DB 00,30H,30H,3AH,30H,30H,3AH,30H,30H,"$"
ASC1    DB '5'
ASC2    DB '08'
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
   
beta:
	mov al,00000001
	mov dx,378h
	out dx,al
	call ChkSal
	jmp beta
final:
begin   endp
;------------------------------------------------------------
ChkSal	Proc	Near
	mov ah,06
	mov dl,0ffh	;PRESIONA Q PARA SALIR
	int 21h
    cmp al,'Q'
	je  final
	ret
ChkSal	Endp
;-----------------------------------------------

	end     begin



