			page 60,132
	title   Programa de despliegue de un menu    pp.192
	.model small
	.stack 64
	.data
var     DB 00
Graf2	DB '--------------Presiona "Q" para Salir---------------','$'
Graf1   DB '--------------Presiona "C" para Comenzar------------','$'
Tran1	DB '===================Transportando....================','$'
Detec1	DB '===================Elemento Detectado===============','$'
Color1	DB '=====================Elemento Rojo==================','$'
Color2	DB '=====================Elemento Blanco================','$'
Color3	DB '=====================Elemento Azul==================','$'
Llena1	DB '===================Llenando....=====================','$'
Fllena1	DB '===================Fin del llenado==================','$'
ASC1    DB '5'
ASC2    DB '08'
PP	DB 00
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
	mov     DS,AX
	mov     ES,AX
       ;aqui inicia el programa
		MOV     AX,0600H  ;borrar pantalla
        MOV     BH,31H		;colores
        MOV     CX,00		;resolucion
        MOV     DX,184FH	;resolution
        INT     10H
	    
	   
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
final:
    ;AQUI TERMINAMI PROGRAMA
	mov     ax,4c00h
	int     21h
begin   endp
;--------------------------------------
Retardo	Proc	Near
	MOV AH,2CH	;HORA
	INT 21H		;OBTIENE LA HORA
	MOV PP,DH	;CH-HORAS CL-MINUTOS DH-SEGUNDOS
oTRO:	MOV AH,2CH	;LEER DE 
	INT 21H		;NUEVO
	CMP PP,DH	;COMPARAR SI HA PASADO UN SEGUNDO
	JE OTRO		;SALTA SI TODAVIA NO CAMBIA	
	Ret	
Retardo	Endp
;---------------------------------------------------------------------------------------
Salirq	Proc	Near
	mov ah,06
	mov dl,0ffh	;PRESIONA Q PARA SALIR
	int 21h
    cmp al,'Q'
	je  final
	ret
Salirq	Endp
;----------------------------------------------------------------------------------------
Grafic1 Proc Near
		MOV AH,02	;leyenda
        MOV BH,00	;	
        MOV DH,15	;
        MOV DL,05	;
        INT 10H		;
		mov AH,09	;
        lea DX,Graf1
        int 21H
		ret
Grafic1 Endp
;-------------------------------------------------------------------------------------------
Grafic2 Proc Near
		MOV AH,02	;leyenda
        MOV BH,00	;	
        MOV DH,17	;
        MOV DL,05	;
        INT 10H		;
		mov AH,09	;
        lea DX,Graf2
        int 21H
		ret
Grafic2 Endp
;------------------------------
Transp1 Proc Near
		MOV AH,02	;leyenda
        MOV BH,00	;	
        MOV DH,10
        MOV DL,05	;
        INT 10H		;
		mov AH,09	;
        lea DX,Tran1
        int 21H
		ret
Transp1 Endp
;------------------------------
Detecta1 Proc Near
		MOV AH,02	;leyenda
        MOV BH,00	;	
        MOV DH,10	;
        MOV DL,05	;
        INT 10H		;
		mov AH,09	;
        lea DX,Detec1
        int 21H
		ret
Detecta1 Endp
;------------------------------
Coloruno Proc Near
		MOV AH,02	;leyenda
        MOV BH,00	;	
        MOV DH,10	;
        MOV DL,05	;
        INT 10H		;
		mov AH,09	;
        lea DX,Color1
        int 21H
		ret
Coloruno Endp
;------------------------------
Colordos Proc Near
		MOV AH,02	;leyenda
        MOV BH,00	;	
        MOV DH,10	;
        MOV DL,05	;
        INT 10H		;
		mov AH,09	;
        lea DX,Color2
        int 21H
		ret
Colordos Endp
;------------------------------
Colortres Proc Near
		MOV AH,02	;leyenda
        MOV BH,00	;	
        MOV DH,10	;
        MOV DL,05	;
        INT 10H		;
		mov AH,09	;
        lea DX,Color3
        int 21H
		ret
Colortres Endp
;------------------------------
Llenando Proc Near
		MOV AH,02	;leyenda
        MOV BH,00	;	
        MOV DH,10	;
        MOV DL,05	;
        INT 10H		;
		mov AH,09	;
        lea DX,Llena1
        int 21H
		ret
Llenando Endp
;------------------------------
Finllena Proc Near
		MOV AH,02	;leyenda
        MOV BH,00	;	
        MOV DH,10	;
        MOV DL,05	;
        INT 10H		;
		mov AH,09	;
        lea DX,Fllena1
        int 21H
		ret
Finllena Endp
;------------------------------


;rutina de entrada
;mov ax, 00h
;mov dx, 379h
;in al, dx

	end     begin


