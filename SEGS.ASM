		page 60,132        
	title   Programa de despliegue de un menu    pp.192
	.model small
	.stack 64
	.data
tabla   DB 30h,31h,32h,33h,34h,35h,36h,37h,38h,39h,41h,42h,43h,44h,45h,46h
ASC3    DB 00,30H,30H,3AH,30H,30H,3Ah,30h,30h,20h,'$'
MIN     DB 00
HRS     DB 00
;----------------------------------------------------------------------------        
	.code
begin   proc    Far
	mov     ax,@data
	mov     DS,AX
	mov     ES,AX
        ;AQUI INICIA MI PROGRAMA
OTRO:   MOV AH,02       ;POSICIONA CURSOR EN RENGLON 10 COL 40
        MOV BH,00
        MOV DH,10       ;RENGLON
        MOV DL,40       ;COLUMNA
        INT 10H
                  ;RETARDO DE TIEMPO
        MOV DX,100      ;CONTADOR EXTERNODE xx VUELTAS
DNVO:   MOV CX,0FFFFH  ;CONTADOR INTERNO DE 64k VUELTAS
MAS:    DEC CX
        CMP CX,0000
        JNE MAS
        DEC DX
        CMP DX,0000
        JNE DNVO
                   ;TERMINA RETARDO
         MOV AH,09       ;ENVIA A PANTALLA A LA POSICION 10,40
        LEA DX,ASC3+1
        INT 21H
        MOV AL,ASC3      ;SIGUIENTE NUMERO
        ADD AL,01        ;LO INCREMENTA
        DAA              ;SE AJUSTA DECIMALMENTE
        MOV ASC3,AL      ;SE REGRESAAMEMORIA
                         ;INCREMENTA SIMBOLO
        lea bx, tabla ;ASIGNA DIRECCION A BX DE NUESTRA TABLA
        mov al, asc3  ;MOVER CODIGO DE SIMBOLO A AL
        and al,0fh   ;ELIMINAR PARTE ALTA
        xlat         ;OBTENER EQUIVALENCIA
        mov asc3+8, al ;LLEVAR EQUIVALENTE A MEMORIA
        mov al, asc3  ;MOVER CODIGO DE SIMBOLO A AL
        ror al,1       ;POSICIONAR PARTE ALTA EN BITS MENOSSIGNIFICATIVOS
        ror al,1
        ror al,1
        ror al,1
        and al,0fh   ;ELIMINA PARTE ALTA
        xlat         ;OBTIENE EQUIVALENTE DE "DECENAS" 
        mov asc3+7, al ;LLEVA A MEMORIA EQUIV DECENAS 
        cmp asc3,60H   ;YA LLEGO EL SIMBOLOA 256
        jne otro      ;SINO TRAE OTRO
        MOV ASC3,00   ;INICIALIZA DE NUEVO EN CEROS P OTRO MINUTO
        MOV AL,MIN      ;SIGUIENTE NUMERO
        ADD AL,01        ;LO INCREMENTA
        DAA              ;SE AJUSTA DECIMALMENTE
        CMP AL,60H
        JNE SIGUE2
        MOV AL,00
SIGUE2: MOV MIN,AL      ;SE REGRESAAMEMORIA
                         ;INCREMENTA SIMBOLO
        lea bx, tabla ;ASIGNA DIRECCION A BX DE NUESTRA TABLA
        mov al, MIN  ;MOVER CODIGO DE SIMBOLO A AL
        and al,0fh   ;ELIMINAR PARTE ALTA
        xlat         ;OBTENER EQUIVALENCIA
        mov asc3+5, al ;LLEVAR EQUIVALENTE A MEMORIA
        mov al, MIN  ;MOVER CODIGO DE SIMBOLO A AL
        ror al,1       ;POSICIONAR PARTE ALTA EN BITS MENOSSIGNIFICATIVOS
        ror al,1
        ror al,1
        ror al,1
        and al,0fh   ;ELIMINA PARTE ALTA
        xlat         ;OBTIENE EQUIVALENTE DE "DECENAS" 
        mov asc3+4, al ;LLEVA A MEMORIA EQUIV DECENAS 
        JMP OTRO
        ;AQUI TERMINAMI PROGRAMA
	mov     ax,4c00h
	int     21h
begin   endp
	end     begin



