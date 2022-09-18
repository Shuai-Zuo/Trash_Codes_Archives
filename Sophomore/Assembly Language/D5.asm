DATAS SEGMENT
   DIVN DW 5 DUP(0FFFFH)
   MSGIN1 DB 'Input numbers:$'
DATAS ENDS

STACKS SEGMENT
    DW 100H DUP(0)
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX
	LEA DX,MSGIN1
    MOV AH,09H
    INT 21H
    LEA DI,DIVN[0]   
    
    MOV CX,05H
LP1:
    CALL READ1
    MOV [DI],DX
    XOR DX,DX
    INC DI
    INC DI
	LOOP LP1
    
    
   	MOV DL,0AH
    MOV AH,02H
    INT 21H
    
    MOV CX,05H 
    LEA DI,DIVN[0]   
LP2:
    MOV AX,[DI]
    MOV DL,6
    DIV DL
    CMP AH,0
 	JE PR
 	INC DI
    INC DI
LOOP LP2


    
END1:    
    MOV AH,4CH
    INT 21H
    
PR:
	MOV AX,[DI]
	CALL PRINT
	INC DI
    INC DI
    DEC CX
	CMP CX,0
 	JE END1
 	JMP LP2
    
    
    
    
    
    
    
READ1 PROC NEAR
	JMP BEG1
ERR: 
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

PRINT PROC NEAR;�����λ����ʮ������
	;LEA DX,MSGOUT
    ;MOV AH,09H
    ;INT 21H
  	MOV BX,0AH
  	XOR DX,DX
  	DIV BX
  	CMP AX,0AH
  	JAE BIG1
  	CMP AX,0H
  	JE SMALL
  	PUSH AX
    MOV DH,DL
    POP AX
  	MOV DL,AL
  	ADD DL,30H
    MOV AH,02H
    INT 21H
    MOV DL,DH
    ADD DL,30H
    MOV AH,02H
    INT 21H
    JMP EXIT
BIG1:
	PUSH DX
	MOV BX,0AH
	XOR DX,DX
	DIV BX
	MOV DH,DL
  	MOV DL,AL
  	ADD DL,30H
    MOV AH,02H
    INT 21H
    MOV DL,DH
    ADD DL,30H
    MOV AH,02H
    INT 21H
    POP DX
    ADD DL,30H
    MOV AH,02H
    INT 21H
    JMP EXIT
SMALL:
    MOV DL,DH
    ADD DL,30H
    MOV AH,02H
    INT 21H
    JMP EXIT   
EXIT:
	MOV DL,' '
    MOV AH,02H
    INT 21H
	RET  	
PRINT ENDP 



CODES ENDS
    END START








