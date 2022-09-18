DATAS SEGMENT     
	BUF DB 30,?,30 DUP(?)     
	REV DB 0DH,0AH,30 DUP('$')
	MSGIN DB 'Input:$'
	MSGOUT DB 'The reversed order is:$'
	MSGERR DB 0AH,'Invalid Input!$'
DATAS ENDS
STACK1 SEGMENT PARA STACK
    DW 20H DUP(0)
STACK1 ENDS
CODES SEGMENT     
ASSUME CS:CODES,DS:DATAS 
START:     
	MOV AX,DATAS     
	MOV DS,AX	
	LEA DX,MSGIN     
	MOV AH,09H
	INT 21H ;输出'Input:$'
	LEA DX,BUF     
	MOV AH,0AH     
	INT 21H  ;输入字符串存入BUF
	LEA SI,BUF[2];取BUF[2]地址
	LEA DI,REV[2];取REV[2]地址
	MOV BL,BUF[1];将字符串长度存入BL
	ADD SI,BX;使SI指向BUF字符串的末尾
	MOV CL,BUF+1;获取循环次数
REVERSE:     
	DEC SI
	MOV AL,[SI]
	CMP AL,'a'
	JB ERR
	CMP AL,'z' 
	JA ERR    ;判断是否为小写字母
	MOV [DI],AL
	INC DI   ;将BUF尾给REV头然后一减一增逐个传递
	LOOP REVERSE 
	MOV DL,0AH
    MOV AH,02H
    INT 21H ;换行
	LEA DX,MSGOUT     
	MOV AH,09H     
	INT 21H   ;输出'The reversed order is:$'
	LEA DX,REV     
	MOV AH,09H     
	INT 21H  ;输出反向序列
	MOV DL,0AH
    MOV AH,02H
    INT 21H ;换行
	MOV AH,4CH     
	INT 21H 
ERR:
	LEA DX,MSGERR     
	MOV AH,09H 
	INT 21H 
	MOV DL,0AH
    MOV AH,02H
    INT 21H
	JMP START   ;报错
	;MOV AH,4CH     
	;INT 21H 
CODES ENDS 
END START











