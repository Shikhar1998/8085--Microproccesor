CODE	.EQU 0000H
DUMMY:  .ORG CODE
	LXI SP, 0FFFFH	
	CALL UPDATE
	HLT
UPDATE:	PUSH PSW
	PUSH H
	PUSH D
	PUSH B
	; modifying the update function such that 01->x and 10->o
	; initially the map is FE point
	LXI H,BOARD
	LXI D,BMAP
	MVI B, 09H; TOTAL MAP FOR THE WHOLE BOARD
BAGAIN:	MOV A, M
	XCHG
	CPI 0FEH
	JNZ NOTFE
	MVI A,02H; OTHERWISE MOVE IN THE BOARD 02H
NOTFE:	MOV M, A
	INX H
	INX D
	XCHG
	DCR B
	JNZ BAGAIN
	LXI H, BMAP
	MOV A,M; STATUS 000000XX
	RLC
	RLC 
	INX H
	ORA M
	RLC
	RLC; STATUS 0000XXXX
	INX H
	ORA M
	RLC 
	RLC; STATUS 00XXXXXX
	INX H
	ORA M
	; GENERATED THE FIRST 8-BITS
	OUT 00H; GENERATING THE OUTPUT 	
	INX H
	MOV A,M; STATUS 000000XX
	RLC
	RLC 
	INX H
	ORA M
	RLC
	RLC; STATUS 0000XXXX
	INX H
	ORA M
	RLC 
	RLC; STATUS 00XXXXXX
	INX H
	ORA M
	;GENERATED THE SECOND 8-BITS
	OUT 01H; GENERATING THE OUTPUT
	INX H	
	MOV A,M
	;GENERATED THE THIRD 8-BITS
	OUT 02H
	POP B
	POP D
	POP H
	POP PSW
	RET

BOARD:	.DB 001H,001H,0FEH
	.DB 0FEH,001H,000H
	.DB 000H,0FEH,001H
	
BMAP:   .DB 00H,00H,00H
	.DB 00H,00H,00H
	.DB 00H,00H,00H