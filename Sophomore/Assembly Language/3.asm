DATAS SEGMENT
    MSGIN1 DB 'Input first number:$'
    MSGIN2 DB 'Input second number:$'
    MSGOUT1 DB 'The common factor is:',0ah,'$'
    MSGOUT2 DB 'The percentage is:',0ah,'$'
    MSGERR DB 0AH,'Invalid Input!',0ah,'$'
    NUM1 DW 0
    NUM2 DW 0
    INTPART DW 0,0,'$'
    FLOATPART DW 0,0,'$'
    COUNT DB 0
DATAS ENDS

STACK1 SEGMENT PARA STACK
    DW 20H DUP(0)
STACK1 ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS
START:
	MOV AX,DATAS
    MOV DS,AX
	JMP BEG2
ERR1: 
	LEA DX,MSGERR
    MOV AH,09H
    INT 21H
    JMP START
BEG2:
    CALL READ
    CMP NUM1,0
    JE ERR1
    CMP NUM2,0
    JE ERR1 ;����������Ϊ0
    CALL COMNUM
    CALL PERCENTAGE
    MOV AH,4CH
    INT 21H


COMNUM PROC NEAR
	LEA DX,MSGOUT1
    MOV AH,09H
    INT 21H
BEG:
	INC COUNT
	CMP COUNT,100
	JE EXIT
	MOV AX,NUM1
	DIV COUNT
	CMP AH,0
	JNE BEG ;������������count����������Ϊ0�����count
	MOV AX,NUM2
	DIV COUNT
	CMP AH,0
	JNE BEG
	CMP COUNT,10
	JA BIG;С��10ʱcount�����
	MOV BL,COUNT
	ADD BL,30H
	MOV DL,BL
    MOV AH,02H
    INT 21H
    MOV DL,20H
    MOV AH,02H
    INT 21H
    JMP BEG
BIG:;����10ʱcount�����
	XOR AX,AX
	MOV AL,COUNT
	MOV CH,10
	DIV C;��10������
	MOV BL,AL
	ADD BL,30H
	MOV DL,BL
	MOV BL,AH
    MOV AH,02H
    INT 21H
	ADD BL,30H
	MOV DL,BL
    MOV AH,02H
    INT 21H
    MOV DL,20H
    MOV AH,02H
    INT 21H
    JMP BEG
EXIT:
    MOV DL,0AH
    MOV AH,02H
    INT 21H
	NOP
	RET
COMNUM ENDP

READ PROC NEAR
    LEA DX,MSGIN1
    MOV AH,09H
    INT 21H
    CALL READ1;ͨ��read1¼��num1
    MOV BX,AX
    MOV NUM1,BX
;ENTER1:
    ;MOV AH,08H
    ;INT 21H
    ;CMP AL,0DH
    ;JNE ENTER1
    MOV DL,0AH
    MOV AH,02H
    INT 21H
    LEA DX,MSGIN2
    MOV AH,09H
    INT 21H
    CALL READ1;ͨ��read1¼��num2
    MOV BX,AX
    MOV NUM2,BX
;ENTER2:
    ;MOV AH,08H
    ;INT 21H
    ;CMP AL,0DH
    ;JNE ENTER2
    MOV DL,0AH
    MOV AH,02H
    INT 21H
    RET
READ ENDP

READ1 PROC NEAR

	JMP BEG1
ERR: 
	LEA DX,MSGERR
    MOV AH,09H
    INT 21H
    JMP START
BEG1:
    MOV AH,01H
    INT 21H
    CMP AL,'0'
    JB ERR
    CMP AL,'9'
    JA ERR;�ж��Ƿ�Ϊ����
    MOV DH,AL
    SUB DH,30H
    MOV AH,01H
    INT 21H
    CMP AL,0DH
    JZ DONE
    CMP AL,'0'
    JB ERR
    CMP AL,'9'
    JA ERR;�ж��Ƿ�Ϊ����
    SUB AL,30H
    SHL DH,1
    MOV DL,DH
    SHL DH,1
    SHL DH,1
    ADD DH,DL;ת��Ϊ���ֺ��16
    ADD DH,AL;�Ӹ�λ
DONE:
    MOV CL,DH
    MOV AL,CL
    XOR AH,AH
	RET
READ1 ENDP
    
OUTPUT PROC NEAR
    MOV BX,10
    MOV CX,0
NEXT:
    MOV DX,0
    DIV BX
    ADD DL,'0'
    PUSH DX
    INC CX
    CMP AX,0
    JNZ NEXT
    MOV AH,2;ͨ�����ϵس�ʮȡ�࣬��16������ת��Ϊ10���������
LP1:
    POP DX
    INT 21H
    LOOP LP1
    RET
OUTPUT ENDP

PERCENTAGE PROC NEAR
	LEA DX,MSGOUT2
    MOV AH,09H
    INT 21H
    MOV AL,BYTE PTR NUM1
    MOV BL,BYTE PTR NUM2
    ADD BL,AL
    MOV CL,100
    MUL CL;��ԭ����100�̲���Ϊ�������֣���������ΪС������
    DIV BL;������֮�͵õ��̺�����
    MOV DH,AH
    XOR AH,AH;���ah
    MOV INTPART[0],AX
    MOV AL,DH
    MUL CL
    DIV BL;��������������֮�õ�С��
    XOR AH,AH
    MOV FLOATPART[0],AX
    MOV AL,BYTE PTR NUM2;����num2ͬ���������ϲ���
    MUL CL
    DIV BL
    MOV DH,AH
    XOR AH,AH;���ah
    MOV INTPART[2],AX
    MOV AL,DH
    MUL CL
    DIV BL
    XOR AH,AH
    MOV FLOATPART[2],AX 
    
    MOV AX,INTPART[0];�����������������ֺ�С�������������output���
    CALL OUTPUT
    MOV DL,'.'
    MOV AH,02H
    INT 21H
    MOV AX,FLOATPART[0]
    CALL OUTPUT
    MOV DL,'%'
    MOV AH,02H
    INT 21H
    MOV DL,0AH
    MOV AH,02H
    INT 21H
    MOV AX,INTPART[2]
    CALL OUTPUT
    MOV DL,'.'
    MOV AH,02H
    INT 21H
    MOV AX,FLOATPART[2]
    CALL OUTPUT
    MOV DL,'%'
    MOV AH,02H
    INT 21H
    RET    
PERCENTAGE ENDP

CODES ENDS
    END START







