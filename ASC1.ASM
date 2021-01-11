		page 60,132        
	title   Programa de despliegue de un menu    pp.192
	.model small
	.stack 64
	.data
ASC1    DB 30h,30h,20h,00,20h,'$'
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
        ;AQUI INICIA MI PROGRAMA
OTRO:   MOV AH,09       ;ENVIA A PANTALLA
        LEA DX,ASC1
        INT 21H
        INC ASC1+3      ;INCREMENTA SIMBOLO
        INC ASC1+1      ;INCREMENTA LSB DE HEXADECIMAL
        CMP ASC1+1, 3AH ;YA PASO DE NUEVE  ??
        JNE SIGUE        ;SI NO ES IGUAL SIGUE CON DECENAS
        MOV ASC1+1,41H    ;PRIMERA LETRA
SIGUE:  CMP ASC1+1, 47H  ;YA LLEGO A LA LETRA G??
        JNE  SIGUE2      ;SI NOA LLEGADOA G OTRO NUMERO
        MOV ASC1+1,30H   ;INICIALIZA EN CERO
SIGUE2: CMP ASC1+3,00   ;YA TERMINO???
        JNE OTRO
        ;AQUI TERMINAMI PROGRAMA
	mov     ax,4c00h
	int     21h
begin   endp
	end     begin



