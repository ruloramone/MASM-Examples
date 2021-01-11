		page 60,132        
	title   Programa de despliegue de un menu    pp.192
	.model small
	.stack 64
	.data


ESPE    DW 40
LIMY    DW 00
ihort	DW 100
ivert	DW 100
ohort 	DW 320
overt	DW 320
beta	dw 10
VALX    DB 00
CENX    DW 150
CENY    DW 100
paso db 'Ingresa el paso (teclea un numero entre 01 y 19):','$'
varname label byte
maxlon db 3
actlon db ?
namevar db 30h, 30h, 30h
num		dw 00
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
	

	mov     ax,@data
        mov     ds, ax
        mov     es, ax
        mov ax, 0600h
        mov bh, 17h
        mov cx, 0000h
        mov dx, 1847h
        int 10h

        mov ah, 02
        mov bh, 00
        mov dh, 05
        mov dl, 05
        int 10h
        mov ah, 09
        lea dx, paso
        int 21h
        mov ah, 0ah
        lea dx, varname
        int 21h
    mov al, 10
    mov cl, namevar
    sub cl, 30h
    mul cl
    mov bx, ax
    mov ax, 00h
    mov cl, namevar+1
    sub cl, 30h
    mov al, cl
    add bx, ax
    mov beta, bx

        mov     ax,@data        ;Obtiene direccion de segmento de datos
        mov     DS,AX           ;Carga dir segm datos en DS y ES
	mov     ES,AX
        mov ah,0fh              ;Funcion obtener modo de video
        int 10h
        push ax                 ;Guardar modo de video en STACK

        mov ah,00               ;Selecciona modo de video 640 x 350
        mov al,10h              ;Grafico
        int 10h
        
	
							
;----------------------------horizontal superior-------------------------
ini: 			
		
		mov bx, 00              ;Selecciona pagina cero
        mov cx, ihort              ;Posicion columna 64 
		mov ax,beta
		sub cx, ax
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
		
		mov ax,beta
		add ivert,ax
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
		
		mov ax,beta
		add ihort,ax	
		sub overt,ax
		sub ohort,ax
		mov bx,ivert
		cmp bx,200
		jle zero
		
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



