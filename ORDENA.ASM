                page 60,132        
	title   Programa de despliegue de un menu    pp.192
	.model small
	.stack 64
	.data
ASC1    DB '5','8','3','9','1','4','7','2','0',0DH,0AH,'$'
orden   DB 'ORDENADOS',0DH,0AH,'$'
DESORD  DB 'DESORDENADOS',0DH,0AH,'$'
CONT    DW ?
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
        ;inicia programa
        lea     si,asc1 ;direccion de datos
        lea     di,asc1+1       ;direccion de datos mas uno
        lea     dx, DESORD        ;p' mandar a pantalla LEYENDA DESORDENADO
        MOV AH,09
        INT 21H
        LEA DX,ASC1             ;MANDAR NUMS DESORDENADOS
        MOV AH,09
        INT 21H
        MOV CX,08       ;VALOR INICIAL DE ITERACIONES
        MOV CONT,CX     ;VALOR DEL ULTIMO CONTADOR
VUELTA: MOV AL,[SI]
        MOV BL,[DI]
        CMP AL,BL
        JB  SIGUE
        MOV [SI],BL     ;INTERCAMBIA
        MOV [DI],AL
        
SIGUE:  INC DI
LOOP    VUELTA
        LEA DX,ASC1             ;MANDAR NUMS ORDENADOS
        MOV AH,09
        INT 21H
        INC SI                  ;SIGUIENTE A ORDENAR
        MOV DI,SI
        INC DI
        DEC CONT
        MOV CX,CONT
        CMP CX,00
        JNE VUELTA
	mov     ax,4c00h
	int     21h
begin   endp
	end     begin



