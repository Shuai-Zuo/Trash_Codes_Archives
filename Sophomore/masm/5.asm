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
 	JNE LP1  ;���¼��10����
	CALL SORT ;����
	MOV DL,0AH
    MOV AH,02H
    INT 21H  
	CALL PRINT;���
    MOV AH,4CH
    INT 21H
    
SORT  PROC NEAR;ð������
	PUSH AX 
	PUSH BX
	PUSH CX
	LOP1:  
	MOV COUNT2,0D 
	LEA SI,BUF[0]
	SUB SI,2H
	INC COUNT1
	CMP COUNT1,10D;�ڲ�ѭ��10��
	JZ NEX 
	LOP2:  
	INC COUNT2
	ADD SI,2H
	CMP COUNT2,10D;���ѭ��10��
	JZ LOP1
	MOV BX,[SI+2H]
	CMP [SI],BX
	JG SWAP ;��[si]����[si+2h]�����swap���������ѭ��
	JMP LOP2
	SWAP:  
	MOV AX,[SI]
	MOV CX,[SI+2H]
	MOV [SI],CX
	MOV [SI+2H],AX;ͨ���м�Ĵ�������[SI+2H]��[SI]
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
    JA ERR;�ж��Ƿ�Ϊ����
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
    JA ERR;�ж��Ƿ�Ϊ����
    SUB AL,30H
    SHL DX,1
    MOV BX,DX
    SHL DX,1
    SHL DX,1;ת��Ϊ���ֺ��16
    ADD DX,BX;�ӵ�λ
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
    JA ERR;�ж��Ƿ�Ϊ����
    SUB AL,30H
    SHL DX,1
    MOV BX,DX
    SHL DX,1
    SHL DX,1
    ADD DX,BX;ת��Ϊ���ֺ��16
    XOR AH,AH
    ADD DX,AX ;�ӵ�λ
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
  	DIV BX;��10���ʮλ����
  	CMP AX,0AH
  	JAE BIG1;��ʮλ����10������λ����
    MOV DH,DL
  	MOV DL,AL
  	ADD DL,30H;��30hת��Ϊ�ַ����
    MOV AH,02H
    INT 21H
    MOV DL,DH
    ADD DL,30H;��λ���ּ�30hת��Ϊ�ַ����
    MOV AH,02H
    INT 21H
    ADD SI,02H
    INC COUNT
    MOV DL,' ';����� ��
    MOV AH,02H
    INT 21H
    JMP LOP	
BIG1:
	PUSH DX
	MOV BX,0AH
	XOR DX,DX
	DIV BX;��10��ð�λ����
	MOV DH,DL
  	MOV DL,AL
  	ADD DL,30H;��30hת��Ϊ�ַ����
    MOV AH,02H
    INT 21H
    MOV DL,DH
    ADD DL,30H;ʮλ���ּ�30hת��Ϊ�ַ����
    MOV AH,02H
    INT 21H
    POP DX;��λ���ֳ�ջ
    ADD DL,30H;��λ���ּ�30hת��Ϊ�ַ����
    MOV AH,02H
    INT 21H
    ADD SI,02H
    INC COUNT
    MOV DL,' ';����� ��
    MOV AH,02H
    INT 21H
    JMP LOP
EXIT:
	RET  	
PRINT ENDP      
CODES ENDS
    END START












