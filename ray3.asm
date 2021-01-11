		page 60,132        
	title   Programa de despliegue de un menu    pp.192
	.model small
	.stack 64
	.data
CIRC    DB 0,6,9,11,12,13,14,15,16,17,17,18,18,19,19,19,20,20,20,20
        DB 20,20,20,20,19,19,19,18,18,17,17,16,15,14,13,12,11,9,6,0
ESPE    DW 40
LIMY    DW 00
ihort	DW 100
ivert	DW 100
ohort 	DW 320
overt	DW 320
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
;-----------------espiral by el Rulo -----------------------------------------------------------        
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
;----------------------------horizontal superior-------------------------
ini: 
		mov bx, 00              ;Selecciona pagina cero
        mov cx, ihort              ;Posicion columna 64 
		sub cx, 5
c20:    mov dx, ivert            ;Posicion renglon 70
        mov ah, 0ch             ;Funcion dibujar pixel
        mov al, 01
        int 10h
       	inc cx						;Incrementa columna
        cmp cx,ohort        ;Prueba si llego al limite establecido
        jb c20
;--------------------------------------vertical derecha-----------------------------------
		mov bx, 00
		mov dx, ivert		;Posicion renglon 70
c90:	mov cx, ohort       ;Posicion columna 300
        mov ah, 0ch             ;Funcion dibujar pixel
        mov al, 01
        int 10h
       	inc dx						;Incrementa columna
        cmp dx,overt       ;Prueba si llego al limite establecido
        jb c90
;---------------------------------------------horizontal inferior----------------------------------        
		mov bx, 00
		mov cx, ohort       ;Posicion columna
c30:    mov dx, overt        ;Posicion renglon
        mov ah, 0ch             ;Funcion dibujar pixel
        mov al, 01
        int 10h
        dec cx                  ;decrementa columna
        cmp cx,ihort              ;Prueba si llego al limite establecido
        jne c30
;--------------------------------------vertical izquierda----------------------------------------------
		add ivert,5
		mov bx, 00
		mov dx, overt		;Posicion renglon
c77:	mov cx,	ihort        ;Posicion columna
        mov ah, 0ch             ;Funcion dibujar pixel
        mov al, 01
        int 10h
       	dec dx				;Incrementa columna
        cmp dx,ivert       ;Prueba si llego al limite establecido
        jne c77
;------------------------------- repetir cuadro------------------------------
		
		add ihort,5		
		sub overt,5
		sub ohort,5
		mov bx,ivert
		cmp bx,200
		jne zero
		jmp mega
zero:	jmp ini
mega:

;-------------------------------presiona cualquier tecla para salir
        mov ah, 10h             ;Funcion esperar a que se oprima una
        int 16h                 ;Tecla
        pop ax                  ;Regresar el modo de  video original
        mov ah, 00
        int 10h

		
		
        mov     ax,4c00h        ;REtorna el control al DOS
	int     21h

	begin   endp
	end     begin



