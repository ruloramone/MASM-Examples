		page 60,132        
        title   Ordena Nombres ingresados por el teclado    pp.276
	.model small
	.stack 64
	.data
NAMEPAR LABEL BYTE
MAXNLEN DB      21
NAMELEN DB      ?
NAMEFLD DB      21 DUP(' ')

CRLF    DB      13,10,'$'
ENDADDR DW      ?
MESSG1  DB      'Name, ? ', '$'
NAMECTR DB      00
NAMETAB DB      30 DUP(20 DUP(' '))     ;TABLADE NOMBRES
NAMESAV DB      20 DUP(' '),13,10, '$'
SWAPPED DB      00

;----------------------------------------------------------------------------        
	.code
begin   proc    Far
	mov     ax,@data
	mov     DS,AX
	mov     ES,AX
        ;INICIA PROGRAMA
        CLD
        CALL    Q10CLR
        CALL    Q20CURS
        LEA     DI,NAMETAB

A20LOOP:
        CALL    B10READ
        CMP     NAMELEN,00
        JZ      A30
        CMP     NAMECTR,30
        JE      A30
        CALL    D10STOR
        JMP     A20LOOP
A30:    CALL    Q10CLR
        CALL    Q20CURS
        CMP     NAMECTR,01
        JBE     A40
        CALL    G10SORT
        CALL    K10DISP
A40:    MOV     AX,4C00H
        INT     21H

begin   endp

                ;ACEPTA NOMBRES COMO ENTRADA

B10READ PROC    NEAR
        MOV     AH,09
        LEA     DX,MESSG1
        INT     21H

        MOV     AH,0AH
        LEA     DX,NAMEPAR
        INT     21H
        MOV     AH,09
        LEA     DX,CRLF
        INT     21H
        MOV     BH,00
        MOV     BL,NAMELEN
        MOV     CX,21
        SUB     CX,BX
B20:    MOV     NAMEFLD[BX],20H
        INC     BX
        LOOP    B20
B10READ ENDP

                ;ALMACENA NOMBRES EN LA TABLA

D10STOR PROC    NEAR
        INC     NAMECTR
        CLD
        LEA     SI,NAMEFLD
        MOV     CX,10
        REP     MOVSW
        RET
D10STOR ENDP

        ; ORDENA NOMBRES

G10SORT PROC    NEAR
        SUB     DI,40
        MOV     ENDADDR,DI

G20:    MOV     SWAPPED,00
        LEA     SI,NAMETAB
G30:    MOV     CX,20
        MOV     DI,SI
        ADD     DI,20
        MOV     AX,DI
        MOV     BX,SI
        REPE    CMPSB
        JBE     G40
        CALL    H10XCHG

G40:    MOV     SI,AX
        CMP     SI,ENDADDR
        JBE     G30
        CMP     SWAPPED,00
        JNZ     G20
        RET
G10SORT ENDP

        ;INTERCAMBIA ENTRADAS EN TABLA

H10XCHG PROC NEAR
        MOV     CX,10
        LEA     DI,NAMESAV
        MOV     SI, BX
        REP     MOVSW

        MOV     CX,10
        MOV     DI,BX
        REP     MOVSW

        MOV     CX,10
        LEA     SI,NAMESAV
        REP     MOVSW
        MOV     SWAPPED,01
        RET
H10XCHG ENDP

        ;DESPLIEGA NOMBRES ORDENADOS

K10DISP PROC    NEAR
        LEA     SI,NAMETAB

K20:    LEA     DI,NAMESAV
        MOV     CX,10
        REP     MOVSW
        MOV     AH,09
        LEA     DX,NAMESAV
        INT     21H
        DEC     NAMECTR
        JNZ     K20
        RET
K10DISP ENDP

                ;LIMPIA PANTALLA

Q10CLR  PROC    NEAR
        MOV     AX,0600H
        MOV     BH,61H
        MOV     CX,00
        MOV     DX,184FH
        INT     10H
        RET
Q10CLR  ENDP

        ;POSICIONA CURSOR

Q20CURS PROC    NEAR

        MOV     AH,02
        MOV     BH,00
        MOV     DX,00
        INT     10H
        RET
Q20CURS ENDP

	end     begin



