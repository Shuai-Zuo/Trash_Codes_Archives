DATAS SEGMENT
    BUF DB 50,?,50 DUP(?)
	MSGIN DB 'Input Sentence:',0AH,0DH,'$'
	MSGOUT1 DB 0AH,0DH,'Student id:18074102$'
	MSGERR DB 0AH,'Invalid Input!$'
	MSGOUT2 DB 0AH,'$The value of n is：$'
	MSGOUT3 DB 0AH,'$The ITH WORD is：$'
	NUM DW 4102D
	COUNTER DB 1H
	COUNTER2 DB 0
	COUNTER3 DB 1
	COUNTER4 DB 0
	N DB 0
DATAS ENDS

STACKS SEGMENT
    ;此处输入堆栈段代码
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX
    
    LEA DX,MSGIN     
	MOV AH,09H
	INT 21H
    
   	LEA DX,BUF     
	MOV AH,0AH     
	INT 21H 
	
	LEA SI,BUF[2];取BUF[2]地址
	MOV BL,BUF[1];将字符串长度存入BL
	MOV AL,[SI]
	CMP AL,'a'
	JB ERR
	CMP AL,'z' 
	JA ERR
JUDGE:
	INC SI
	INC COUNTER2
	MOV AL,[SI]
	CMP AL,' '
	JE ADD1
	CMP AL,'a'
	JB ERR
	CMP AL,'z' 
	JA ERR
	CMP COUNTER2,BL
	JE END1
	JMP JUDGE

		

ERR:
END1:
	LEA DX,MSGOUT1
	MOV AH,09H
	INT 21H
	LEA DX,MSGOUT2
	MOV AH,09H
	INT 21H
	LEA DX,MSGOUT2     
	MOV AH,09H
	INT 21H
	
	MOV DL,COUNTER
	ADD DL,30H
    MOV AH,02H
    INT 21H
	MOV CL,COUNTER
	MOV AX,NUM
	XOR CH,CH
	XOR DX,DX
	DIV CX
	INC AH
	
	ADD DL,1
	MOV DH,DL
	ADD DL,30H
	MOV N,DH
   
    LEA DX,MSGOUT3
	MOV AH,09H
	INT 21H
	LEA SI,BUF[2]
	MOV BL,BUF[1]
	DEC SI
RE:
	INC SI
	MOV AL,[SI]
	INC COUNTER4
	CMP AL,' '
	JE DD1
	MOV BH,COUNTER3
	CMP N,BH
	JNE RE
	MOV DL,[SI]
	MOV AH,02H
    INT 21H
    CMP COUNTER4,BL
	JAE END2
    JMP RE
DD1:
	INC COUNTER3
	CMP COUNTER4,BL
	JAE END2
	JMP RE	
	


END2:
    MOV AH,4CH
    INT 21H
    
    
ADD1:
	INC COUNTER
	CMP COUNTER2,BL
	JE END1
	JMP JUDGE



CODES ENDS
    END START













