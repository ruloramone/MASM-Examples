		page 60,132        
	title   Programa de despliegue de un menu    pp.192
	.model small
	.stack 64
	.data
ASC1    DB 30h,30h,20h,00,20h,30H,30H,30H,20H,'$'
tabla   DB 30h,31h,32h,33h,34h,35h,36h,37h,38h,39h,41h,42h,43h,44h,45h,46h
ASC3    DB 00,20h,30h,30h,20h,'$'
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
        LEA DX,ASC3
        INT 21H
        INC ASC3     ;INCREMENTA SIMBOLO
        lea bx, tabla ;ASIGNA DIRECCION A BX DE NUESTRA TABLA
        mov al, asc3  ;MOVER CODIGO DE SIMBOLO A AL
        and al,0fh   ;ELIMINAR PARTE ALTA
        xlat         ;OBTENER EQUIVALENCIA
        mov asc3+3, al ;LLEVAR EQUIVALENTE A MEMORIA

        mov al, asc3  ;MOVER CODIGO DE SIMBOLO A AL
        ror al,1       ;POSICIONAR PARTE ALTA EN BITS MENOSSIGNIFICATIVOS
        ror al,1
        ror al,1
        ror al,1
        and al,0fh   ;ELIMINA PARTE ALTA
        xlat         ;OBTIENE EQUIVALENTE DE "DECENAS" 
        mov asc3+2, al ;LLEVA A MEMORIA EQUIV DECENAS 
        cmp asc3,00   ;YA LLEGO EL SIMBOLOA 256
        jne otro      ;SINO TRAE OTRO
        ;AQUI TERMINAMI PROGRAMA
	mov     ax,4c00h
	int     21h
begin   endp
	end     begin



