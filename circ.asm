		page 60,132        
	title   Programa de despliegue de un menu    pp.192
	.model small
	.stack 64
	.data
CIRC    DB 0,6,9,11,12,13,14,15,16,17,17,18,18,19,19,19,20,20,20,20
        DB 20,20,20,20,19,19,19,18,18,17,17,16,15,14,13,12,11,9,6,0
ESPE    DW 40
LIMY    DW 00
VALX    DB 00
CENX    DW 150
CENY    DW 100
KENX	DW 100	
KENY	DW 100
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
        mov     ax,@data        ;Obtiene direccion de segmento de datos
        mov     DS,AX           ;Carga dir segm datos en DS y ES
		mov     ES,AX
        mov ah, 3              ;Funcion obtener modo de video
        int 10h
        push ax                 ;Guardar modo de video en STACK

        mov ah,00               ;Selecciona modo de video 640 x 350
        mov al,10h              ;Grafico
        int 10h

      
        
        ;Circulo K
		MOV VALX,00   ;VARIABLE EN EJE X
K62:    MOV CX,KENX   ;CENTRO DEL CIRCULO
        ADD CX,50     ;DESPLAZAMIENTO EN X
        MOV DX,KENY   ;CENTRO EN EL EJE Y
        MOV LIMY,DX   ;PONER EN EL CENTRO LA VARIABLE LIMITE EN Y
        MOV AL,VALX   ;SIGUIENTE VALOR DEL EJE X EN REG AX
        MOV AH,00
      
        ADD CX,AX    ;AGREGAR SIG VALOR X EN CENTRO X
        LEA BX, CIRC ;APUNTAR A TABLA DE CONVERSION CIRCULO
        XLAT         ;OBTENER EL VALOR DE LA TABLA EN "AL"
        MOV AH,00    ;PONER CEROS EN AH
        ADD LIMY,AX  ;CALCULA EL LIMITE EN EL EJE Y
       ; push ax
        SUB DX,AX    ;SIGUIENTE VALOR INICIAL DE L EJE Y
K64:    MOV AH,0CH   ;DIBUJA PIXEL HASTA LLEGAR AL LIMITE Y
        MOV AL,03
        INT 10H
        INC DX
        CMP DX,LIMY
        JB K64
        INC VALX    ;SIGUIENTE VALOR EN EJE X
        CMP VALX,20 ;COMPARA CON EL VALOR DEL RADIO DEL CIRCULO
        JB K62      ;SI NO HA LLEGADO TRAZA OTRA LINEA VERTICAL

        ;CIRCULO2  MEDIO CIRCULO LLENO
        MOV VALX,10   ;VARIABLE EN EJE X
C62:    MOV CX,CENX   ;CENTRO DEL CIRCULO
        ADD CX,50     ;DESPLAZAMIENTO EN X
        MOV DX,CENY   ;CENTRO EN EL EJE Y
        MOV LIMY,DX   ;PONER EN EL CENTRO LA VARIABLE LIMITE EN Y
        MOV AL,VALX   ;SIGUIENTE VALOR DEL EJE X EN REG AX
        MOV AH,00
      
        ADD CX,AX    ;AGREGAR SIG VALOR X EN CENTRO X
        LEA BX, CIRC ;APUNTAR A TABLA DE CONVERSION CIRCULO
        XLAT         ;OBTENER EL VALOR DE LA TABLA EN "AL"
        MOV AH,00    ;PONER CEROS EN AH
        
        
        ADD LIMY,AX  ;CALCULA EL LIMITE EN EL EJE Y
       ; push ax
        SUB DX,AX    ;SIGUIENTE VALOR INICIAL DE L EJE Y
C64:    MOV AH,0CH   ;DIBUJA PIXEL HASTA LLEGAR AL LIMITE Y
        MOV AL,03
        INT 10H
        INC DX
        CMP DX,LIMY
        JB C64
        INC VALX    ;SIGUIENTE VALOR EN EJE X
        CMP VALX,20 ;COMPARA CON EL VALOR DEL RADIO DEL CIRCULO
        JB C62      ;SI NO HA LLEGADO TRAZA OTRA LINEA VERTICAL

        mov ah, 10h             ;Funcion esperar a que se oprima una
        int 16h                 ;Tecla
        pop ax                  ;Regresar el modo de  video original
        mov ah, 00
        int 10h

        mov     ax,4c00h        ;REtorna el control al DOS
	int     21h
begin   endp
	end     begin



