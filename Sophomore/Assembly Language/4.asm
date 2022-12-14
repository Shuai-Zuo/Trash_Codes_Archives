DATA SEGMENT
	COUNT DB 00H
	COUNT2 DB 30H
	LINE DB 0FH
	MSGIN1 DB 09H,09H,'The ASCII Table',0AH,'$' 
	MSGHEAD DB '   0  1  2  3  4  5  6  7  8  9  A  B  C  D  E  F',0AH,'$'
DATA ENDS
STACKS SEGMENT STACK
  DB 100h DUP(0)
STACKS ENDS
CODE SEGMENT
   ASSUME DS:DATA,SS:STACKS,CS:CODE
START:	
	MOV AX,DATA
	MOV DS,AX
	LEA DX,MSGIN1
    MOV AH,09H
    INT 21H
    LEA DX,MSGHEAD;输出列表头
    MOV AH,09H
    INT 21H
    MOV DL,COUNT2;输出第一个行表头
    MOV AH,02H
    INT 21H
    MOV DL,' '
    MOV AH,02H
    INT 21H
    MOV DL,' '
    MOV AH,02H
    INT 21H
    INC COUNT2
LOP:
	CMP COUNT,7FH;ascii码上限
	JA ENDPROG1
	CMP COUNT,09H;ascii码为09h 0ah 0dh 1bh需要做特殊处理
	JE PRINTSPACE
	CMP COUNT,0AH
	JE PRINTSPACE
	CMP COUNT,0DH
	JE PRINTSPACE
	CMP COUNT,1BH
	JE PRINTSPACE
	;CALL PRINT
	MOV DL,COUNT
    MOV AH,02H
    INT 21H;输出ascii码
    MOV DL,' '
    MOV AH,02H
    INT 21H
    MOV DL,' '
    MOV AH,02H
    INT 21H
    INC COUNT
    CMP LINE,0
    JE CHANGELINE;判断是否需要换行
    DEC LINE
	JMP LOP
	
PRINTSPACE:;特殊处理字符输出空格
	;CALL PRINT
	MOV DL,' '
    MOV AH,02H
    INT 21H
    MOV DL,' '
    MOV AH,02H
    INT 21H
    MOV DL,' '
    MOV AH,02H
    INT 21H
    INC COUNT
    CMP LINE,0
    JE CHANGELINE
    DEC LINE
	JMP LOP
	
CHANGELINE:	
	MOV DL,0AH
    MOV AH,02H
    INT 21H
    MOV LINE,0FH;重置换行指示数line的值
    CMP COUNT2, 38H;判断行表头大小，应小于8
    JE PAS
    MOV DL,COUNT2;输出行表头
    MOV AH,02H
    INT 21H
    MOV DL,' '
    MOV AH,02H
    INT 21H
    MOV DL,' '
    MOV AH,02H
    INT 21H
    INC COUNT2
PAS:
    JMP LOP

ENDPROG1:	
	MOV AH,4CH
    INT 21H
	
	


;PRINT PROC NEAR;输出三位以下十进制数
	;;LEA DX,MSGOUT
    ;;MOV AH,09H
    ;;INT 21H
  	;MOV BX,0AH
  	;MOV AL,COUNT
  	;XOR AH,AH
  	;XOR DX,DX
  	;DIV BX
  	;CMP AX,0AH
  	;JAE BIG1
  	;CMP AX,0H
  	;JE SMALL
  	;PUSH AX
    ;MOV DH,DL
    ;MOV DL,' '
    ;MOV AH,02H
    ;INT 21H
    ;POP AX
  	;MOV DL,AL
  	;ADD DL,30H
    ;MOV AH,02H
    ;INT 21H
    ;MOV DL,DH
    ;ADD DL,30H
    ;MOV AH,02H
    ;INT 21H
    ;MOV DL,':'
    ;MOV AH,02H
    ;INT 21H
    ;JMP EXIT
;BIG1:
	;PUSH DX
	;MOV BX,0AH
	;XOR DX,DX
	;DIV BX
	;MOV DH,DL
  	;MOV DL,AL
  	;ADD DL,30H
    ;MOV AH,02H
    ;INT 21H
    ;MOV DL,DH
    ;ADD DL,30H
    ;MOV AH,02H
    ;INT 21H
    ;POP DX
    ;ADD DL,30H
    ;MOV AH,02H
    ;INT 21H
    ;MOV DL,':'
    ;MOV AH,02H
    ;INT 21H
    ;JMP EXIT
;SMALL:
    ;MOV DH,DL
    ;MOV DL,' '
    ;MOV AH,02H
    ;INT 21H
    ;MOV DL,' '
    ;MOV AH,02H
    ;INT 21H
    ;MOV DL,DH
    ;ADD DL,30H
    ;MOV AH,02H
    ;INT 21H
    ;MOV DL,':'
    ;MOV AH,02H
    ;INT 21H
    ;JMP EXIT   
;EXIT:
	;RET  	
;PRINT ENDP  
CODE ENDS
   END START
















