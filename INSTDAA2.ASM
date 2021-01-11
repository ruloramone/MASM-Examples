		page 60,132        
	title   Programa de despliegue de un menu    pp.192
	.model small
	.stack 64
	.data
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
;INICIO





          MOV AL,00
ETIQUETA: ADD AL,01
          DAA
          CMP AL,00H
          JNZ ETIQUETA

;FIN

	mov     ax,4c00h
	int     21h
begin   endp
	end     begin
