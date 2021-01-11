 call Grafic1
	   call Grafic2
	   inicio:
		mov ax,01h
		mov dx,378h
		out dx,ax
		call salirq
		call Retardo
		mov ax,03h
		mov dx,378h
		out dx,ax
		call salirq
		call Retardo
jmp inicio

;rutina de entrada
;mov ax, 00h
;mov dx, 379h
;in al, dx