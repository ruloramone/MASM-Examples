		page 60,132        
	title   Programa de despliegue de un menu    pp.192
	.model small
	.stack 64
        .data
TEMP    DB  00H
TEN     DB  10
ASCII   DB  30H,30H,30H
CASAH   DB  00H
VISITAH DB  00H
FCASAH  DB  00H
FVISITAH DB 00H
LLCASA    DB  'CASA','$'
LLFCASA   DB  'FOULS CASA','$'
LLVISITA  DB  'VISITA','$'
LLFVISITA DB  'FOULS VISITA','$'
LLTIEMPO  DB  'TIEMPO','$'
TABLA   DB  '0','1','2','3','4','5','6','7','8','9'
CASA    DB      '    ',20H,30H,30H,30H,'$'
VISITA  DB      '      ',20H,30H,30H,30H,'$'
CANAST  DB      '   ','$'
FAUL    DB      '   ','$'
FCASA   DB      '    ',20H,30H,30H,'$'
FVISIT  DB      '      ',20H,30H,30H,'$'
MESSG3  DB      '   ','$'
MESSG4  DB      ' ','$'
ASC1    DB 32H,30H,3AH,30H,30H,20H,'$'
igual   db 00h,20h,00h
COL     DB      00
ROW     DB      00

;----------------------------------------------------------------------------
	.code
begin   proc    Far
	mov     ax,@data
	mov     DS,AX
        mov     ES,AX
        call q10clr

        CALL LCASA
        CALL RRCASA
        CALL LVISITA
        CALL RRVISITA
        CALL LFCASA
        CALL RRFCASA
        CALL LFVISIT
        CALL RRFVISITA
        CALL RRRELOJ

AQUI:   MOV AH,2CH
        INT 21h
        MOV IGUAL,DH
        CALL RELOJ
        
A:      MOV AH,06H
        MOV DL,0FFH
        INT 21H
        MOV IGUAL+2,AL
        CMP IGUAL+2,'S'
        JE A1
        JMP T1
OTRO1:  JMP AQUI

T1:     CMP AL,'C'
        JNE SIG
        ADD CASAH,1
        MOV AL,CASAH
        CALL CONV
        MOV AL,ASCII+2
        MOV CASA+7,AL
        MOV AL,ASCII+1
        MOV CASA+6,AL
        MOV AL,ASCII
        MOV CASA+5,AL
        CALL LCASA
SIG :   CMP AL,'V'
        JNE SIG2
        ADD VISITAH,1
        MOV AL,VISITAH
        CALL CONV
        MOV AL,ASCII+2
        MOV VISITA+9,AL
        MOV AL,ASCII+1
        MOV VISITA+8,AL
        MOV AL,ASCII
        MOV VISITA+7,AL
        CALL LVISITA
        JMP AQUI2
A2:     JMP A

AQUI2:

SIG2:   CMP AL,'X'
        JNE SIG3
        ADD FCASAH,1
        MOV AL,FCASAH
        CALL CONV
        MOV AL,ASCII+2
        MOV FCASA+6,AL
        MOV AL,ASCII+1
        MOV FCASA+5,AL
        CALL LFCASA
        JMP SIG3
A1:     JMP B1
SIG3:   CMP AL,'B'
        JNE SIG4
        ADD FVISITAH,1
        MOV AL,FVISITAH
        CALL CONV
        MOV AL,ASCII+2
        MOV FVISIT+8,AL
        MOV AL,ASCII+1
        MOV FVISIT+7,AL
        CALL LFVISIT

SIG4:   JMP AQUI3

B1:     JMP SIGUE
AQUI3:  MOV AH,2Ch
        INT 21h
        CMP IGUAL,DH
        JE A2     
        JMP AQUI4
B2:     JMP OTRO1

AQUI4:  DEC ASC1+4
        CMP ASC1+4,2fH  
        JNE SIGUE1
        DEC ASC1+3
        MOV ASC1+4,39h
        
SIGUE1: CMP ASC1+3,2fH 
        JNE sigue2
        DEC ASC1+1
        MOV ASC1+3,35h

SIGUE2: CMP IGUAL+1,21h
        JE B2
        INC IGUAL+1

        MOV ASC1,31h
        MOV ASC1+1,39h
        MOV ASC1+3,35h
        MOV ASC1+4,39h
        JMP AQUI

A4:  JMP A

SIGUE:  MOV AL,00h
        MOV COL,10
        MOV ROW,22
        CALL Q20CURS
        MOV     AH,09
        LEA     DX,MESSG4
        INT     21H
B3:     MOV AH,06h
        MOV DL,0FFh
        INT 21h
        CMP AL,'A'
        JE A4
        CMP AL,1BH
        JZ FN
        JMP B3

FN:
        MOV AX,4C00H
        INT 21H
BEGIN   ENDP
           
Q10CLR  PROC
        MOV     AX,0600H
        MOV     BH,30H
        MOV     CX,00
        MOV     DX,184FH
        INT     10H
        RET
Q10CLR  ENDP


Q20CURS PROC NEAR
        MOV     AH,02
        SUB     BH,BH
        MOV     DH,ROW
        MOV     DL,COL
        INT     10H
        RET
Q20CURS ENDP

Q21CURS PROC 
        MOV AH,02H
        MOV BH,00
        INT 10
        RET
Q21CURS ENDP

CONV   PROC NEAR
        MOV ASCII,00
        MOV ASCII+1,00
        MOV ASCII+2,00
        MOV TEMP,AL
        MOV AH,00H
        CMP AL,10
        JNAE SALI
        DIV TEN
        OR AH,30H
        MOV ASCII+2,AH
        MOV AH,00H
        CMP AL,10
        JNAE SAL1
        DIV TEN
        OR AH,30H
        OR AL,30H
        MOV ASCII+1,AH
        MOV ASCII,AL
        JMP LISTO

SALI:    OR AL,30H
        MOV ASCII+2,AL
        JMP LISTO

SAL1:    OR AL,30H
        MOV ASCII+1,AL
        

LISTO: 
        RET
CONV    ENDP


LCASA PROC NEAR

        MOV AH,02
        MOV BH,00
        MOV DH,06   ;FILA
        MOV DL,15  ;COL
        INT 10H

        MOV AH,09
        LEA DX,CASA
        INT 21H
        RET
LCASA  ENDP

RRCASA PROC NEAR
        MOV AH,02
        MOV BH,00
        MOV DH,05
        MOV DL,20
        INT 10H

        MOV AH,09
        LEA DX,LLCASA
        INT 21H
        RET
RRCASA ENDP


LVISITA PROC NEAR
        MOV AH,02
        MOV BH,00
        MOV DH,06
        MOV DL,40
        INT 10H

        MOV AH,09
        LEA DX,VISITA
        INT 21H
        RET
LVISITA ENDP

RRVISITA PROC NEAR
        MOV AH,02
        MOV BH,00
        MOV DH,05
        MOV DL,46
        INT 10H

        MOV AH,09
        LEA DX,LLVISITA
        INT 21H
        RET
RRVISITA ENDP


LFCASA  PROC NEAR
        MOV AH,02
        MOV BH,00
        MOV DH,20
        MOV DL,15
        INT 10H

        MOV AH,09
        LEA DX,FCASA
        INT 21H

        RET
LFCASA   ENDP

RRFCASA PROC NEAR
        MOV AH,02
        MOV BH,00
        MOV DH,19
        MOV DL,16
        INT 10H

        MOV AH,09
        LEA DX,LLFCASA
        INT 21H
        RET
RRFCASA ENDP


LFVISIT PROC NEAR

       MOV AH,02
        MOV BH,00
        MOV DH,20
        MOV DL,40
        INT 10H

        MOV AH,09
        LEA DX,FVISIT
        INT 21H
        RET
LFVISIT ENDP

RRFVISITA PROC NEAR
        MOV AH,02
        MOV BH,00
        MOV DH,19
        MOV DL,42
        INT 10H

        MOV AH,09
        LEA DX,LLFVISITA
        INT 21H
        RET
RRFVISITA ENDP


RELOJ  PROC NEAR
        MOV AH,02
        MOV BH,00
        MOV DH,11
        MOV DL,33
        INT 10H

        MOV AH,09
        LEA DX,ASC1
        INT 21H
        RET
RELOJ   ENDP

RRRELOJ PROC NEAR
        MOV AH,02
        MOV BH,00
        MOV DH,10
        MOV DL,33
        INT 10H

        MOV AH,09
        LEA DX,LLTIEMPO
        INT 21H
        RET
RRRELOJ ENDP

        END BEGIN
        



