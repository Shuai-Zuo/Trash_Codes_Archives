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
	INT 21H ;���'Input:$'
	LEA DX,BUF     
	MOV AH,0AH     
	INT 21H  ;�����ַ�������BUF
	LEA SI,BUF[2];ȡBUF[2]��ַ
	LEA DI,REV[2];ȡREV[2]��ַ
	MOV BL,BUF[1];���ַ������ȴ���BL
	ADD SI,BX;ʹSIָ��BUF�ַ�����ĩβ
	MOV CL,BUF+1;��ȡѭ������
REVERSE:     
	DEC SI
	MOV AL,[SI]
	CMP AL,'a'
	JB ERR
	CMP AL,'z' 
	JA ERR    ;�ж��Ƿ�ΪСд��ĸ
	MOV [DI],AL
	INC DI   ;��BUFβ��REVͷȻ��һ��һ���������
	LOOP REVERSE 
	MOV DL,0AH
    MOV AH,02H
    INT 21H ;����
	LEA DX,MSGOUT     
	MOV AH,09H     
	INT 21H   ;���'The reversed order is:$'
	LEA DX,REV     
	MOV AH,09H     
	INT 21H  ;�����������
	MOV DL,0AH
    MOV AH,02H
    INT 21H ;����
	MOV AH,4CH     
	INT 21H 
ERR:
	LEA DX,MSGERR     
	MOV AH,09H 
	INT 21H 
	MOV DL,0AH
    MOV AH,02H
    INT 21H
	JMP START   ;����
	;MOV AH,4CH     
	;INT 21H 
CODES ENDS 
END START











