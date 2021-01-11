		page 60,132        
	title   Programa de despliegue de un menu    pp.192
	.model small
	.stack 64
	.data
CIRC    DB 0,6,9,11,12,13,14,15,16,17,17,18,18,19,19,19,20,20,20,20
        DB 20,20,20,20,19,19,19,18,18,17,17,16,15,14,13,12,11,9,6,0
KCIRC   DB 20,20,20,20,19,19,19,18,18,17,17,16,15,14,13,12,11,9,6,0
		DB 0,6,9,11,12,13,14,15,16,17,17,18,18,19,19,19,20,20,20,20  
ESPE    DW 40
LIMY    DW 00
VALX    DB 00
CENX    DW 150
CENY    DW 100
KENX	DW 170	
KENY	DW 100
COLOR	DB 07
PP		DB 00
Salir	DB 'Presiona Q para salir..','$'
TITULO	DB 'SEMAFORO','$'
ASC1    DB '5'
ASC2    DB '8'
ASC3    DW '37'
ASC4    DW '86'
ASCR1   DB ?
ASCR2   DW ?
limit1	db	00
PUNK	DB	00
BETA	DB	00
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
		
		call letras
		call gris
		mov bl,00
INICIO:	mov PUNK,00

		call V1R2		
		mov bl,00
g02:	call tempo
		inc bl
		cmp bl,05		;05 segundos  Vx=Rx=ON
		jne g02
		mov limit1,00
		mov bh,00		;inicia parpadeo del verde
g0x:	call VP1R2		
		mov bl,00
g03:	call tempo
		inc bl
		cmp bl,01		;01 segundo Vx=ON,Rx=ON
		jne g03
		call V1R2		 
		mov bl,00
g04:	call tempo
		inc bl
		cmp bl,01		;01 segundo Vx=OFF,Rx=ON
		jne g04
		inc limit1
		mov bh,limit1
		cmp bh,03			
		jne g0x
		call A1R2
		mov bl,00
g05:	call tempo
		inc bl
		cmp bl,03	;03 segundos Ax=ON,Rx=ON
		jne g05
;--- semaforo 2 --------------------------------------------------------------
		MOV PUNK,01
		call V2R1		
		mov bl,00
h02:	call tempo
		inc bl
		cmp bl,05		;05 segundos  Vx=Rx=ON
		jne h02
		mov limit1,00
		mov bh,00	
		;inicia parpadeo del verde
h0x:	call VP2R1		
		mov bl,00
h03:	call tempo
		inc bl
		cmp bl,01		;01 segundo Vx=ON,Rx=ON
		jne h03
		call V2R1		 
		mov bl,00
h04:	call tempo
		inc bl
		cmp bl,01		;01 segundo Vx=OFF,Rx=ON
		jne h04
		inc limit1
		mov bh,limit1
		cmp bh,03			
		jne h0x
		;fin del parpadeo del verde
		
		;inicia amarillo
		call A2R1
		mov bl,00
h05:	call tempo
		inc bl
		cmp bl,03	;03 segundos Ax=ON,Rx=ON
		jne h05
		;termina amarillo
		
;--------------------------------------------------------------------------------
		mov ah, 10h             ;Funcion esperar a que se oprima una
        int 16h                 ;Tecla
		pop ax                  ;Regresar el modo de  video original
        mov ah, 00
        int 10h
FINAL:  mov     ax,4c00h        ;REtorna el control al DOS
	int     21h
begin   endp
;--------------------------------------------------------------------
aplic	Proc	Near
		mov ah,06
		mov dl,0ffh	
		int 21h
        cmp al,'Q'	;presiona Q para salir
		je rocket
		jmp met12
rocket:	jmp final
met12:	ret
aplic	Endp
;------------------------------------------------------------------		
		;rutina del circulo
V1R2	proc near
		mov CENX,150
		mov CENY,100
		mov KENX,170	
		mov KENY,100
		mov color,07
		call R0A
		mov color,07
		call A0A		;V1=R2=ON
		mov color,10
		call V0A
		mov color,04
		call R0B
		mov color,07
		call A0B
		mov color,07
		call V0B
		ret
V1R2 	endp
;-----------------------------------------------------------
V2R1	proc near
		mov CENX,150
		mov CENY,100
		mov KENX,170	
		mov KENY,100
		mov color,07
		call R0A
		mov color,07
		call A0A		;V2=R1=ON
		mov color,10
		call V0A
		mov color,04
		call R0B
		mov color,07
		call A0B
		mov color,07
		call V0B
		ret
V2R1 	endp
;-------------------------------------------------------------------------
VP1R2	proc near
		mov CENX,150
		mov CENY,100
		mov KENX,170	
		mov KENY,100
		mov color,07
		call R0A
		mov color,07
		call A0A
		mov color,07		;V1=Par R2=ON
		call V0A
		mov color,04
		call R0B
		mov color,07
		call A0B
		mov color,07
		call V0B
		ret
VP1R2	endp
;-----------------------------------------------------------------------------
VP2R1	proc near
		mov CENX,150
		mov CENY,100
		mov KENX,170	
		mov KENY,100
		mov color,07
		call R0A
		mov color,07
		call A0A
		mov color,07		;V2=Par R1=ON
		call V0A
		mov color,04
		call R0B
		mov color,07
		call A0B
		mov color,07
		call V0B
		ret
VP2R1	endp
;-----------------------------------------------------------------------------
A1R2 	proc	near
		mov CENX,150
		mov CENY,100
		mov KENX,170	
		mov KENY,100
		mov color,07
		call R0A
		mov color,14
		call A0A
		mov color,07		;A1=R2=ON
		call V0A
		mov color,04
		call R0B
		mov color,07
		call A0B
		mov color,07
		call V0B
		ret
A1R2	endp
;---------------------------------------------------------------
A2R1 	proc	near
		mov CENX,150
		mov CENY,100
		mov KENX,170	
		mov KENY,100
		mov color,07
		call R0A
		mov color,14
		call A0A
		mov color,07		;A2=R1=ON
		call V0A
		mov color,04
		call R0B
		mov color,07
		call A0B
		mov color,07
		call V0B
		ret
A2R1	endp
;------------------------------------------------------------------------
gris	proc	near
		mov color,07
		call R01
		call A01
		call V01
		call R02
		call A02
		call V02
		ret
gris    endp
;-----------------------------------------------------------------------------
R0A		PROC NEAR		;FLIP ROJO
		CMP PUNK,01
		JNE SKA
		JMP METAL
SKA:	CALL R01
		JMP FN1
METAL:	CALL R02
FN1:	RET
R0A		ENDP

A0A		PROC NEAR    ;FLIP AMARILLO
		CMP PUNK,01
		JNE SKA2
		JMP METAL2
SKA2:	CALL A01
		JMP FN2
METAL2:	CALL A02
FN2:	RET
A0A		ENDP

V0A		PROC NEAR	;FLIP VERDE
		CMP PUNK,01
		JNE SKA3
		JMP METAL3
SKA3:	CALL V01
		JMP FN3
METAL3:	CALL V02
FN3:	RET
V0A		ENDP

R0B		PROC NEAR
		CMP PUNK,01
		JNE SKA4
		JMP METAL4
SKA4:	CALL R02
		JMP FN4
METAL4:	CALL R01
FN4:	RET
R0B		ENDP

A0B		PROC NEAR
		CMP PUNK,01
		JNE SKA5
		JMP METAL5
SKA5:	CALL A02
		JMP FN5
METAL5:	CALL A01
FN5:	RET
A0B		ENDP

V0B		PROC NEAR
		CMP PUNK,01
		JNE SKA6
		JMP METAL6
SKA6:	CALL V02
		JMP FN6
METAL6:	CALL V01
FN6:	RET
V0B 	ENDP	

R01		proc	near
		mov cenx,150	
		mov kenx,170
		mov ceny,100
		mov keny,100		
		call circu
		
		ret
R01		endp

A01		proc	near
		mov CENX,200
		mov KENX,220
		mov ceny,100
		mov keny,100
		call circu
		ret
A01		endp

V01		proc near
		mov CENX,250
		mov KENX,270
		mov ceny,100
		mov keny,100
		call circu		
		ret
V01		endp

R02		proc near
		mov cenx,300			
		mov kenx,320
		mov	CENY,150
		mov KENY,150	
		call circu		
		ret
R02		endp

A02		proc near
		mov cenx,300			
		mov kenx,320
		mov ceny,200
		mov keny,200
		call circu
		ret
A02		endp

V02		proc near
		mov cenx,300			
		mov kenx,320
		mov ceny,250
		mov keny,250
		call circu
		ret
V02		endp
;------------------------------------------------------------------------------------------------------------------
circu	Proc	Near
		MOV VALX,00   
K62:    MOV CX,KENX   
        ADD CX,50     
        MOV DX,KENY   
        MOV LIMY,DX   
        MOV AL,VALX   
        MOV AH,00
        ADD CX,AX    
        LEA BX, KCIRC 
        XLAT         
        MOV AH,00    
        ADD LIMY,AX 
        SUB DX,AX    
K64:    MOV AH,0CH   
		MOV AL,COLOR  
        INT 10H
        INC DX
        CMP DX,LIMY
        JB K64
        INC VALX    
        CMP VALX,20 
        JB K62      
        MOV VALX,00  	
C62:    MOV CX,CENX   
        ADD CX,50    
        MOV DX,CENY   
        MOV LIMY,DX   
        MOV AL,VALX   
        MOV AH,00
        ADD CX,AX    
        LEA BX, CIRC 
        XLAT         
        MOV AH,00   
        ADD LIMY,AX  
        SUB DX,AX    
C64:    MOV AH,0CH  
        MOV AL,COLOR
        INT 10H
        INC DX
        CMP DX,LIMY
        JB C64
        INC VALX    
        CMP VALX,20 
        JB C62      			
		ret
circu	endp
;------------------------------------------------------------------------------------------------------------------
tempo	proc	near
		CALL APLIC
		MOV AH,2CH	;HORA
		INT 21H		;OBTIENE LA HORA
		MOV PP,DH	;CH-HORAS CL-MINUTOS DH-SEGUNDOS
oTRO:	MOV AH,2CH	;LEER DE 
		INT 21H		;NUEVO
		CMP PP,DH	;COMPARAR SI HA PASADO UN SEGUNDO
		JE OTRO		;SALTA SI TODAVIA NO CAMBIA	
		Ret	
tempo	endp
;----------------------------------------------------------------------------------------------------------------
letras	proc near
        MOV AH,02	;leyenda
        MOV BH,00	;	presiona Q para salir
        MOV DH,20	;
        MOV DL,10	;
        INT 10H		;
		mov AH,09	;
        lea DX,Salir
        int 21H
		MOV AH,02	;leyenda
        MOV BH,00	;	titulo
        MOV DH,02	;
        MOV DL,10	;
        INT 10H		;
		mov AH,09	;
        lea DX,TITULO
        int 21H
		ret
letras endp
	end     begin

