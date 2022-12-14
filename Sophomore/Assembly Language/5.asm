DATAS SEGMENT
   	MSGERR DB 0AH,'Invalid Input!',0ah,'$'
   	MSGIN1 DB 'Input numbers:$'
   	MSGOUT DB 'The Order is:$'
   	BUF DW 10 DUP(0FFFFH)
   	COUNT DB 0
   	COUNT1 DB 0
   	COUNT2 DB 0
	NUMB  DB  0
DATAS ENDS

STACKS SEGMENT
     DW 100H DUP(0)
STACKS ENDS


CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX
    LEA DI,BUF[0]
    MOV CX,0AH
    LEA DX,MSGIN1
    MOV AH,09H
    INT 21H
LP1:
    CALL READ1
    MOV [DI],DX
    XOR DX,DX 
    INC DI
    INC DI
    DEC CX
 	CMP CX,0
 	JNE LP1  ;逐个录入10个数
	CALL SORT ;排序
	MOV DL,0AH
    MOV AH,02H
    INT 21H  
	CALL PRINT;输出
    MOV AH,4CH
    INT 21H
    
SORT  PROC NEAR;冒泡排序
	PUSH AX 
	PUSH BX
	PUSH CX
	LOP1:  
	MOV COUNT2,0D 
	LEA SI,BUF[0]
	SUB SI,2H
	INC COUNT1
	CMP COUNT1,10D;内层循环10次
	JZ NEX 
	LOP2:  
	INC COUNT2
	ADD SI,2H
	CMP COUNT2,10D;外层循环10次
	JZ LOP1
	MOV BX,[SI+2H]
	CMP [SI],BX
	JG SWAP ;若[si]大于[si+2h]则调用swap，否则继续循环
	JMP LOP2
	SWAP:  
	MOV AX,[SI]
	MOV CX,[SI+2H]
	MOV [SI],CX
	MOV [SI+2H],AX;通过中间寄存器交换[SI+2H]与[SI]
	JMP LOP2
	NEX:  
	POP CX
	POP BX
	POP AX
	MOV DX,BUF[0]
	RET
SORT  ENDP    
    
    
    
    
READ1 PROC NEAR
	JMP BEG1
ERR: 
	LEA DX,MSGERR
    MOV AH,09H
    INT 21H
    XOR AH,AH
    XOR DX,DX
BEG1:
    MOV AH,01H
    INT 21H
    CMP AL,'0'
    JB ERR
    CMP AL,'9'
    JA ERR;判断是否为数字
    MOV DL,AL
    SUB DL,30H
    MOV AH,01H
    INT 21H
    ;CMP AL,0DH
    ;JZ DONE
    ;CMP AL,' '
    ;JZ DONE
    CMP AL,'0'
    JB ERR
    CMP AL,'9'
    JA ERR;判断是否为数字
    SUB AL,30H
    SHL DX,1
    MOV BX,DX
    SHL DX,1
    SHL DX,1;转换为数字后乘16
    ADD DX,BX;加低位
    XOR AH,AH
    ADD DX,AX
    MOV AH,01H
    INT 21H
    CMP AL,0DH
    JZ DONE
    CMP AL,' '
    JZ DONE
    CMP AL,'0'
    JB ERR
    CMP AL,'9'
    JA ERR;判断是否为数字
    SUB AL,30H
    SHL DX,1
    MOV BX,DX
    SHL DX,1
    SHL DX,1
    ADD DX,BX;转换为数字后乘16
    XOR AH,AH
    ADD DX,AX ;加低位
    PUSH DX
    MOV DL,' '
    MOV AH,02H
    INT 21H
    POP DX
DONE:
    XOR AH,AH
	RET
READ1 ENDP
   
   
   
PRINT PROC NEAR
	LEA DX,MSGOUT
    MOV AH,09H
    INT 21H
  	LEA SI,BUF[0]
LOP:  
	CMP COUNT,0AH
	JAE EXIT
  	MOV BX,0AH
  	MOV AX,[SI]
  	XOR DX,DX
  	DIV BX;除10获得十位部分
  	CMP AX,0AH
  	JAE BIG1;若十位大于10则计算百位部分
    MOV DH,DL
  	MOV DL,AL
  	ADD DL,30H;加30h转换为字符输出
    MOV AH,02H
    INT 21H
    MOV DL,DH
    ADD DL,30H;个位部分加30h转换为字符输出
    MOV AH,02H
    INT 21H
    ADD SI,02H
    INC COUNT
    MOV DL,' ';输出‘ ’
    MOV AH,02H
    INT 21H
    JMP LOP	
BIG1:
	PUSH DX
	MOV BX,0AH
	XOR DX,DX
	DIV BX;除10获得百位部分
	MOV DH,DL
  	MOV DL,AL
  	ADD DL,30H;加30h转换为字符输出
    MOV AH,02H
    INT 21H
    MOV DL,DH
    ADD DL,30H;十位部分加30h转换为字符输出
    MOV AH,02H
    INT 21H
    POP DX;个位部分出栈
    ADD DL,30H;个位部分加30h转换为字符输出
    MOV AH,02H
    INT 21H
    ADD SI,02H
    INC COUNT
    MOV DL,' ';输出‘ ’
    MOV AH,02H
    INT 21H
    JMP LOP
EXIT:
	RET  	
PRINT ENDP      
CODES ENDS
    END START












