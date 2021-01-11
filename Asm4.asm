#include "ti86asm.inc"

.org _asm_exec_ram
	
Start:
	call _runindicoff
	call _flushallmenus
	call _clrScrn
	ld a,0
	ld (_penRow),a
	ld (_penCol),a
	ld hl,Title
	call _vputs
	ld a,0
	ld (_penCol),a
	ld a,6
	ld (_penRow),a
	ld hl,Author
	call _vputs
	ld a,0
	ld (_penCol),a
	ld a,12
	ld (_penRow),a
	ld hl,Mail
	call _vputs
	ld a,0
	ld (_penCol),a
	ld a,30
	ld (_penRow),a
	ld hl,Order
	call _vputs
	call _getkey

Game:
	ld a,0
	ld ($C9FA),a
	ld ($C9FB),a
	ld ($C9FC),a
	ld ($C9FD),a
	ld ($C9FE),a
	ld ($C9FF),a
	ld ($CA00),a
	ld ($CA01),a
	ld ($CA02),a
	ld ($CA03),a
	ld ($CA04),a
	ld ($CA05),a
	ld ($CA06),a
	ld ($CA07),a
	ld ($CA08),a
	ld ($CA09),a
	ld ($CA0A),a
	ld ($CA0B),a
	ld ($CA0C),a
	call _clrScrn
	ld b,2
	ld a,2
	ld (_curRow),a
	ld a,9
	ld (_curCol),a
	ld hl,Line135
	call _puts
	ld a,3
	ld (_curRow),a
	ld a,8
	ld (_curCol),a
	ld hl,Line24
	call _puts
	ld a,4
	ld (_curRow),a
	ld a,9
	ld (_curCol),a
	ld hl,Line135
	call _puts
	ld a,5
	ld (_curRow),a
	ld a,8
	ld (_curCol),a
	ld hl,Line24
	call _puts
	ld a,6
	ld (_curRow),a
	ld a,9
	ld (_curCol),a
	ld hl,Line135
	call _puts
	jp WaitLoop

Check:
	ld a,0
	ld hl,$CA03
	add a,(hl)
	ld hl,$CA04
	add a,(hl)
	ld hl,$CA05
	add a,(hl)
	cp 30
	jp z,XWin
	cp 6
	jp z,OWin
	ld a,0
	ld hl,$CA06
	add a,(hl)
	ld hl,$CA07
	add a,(hl)
	ld hl,$CA08
	add a,(hl)
	cp 30
	jp z,XWin
	cp 6
	jp z,OWin
	ld a,0
	ld hl,$CA09
	add a,(hl)
	ld hl,$CA0A
	add a,(hl)
	ld hl,$CA0B
	add a,(hl)
	cp 30
	jp z,XWin
	cp 6
	jp z,OWin
	ld a,0
	ld hl,$CA09
	add a,(hl)
	ld hl,$CA06
	add a,(hl)
	ld hl,$CA03
	add a,(hl)
	cp 30
	jp z,XWin
	cp 6
	jp z,OWin
	ld a,0
	ld hl,$CA0A
	add a,(hl)
	ld hl,$CA07
	add a,(hl)
	ld hl,$CA04
	add a,(hl)
	cp 30
	jp z,XWin
	cp 6
	jp z,OWin
	ld a,0
	ld hl,$CA0B
	add a,(hl)
	ld hl,$CA08
	add a,(hl)
	ld hl,$CA05
	add a,(hl)
	cp 30
	jp z,XWin
	cp 6
	jp z,OWin
	ld a,0
	ld hl,$CA03
	add a,(hl)
	ld hl,$CA07
	add a,(hl)
	ld hl,$CA0B
	add a,(hl)
	cp 30
	jp z,XWin
	cp 6
	jp z,OWin
	ld a,0
	ld hl,$CA09
	add a,(hl)
	ld hl,$CA07
	add a,(hl)
	ld hl,$CA05
	add a,(hl)
	cp 30
	jp z,XWin
	cp 6
	jp z,OWin
	
WaitLoop:
	ld hl,$CA0C
	ld a,(hl)
	cp 1
	jp z,Comp1
	cp 3
	jp z,Comp3
	cp 5
	jp z,Comp2
	cp 7
	jp z,Comp2
	cp 9
	jp z,Cats
	call _getkey
	ld e,10
	cp k1
	jp z,ONE
	cp k2
	jp z,TWO
	cp k3
	jp z,THREE
	cp k4
	jp z,FOUR
	cp k5
	jp z,FIVE
	cp k6
	jp z,SIX
	cp k7
	jp z,SEVEN
	cp k8
	jp z,EIGHT
	cp k9
	jp z,NINE
	cp kExit
	jp nz,WaitLoop
	jp Exit

Comp1:
	ld c,2
	ld a,1
	ld hl,$C9FE
	cp (hl)
	jp nz,FIVE
	jp SEVEN

Comp3:
	ld a,0
	ld hl,$CA06
	add a,(hl)
	ld hl,$CA05
	add a,(hl)
	cp 20
	jp z,ONE
	ld a,0
	ld hl,$CA06
	add a,(hl)
	ld hl,$CA0B
	add a,(hl)
	cp 20
	jp z,SEVEN

Comp2:
	ld c,2
	ld a,0
	ld hl,$CA03
	add a,(hl)
	ld hl,$CA04
	add a,(hl)
	ld hl,$CA05
	add a,(hl)
	cp 4
	jp z,RowH1
	ld a,0
	ld hl,$CA06
	add a,(hl)
	ld hl,$CA07
	add a,(hl)
	ld hl,$CA08
	add a,(hl)
	cp 4
	jp z,RowH2
	ld a,0
	ld hl,$CA09
	add a,(hl)
	ld hl,$CA0A
	add a,(hl)
	ld hl,$CA0B
	add a,(hl)
	cp 4
	jp z,RowH3
	ld a,0
	ld hl,$CA09
	add a,(hl)
	ld hl,$CA06
	add a,(hl)
	ld hl,$CA03
	add a,(hl)
	cp 4
	jp z,RowV1
	ld a,0
	ld hl,$CA0A
	add a,(hl)
	ld hl,$CA07
	add a,(hl)
	ld hl,$CA04
	add a,(hl)
	cp 4
	jp z,RowV2
	ld a,0
	ld hl,$CA0B
	add a,(hl)
	ld hl,$CA08
	add a,(hl)
	ld hl,$CA05
	add a,(hl)
	cp 4
	jp z,RowV3
	ld a,0
	ld hl,$CA03
	add a,(hl)
	ld hl,$CA07
	add a,(hl)
	ld hl,$CA0B
	add a,(hl)
	cp 4
	jp z,RowD1
	ld a,0
	ld hl,$CA09
	add a,(hl)
	ld hl,$CA07
	add a,(hl)
	ld hl,$CA05
	add a,(hl)
	cp 4
	jp z,RowD2
	ld a,0
	ld hl,$CA03
	add a,(hl)
	ld hl,$CA04
	add a,(hl)
	ld hl,$CA05
	add a,(hl)
	cp 20
	jp z,RowH1
	ld a,0
	ld hl,$CA06
	add a,(hl)
	ld hl,$CA07
	add a,(hl)
	ld hl,$CA08
	add a,(hl)
	cp 20
	jp z,RowH2
	ld a,0
	ld hl,$CA09
	add a,(hl)
	ld hl,$CA0A
	add a,(hl)
	ld hl,$CA0B
	add a,(hl)
	cp 20
	jp z,RowH3
	ld a,0
	ld hl,$CA09
	add a,(hl)
	ld hl,$CA06
	add a,(hl)
	ld hl,$CA03
	add a,(hl)
	cp 20
	jp z,RowV1
	ld a,0
	ld hl,$CA0A
	add a,(hl)
	ld hl,$CA07
	add a,(hl)
	ld hl,$CA04
	add a,(hl)
	cp 20
	jp z,RowV2
	ld a,0
	ld hl,$CA0B
	add a,(hl)
	ld hl,$CA08
	add a,(hl)
	ld hl,$CA05
	add a,(hl)
	cp 20
	jp z,RowV3
	ld a,0
	ld hl,$CA03
	add a,(hl)
	ld hl,$CA07
	add a,(hl)
	ld hl,$CA0B
	add a,(hl)
	cp 20
	jp z,RowD1
	ld a,0
	ld hl,$CA09
	add a,(hl)
	ld hl,$CA07
	add a,(hl)
	ld hl,$CA05
	add a,(hl)
	cp 20
	jp z,RowD2
	jp RANK

RowH1:
	ld a,1
	ld hl,$C9FA
	cp (hl)
	jp nz,ONE
	ld a,1
	ld hl,$C9FB
	cp (hl)
	jp nz,TWO
	ld a,1
	ld hl,$C9FC
	cp (hl)
	jp nz,THREE

RowH2:
	ld a,1
	ld hl,$C9FD
	cp (hl)
	jp nz,FOUR
	ld a,1
	ld hl,$C9FE
	cp (hl)
	jp nz,FIVE
	ld a,1
	ld hl,$C9FF
	cp (hl)
	jp nz,SIX

RowH3:
	ld a,1
	ld hl,$CA00
	cp (hl)
	jp nz,SEVEN
	ld a,1
	ld hl,$CA01
	cp (hl)
	jp nz,EIGHT
	ld a,1
	ld hl,$CA02
	cp (hl)
	jp nz,NINE

RowV1:
	ld a,1
	ld hl,$CA00
	cp (hl)
	jp nz,SEVEN
	ld a,1
	ld hl,$C9FD
	cp (hl)
	jp nz,FOUR
	ld a,1
	ld hl,$C9FA
	cp (hl)
	jp nz,ONE

RowV2:
	ld a,1
	ld hl,$CA01
	cp (hl)
	jp nz,EIGHT
	ld a,1
	ld hl,$C9FE
	cp (hl)
	jp nz,FIVE
	ld a,1
	ld hl,$C9FB
	cp (hl)
	jp nz,TWO

RowV3:
	ld a,1
	ld hl,$CA02
	cp (hl)
	jp nz,NINE
	ld a,1
	ld hl,$C9FF
	cp (hl)
	jp nz,SIX
	ld a,1
	ld hl,$C9FC
	cp (hl)
	jp nz,THREE

RowD1:
	ld a,1
	ld hl,$C9FA
	cp (hl)
	jp nz,ONE
	ld a,1
	ld hl,$C9FE
	cp (hl)
	jp nz,FIVE
	ld a,1
	ld hl,$CA02
	cp (hl)
	jp nz,NINE

RowD2:
	ld a,1
	ld hl,$CA00
	cp (hl)
	jp nz,SEVEN
	ld a,1
	ld hl,$C9FE
	cp (hl)
	jp nz,FIVE
	ld a,1
	ld hl,$C9FC
	cp (hl)
	jp nz,THREE

RANK:
	ld a,1
	ld hl,$C9FE
	cp (hl)
	jp nz,FIVE
	ld hl,$C9FF
	cp (hl)
	jp nz,SIX
	ld hl,$CA02
	cp (hl)
	jp nz,NINE
	ld hl,$C9FC
	cp (hl)
	jp nz,THREE
	ld hl,$C9FA
	cp (hl)
	jp nz,ONE
	ld hl,$C9FB
	cp (hl)
	jp nz,TWO
	ld hl,$CA01
	cp (hl)
	jp nz,EIGHT
	ld hl,$CA00
	cp (hl)
	jp nz,SEVEN

ONE:
	ld a,1
	ld hl,$C9FA
	cp (hl)
	jp z,WaitLoop
	ld a,6
	ld (_curRow),a
	ld a,8
	ld (_curCol),a
	ld a,1
	ld (hl),a
	ld hl,$CA03
	jp DISP

TWO:
	ld a,1
	ld hl,$C9FB
	cp (hl)
	jp z,WaitLoop
	ld a,6
	ld (_curRow),a
	ld a,10
	ld (_curCol),a
	ld a,1
	ld (hl),a
	ld hl,$CA04
	jp DISP

THREE:
	ld a,1
	ld hl,$C9FC
	cp (hl)
	jp z,WaitLoop
	ld a,6
	ld (_curRow),a
	ld a,12
	ld (_curCol),a
	ld a,1
	ld (hl),a
	ld hl,$CA05
	jp DISP

FOUR:
	ld a,1
	ld hl,$C9FD
	cp (hl)
	jp z,WaitLoop
	ld a,4
	ld (_curRow),a
	ld a,8
	ld (_curCol),a
	ld a,1
	ld (hl),a
	ld hl,$CA06
	jp DISP	

FIVE:
	ld a,1
	ld hl,$C9FE
	cp (hl)
	jp z,WaitLoop
	ld a,4
	ld (_curRow),a
	ld a,10
	ld (_curCol),a
	ld a,1
	ld (hl),a
	ld hl,$CA07
	jp DISP

SIX:
	ld a,1
	ld hl,$C9FF
	cp (hl)
	jp z,WaitLoop
	ld a,4
	ld (_curRow),a
	ld a,12
	ld (_curCol),a
	ld a,1
	ld (hl),a
	ld hl,$CA08
	jp DISP

SEVEN:
	ld a,1
	ld hl,$CA00
	cp (hl)
	jp z,WaitLoop
	ld a,2
	ld (_curRow),a
	ld a,8
	ld (_curCol),a
	ld a,1
	ld (hl),a
	ld hl,$CA09
	jp DISP

EIGHT:
	ld a,1
	ld hl,$CA01
	cp (hl)
	jp z,WaitLoop
	ld a,2
	ld (_curRow),a
	ld a,10
	ld (_curCol),a
	ld a,1
	ld (hl),a
	ld hl,$CA0A
	jp DISP

NINE:
	ld a,1
	ld hl,$CA02
	cp (hl)
	jp z,WaitLoop
	ld a,2
	ld (_curRow),a
	ld a,12
	ld (_curCol),a
	ld a,1
	ld (hl),a
	ld hl,$CA0B
	jp DISP
	

DISP:
	ld a,b
	SUB 2
	jp z,Xs
	jp Os

Xs:
	ld (hl),e
	ld hl,$CA0C
	inc (hl)
	inc b
	ld hl,XDisp
	call _puts
	jp Check

Os:
	ld (hl),c
	ld hl,$CA0C
	inc (hl)
	dec b
	ld hl,ODisp
	call _puts
	jp Check

OWin:
	ld a,0
	ld (_penRow),a
	ld (_penCol),a
	ld hl,OText
	call _vputs
	ld (_penCol),a
	ld a,6
	ld (_penRow),a
	ld hl,Query
	call _vputs

Wait:
	call _getkey
	cp kExit
	jp z,Exit
	cp kClear
	jp z,Game
	jp Wait

XWin:
	ld a,0
	ld (_penRow),a
	ld (_penCol),a
	ld hl,XText
	call _vputs
	ld (_penCol),a
	ld a,6
	ld (_penRow),a
	ld hl,Query
	call _vputs
	jp Wait

Title:
	.db "Tic Tac Toe v1.0",0

Line135:
	.db "| |",0
	
Line24:
	.db "-+-+-",0

Author:
	.db "By Caleb Richardson 1999",0

Mail:
	.db "crichardson@neteze.com",0

Order:
	.db "Press any key to begin",0

XDisp:
	.db "X",0
	
ODisp:
	.db "O",0

XText:
	.db "You win!",0

OText:
	.db "The computer wins",0

Query:
	.db "Press EXIT to quit, CLEAR to play again",0

Catsgame:
	.db "Cat's game!",0

Cats:
	ld a,0
	ld (_penRow),a
	ld (_penCol),a
	ld hl,Catsgame
	call _vputs
	ld (_penCol),a
	ld a,6
	ld (_penRow),a
	ld hl,Query
	call _vputs
	jp Wait

Exit:
	set graphdraw,(IY+graphflags)
	call _clrScrn
	ret

.end
