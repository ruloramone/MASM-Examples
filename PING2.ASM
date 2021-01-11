

		page 60,132
	title   Programa de despliegue de un menu    pp.192
	.model small
        .stack 640
	.data
cuad    DB 219,'$'      ;Caracter de cuadro
blan    DB 20h,'$'      ;Caracter para borrar el cuadro.
dela    DW 0ff00h       ;Numero para generar un retardo y ver pelota
dela2   dw 0500         ;Numero de repeticiones de retrazo.
dela1   db 30
tres    DW 0ff00h       ;Para reinicializar dela
cuatro  dw 0500         ;para reinicializar dela2

col     db      10      ;Columna inicial de cancha
row     db      02      ;Renglon inicial de cancha
texto   db      'Es','$'
raqui   db      2
raqud   db      2
colri   db      14
rowri   db      3
relo    db      ?
;----------------------------------------------------------------------------        
	.code
begin   proc    Far
        mov     ax,@data  ;inicializacion de registros de datos DS y ES
	mov     DS,AX
	mov     ES,AX
        mov bh,1eh        ;Fondo y color de la pantalla
        mov ax,0600h      ;Borrar pantalla
        mov cx,0000       ;Esquina superior izquierda
        mov dx,184fh      ;Esquina inferior derecha.
        int 10h           ;Borra toda la pantalla
otro:   mov ah,02         ;Posiciona cursor
        mov bh,00
        mov dl,col
        mov dh,row
        int 10h           ;Posiciona
        lea dx, cuad      ;Caracter a escribir en la pantalla
        mov ah,09
        int 21h           ;Escribe caracter
        inc col           ;Siguiente columna
        cmp col, 70       ;Pregunta si ya llego al extremo derecho
        jb otro           ;Si no ha llegado escribe otro caracter
        mov col,10        ;Inicializa de nuevo columna para la raya de abajo
        add row,20        ;Inicializa el renglon para la raya inferior
        cmp row,40        ; Ya son dos los renglones?
        jb otro           ; Si no son dos reng. escribe el segundo
        mov col,10        ;Inicializa columna para hacer rayas verticales
        mov row,2         ;inicializa renglon para raya vertical
otrov:  mov ah,02         ;posiciona cursor
        mov bh,00
        mov dl,col
        mov dh,row
        int 10h           ;Posiciona
        lea dx, cuad      ;Caracter a escribir
        mov ah,09         ;Lo escribe
        int 21h           ;
        inc row           ;Siguiente renglon para escribir columna
        cmp row, 23       ;Pregunta si ya llego abajo

        jb otrov          ;Si no ha llegado escribe otro vertical
        mov row,2         ;Inicializa renglon para la segunda raya vertical
        add col,60        ;Inicializa columna para la segunda raya vertical
        cmp col,80        ;compara aver si ya se hicieron dos rayas vert.
        jb otrov          ;Si no son dos ejecuta otra

        mov col,14
        mov row,3

otro2:  mov ah,02         ;Posiciona cursor
        mov bh,00
        mov dl,col
        mov dh,row
        int 10h           ;Posiciona
        lea dx, cuad      ;Caracter a escribir en la pantalla
        mov ah,09
        int 21h           ;Escribe caracter
        inc row           ;Siguiente columna
        cmp row, 8       ;Pregunta si ya llego al extremo derecho
        jb otro2           ;Si no ha llegado escribe otro caracter


        mov col, 15       ;inicializa posicion de arranque de pelota  Col.
        mov row,5         ;Inicializa posicion de arranaque de pelota Renglon
mas:   mov ah,02         ;posiciona cursor.
        mov bh,00
        mov dl,col
        mov dh,row
        int 10h           ;Posiciona
        lea dx,cuad       ;Adquiere direccion de caracter pelota
        mov ah,09
        int 21h           ;
        mov relo,00
que:    nop
        nop
        nop
        mov ah,2cH
        int 21h
        mov ah,2cH
        int 21h
        mov ah,2cH
        int 21h
        mov ah,2cH
        int 21h
        nop
        mov ah,2ch
;        int 21h
;        mov relo,dl
ten:    mov ah,2ch
;        int 21h
        cmp dl,relo
;        je ten
        nop
        nop
        nop
        inc relo
        cmp relo,20
        jb que
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
;        loop que
sigue1: mov ah,06h
        mov dl,0ffh
        int 21h         ;lee tecla
        int 21h         ;lee codigo de rastreo
      ;  jmp conti            ;solo lee el teclado....
        cmp al,48h      ;compara con codigo flecha abajo
        je arrii         ;si es flecha abajo ve rutina mover raq.I ab.
        cmp al,50h      ;compara con flecha arriba
        je abai        ;si flecha arriba ve a mover raq I Arriba
        cmp ah,4bh      ;Compara flecha Izq.
        je abad         ;Si flecha Izq. mueve raq D hacia abajo
        cmp ah,4dh      ;Comp flecha derecha
        je arrid        ;Si flecha der mueve raq D hacia arriba
        jmp conti
abai:   call abaji
        jmp conti
arrii:  call arribi
        jmp conti
abad:   call abajd
        jmp conti
arrid:  call arribd

conti:  mov cx,cuatro     ;Inicializa de nuevo parametros del retardo
        mov dela2,cx      ;Este retardo es para ver la pelota en una posicion
        mov ah,02         ;Posciona de nuevo el cursor donde se escribio la 
        mov bh,00         ;Pelota
        mov dl,col
        mov dh,row
        int 10h           ;Posiciona
        lea dx,blan       ;Obtiene caracter blanco para borrar pelota
        mov ah,09
        int 21h           ;Borra pelota.
        mov cx,tres       ;Reinicializa retardo ciclo dos.
        mov dela,cx
        inc col           ;Siguiente posicion de columna
        inc col
        inc row           ;Siguiente posicion de renglon.
        cmp col,68        ;Checa si choco con pared de cancha vertical
        jg sale           ;Si choco sale de esta rutina
        cmp row,21        ;Checa si choco con pared Horizontal
        jg sale           ;Si choco sale de esta rutina
        jmp mas           ;Si no ha chocado con pared continua

sale:   nop

	mov     ax,4c00h
	int     21h
begin   endp
arribi  proc near
        mov ah,09h
        lea dx,texto
        int 21h
        nop
        ret
arribi  endp
abaji   proc near
        mov dh,rowri
        mov dl,colri
        mov bh,00
        mov ah,02
        int 10h
        mov ah,09
        lea dx, blan
        int 21h
        mov dh,rowri
        add dh,4
        mov dl,colri
        mov bh,00
        mov ah,02
        int 10h
        mov ah,09
        lea dx,cuad
        int 21h

        inc rowri
        
        ret
abaji   endp
arribd  proc near
        nop
        ret
arribd  endp
abajd   proc near
        nop
        ret
abajd   endp
izqab   proc near

        mov dl,colri
        mov dh,rowri
        
        mov ah,02
        mov bh,00
;        int 10h
        mov ah,09
        lea dx,blan
;        int 21H
        
        mov dh,rowri
        mov dl,colri
;        add dh,04
        mov bh,00
        mov ah,02
        int 10h
        mov ah,09
        lea dx, cuad
        int 21h
        inc rowri
        ret             ;provisional
pal:    inc rowri
        mov ah,02
        int 10h
        mov ah,09
        lea dx,cuad
        mov dl,colri
        mov dh,rowri
        int 21h
        loop pal
        ret
izqab   endp
	end     begin



