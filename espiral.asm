		page 60,132
	title   Programa de despliegue de un menu    pp.192
	.model small
	.stack 64
	.data
num dw 00
num1 db 00
temp dw 00
comp dw 00
horx dw 620
hory dw 340
varx dw 620
vary dw 340
calx dw 620
caly dw 340
tempx dw 20
tempy dw 10
paso db 'numero de paso:','$'
varname label byte
maxlon db 3
actlon db ?
namevar db 30h, 30h, 30h
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
        mov     ds, ax
        mov     es, ax
        mov ax, 0600h
        mov bh, 17h
        mov cx, 0000h
        mov dx, 1847h
        int 10h

        mov ah, 02
        mov bh, 00
        mov dh, 12
        mov dl, 20
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
    mov num, bx

        mov     ax,@data        ;Obtiene direccion de segmento de datos
        mov     DS,AX           ;Carga dir segm datos en DS y ES
	mov     ES,AX
        mov ah,0fh              ;Funcion obtener modo de video
        int 10h
        push ax                 ;Guardar modo de video en STACK

        mov ah,00               ;Selecciona modo de video 640 x 350
        mov al,10h              ;Grafico
        int 10h

        mov bx, 00
        mov cx, 20              
ret1:   mov dx, 10              
        mov ah, 0ch             
        mov al, 03
        int 10h
        inc cx                  
        cmp cx,620              
        jne ret1
      
        mov dx, 10
ret2:   mov cx, 620              
        mov ah, 0ch             
        mov al, 03
        int 10h
        inc dx                  
        cmp dx,340              
        jne ret2
                    
x:      inc num1
        call decreme
        cmp num1, 170
        jb x

        mov ah, 10h
        int 16h                 
        pop ax                  
        mov ah, 00
        int 10h

        mov     ax,4c00h        ;REtorna el control al DOS
	int     21h
begin   endp

decreme proc near
        mov ax, tempx
        add ax, num
        mov tempx, ax
        cmp hory, 178
        jb ve

        mov cx, horx              
ret3: mov dx, hory              
        call tiempo
        mov ah, 0ch
        mov al, 03
        int 10h
        dec cx                  
        cmp cx, tempx              
        jne ret3

        mov ax, tempy
        add ax, num
        mov tempy, ax
        mov horx, cx
        cmp ax, num
        jb ve

        mov dx, hory
ret4: mov cx, horx              
        call tiempo
        cmp dx, num
        jb ve
        jg sigue
ve:     jmp fin
sigue:  mov ah, 0ch
        mov al, 03
        int 10h
        dec dx                  
        cmp dx,tempy              
        jne ret4

        cmp dx, 172
        jg ve

        mov ax, calx
        mov varx, ax
        mov ax, caly
        mov vary, ax

        mov comp, dx
        mov hory, dx
        mov ax, varx
        sub ax, num
        mov tempx, ax
        mov varx, cx

        mov cx, horx              
ret5:   mov dx, hory              
        call tiempo
        mov ah, 0ch
        mov al, 03
        int 10h
        inc cx                  
        cmp cx, tempx              
        jne ret5

        mov horx, cx
        mov calx, cx
        mov ax, vary
        sub ax, num
        mov tempy, ax
        mov vary, dx
        sub ax, hory
        cmp ax, num
        jb fin

        mov dx, hory
ret6:   mov cx, horx              
        call tiempo
        mov ah, 0ch
        mov al, 03
        int 10h
        inc dx                  
        cmp dx,tempy              
        jne ret6

        cmp dx, 178
        jb fin

        mov hory, dx
        mov caly, dx
        mov ax, varx
        mov tempx, ax
        mov ax, vary
        mov tempy, ax
        ret
fin:    mov num1, 171
        ret
decreme endp
tiempo proc near
        mov ax, 0ffh
ini2:   mov bx, 50
ini:    dec bx
        cmp bx, 00
        jne ini
        dec ax
        cmp ax, 00
        jne ini2
        ret
tiempo endp
        end     begin



