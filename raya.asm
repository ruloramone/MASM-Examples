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
;----------------------------esta parte imprime la linea de pixeles superior-------------------------
        mov bx, 00              ;Selecciona pagina cero
        mov cx, 64              ;Posicion columna
c20:    mov dx, 70              ;Posicion renglon
        mov ah, 0ch             ;Funcion dibujar pixel
        mov al, 03
        int 10h
       	inc cx						;Incrementa columna
        cmp cx,300          ;Prueba si llego al limite establecido
        jb c20
;-------------------------esta parte imprime las letras de enmedio--------------------------------
		mov ah, 02		;posiciona cursor en R 12, Col 35
        mov bh,00
        mov dh, 10						
        mov dl, 28
        int 10h
        mov ah,09h  	;para mandar carcteres ASCII
        mov al,40h		;Caracter a mandar "B"
        mov bh, 00
        mov bl, 61h		;Atributo del caracter "Azul"
        mov cx, 07		;Numero de caracteres
        int 10h
;---------------------------------------------Linea de pixeles inferior----------------------------------        
		mov cx, 64              ;Posicion columna
c30:    mov dx, 270              ;Posicion renglon
        mov ah, 0ch             ;Funcion dibujar pixel
        mov al, 03
        int 10h
        inc cx                  ;Incrementa columna
        cmp cx,300              ;Prueba si llego al limite establecido
        jb c30
        ;CIRCULO PUROS PUNTOS
C60:    MOV CX,CENX     ;CENTRO DEL CIRCULO EN CX VAR X
        MOV DX,CENY     ;CENTRO DEL CIRCULO EN DX VAR Y
        MOV AL,VALX     ;VALOR EN X QUE SE INCREMENTARA
        MOV AH,00       ;CEROS A "AH" PARA USAR  AX
      
        ADD CX,AX       ;AGREGA SIGUIENTE VALOR DE X AL "CX"
        LEA BX, CIRC    ;DIRECCION ORIGEN DE LA TABLA
        XLAT            ;OBTIIENE VALOR DE LA TABLA
        MOV AH,00       ;CEROS EN AH
        push ax         ;GUARDAMOS VALOR DE Y EN EL STACK
        SUB DX,AX       ;SIGUIENTE PUNTO EN Y ASCENDIENDO
        MOV AH,0CH      ;FUNCION PIXEL A PANTALLA
        MOV AL,03
        INT 10H
        pop ax          ;REGRESAMOS VALOR DE Y AL REG AX
        add dx,ax       ;LO PONEMOS EN EL CENTRO
        add dx,ax       ;LO PONEMOS EN LA PARTE DE ABAJO DEL CIRCULO
        push ax         ;GUARDAMOS VALOR DE Y
        mov ah,0ch      ;DIBUJA PIXEL PARTE BAJA DEL CIRCULO
        mov al, 03
        int 10h
        pop ax          ;REGRESA VALOR DE Y
        sub dx,ax       ;LO POSICIONA EN EL CENTRO
        INC VALX        ;SIGUIENTE VALOR DE X
        CMP VALX,40     ;YA RECORRIO EL DIAMETRO?
        JB C60          ;SI NO GENERA OTRO PAR DE PUNTOS
                        ;TERMINA CIRCULO DE PUROS PUNTOS
        ;CIRCULO2  MEDIO CIRCULO LLENO
        MOV VALX,00   ;VARIABLE EN EJE X
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



