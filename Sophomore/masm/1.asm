DATAS SEGMENT
    MSG DB 'Input score:$'
    MSGSUC DB 'The Grade is:$'
    MSGERR DB 'Invalid Input!',0ah,'$'
    BUF DB 4,?,4 DUP(?)
DATAS ENDS
STACK1 SEGMENT PARA STACK
    DW 20H DUP(0)
STACK1 ENDS
CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS
START:
	MOV AX , DATAS
	MOV DS , AX
	LEA  DX, MSG
    MOV  AH, 9H
   	INT  21H ;���'Input score:$'
   	LEA  DX, BUF
    MOV  AH, 0AH
   	INT  21H ;�����ַ�������BUF
   	CMP BYTE PTR[BUF+4],0DH
   	JE COMPARE
   	CMP BYTE PTR[BUF+3],0DH
   	JE COMPARE2 ;�жϻ��з�λ��
   	CMP BYTE PTR[BUF+2],'e'
   	JNE STACMP
   	CMP BYTE PTR[BUF+3],'n'
   	JNE STACMP
   	CMP BYTE PTR[BUF+4],'d'
   	JE EXIT;�ж�Ϊ'end'�˳�����
STACMP:
	CMP BYTE PTR[BUF+2],'0'
	JE COMPARE0 
   	CMP BYTE PTR[BUF+2],'1'
	JNE ERR
	CMP BYTE PTR[BUF+3],'0'
	JNE ERR
	CMP BYTE PTR[BUF+4],'0'
	JNE ERR;��λ��������ж��Ƿ�Ϊ100
	MOV  DL, 0AH
   	MOV   AH,2
	INT   21H
	JMP A  	
EXIT:
   	MOV   AH,4CH
	INT   21H   	
   	  	
COMPARE:
   	MOV  DL, 0AH
   	MOV   AH,2
	INT   21H
   	CMP BYTE PTR[BUF+2],'0'
  	JB ERR
   	CMP BYTE PTR[BUF+3],'0'
   	JB ERR
   	CMP BYTE PTR[BUF+2],'9'
   	JG ERR
   	CMP BYTE PTR[BUF+3],'9'
   	JG ERR
   	CMP BYTE PTR[BUF+2],'9'
   	JGE A
   	CMP BYTE PTR[BUF+2],'8'
   	JGE COMPARE85
   	CMP BYTE PTR[BUF+2],'7'
   	JGE COMPARE75
   	CMP BYTE PTR[BUF+2],'6'
   	JGE CR
   	CMP BYTE PTR[BUF+2],'5'
   	JBE D;��λ��������ж�
COMPARE85:
	CMP BYTE PTR[BUF+3],'5'
	JGE A;��λ��������ж��Ƿ���ڵ���85
	JB B   	
COMPARE75:
	CMP BYTE PTR[BUF+3],'5'
	JGE B;��λ��������ж��Ƿ���ڵ���75
	JB CR 
	
COMPARE2:
	CMP BYTE PTR[BUF+2],'0'
  	JB ERR
   	CMP BYTE PTR[BUF+2],'9'
   	JG ERR;һλ��������ж�
   	MOV  DL, 0AH
   	MOV   AH,2
	INT   21H
   	JMP D
   	
COMPARE0:
   	MOV  DL, 0AH
   	MOV   AH,2
	INT   21H
   	CMP BYTE PTR[BUF+3],'0'
  	JB ERR
   	CMP BYTE PTR[BUF+4],'0'
   	JB ERR
   	CMP BYTE PTR[BUF+3],'9'
   	JG ERR
   	CMP BYTE PTR[BUF+4],'9'
   	JG ERR
   	CMP BYTE PTR[BUF+3],'9'
   	JGE A
   	CMP BYTE PTR[BUF+3],'8'
   	JGE COMPARE85
   	CMP BYTE PTR[BUF+3],'7'
   	JGE COMPARE75
   	CMP BYTE PTR[BUF+3],'6'
   	JGE CR
   	CMP BYTE PTR[BUF+3],'5'
   	JBE D;��λ��������ж���λΪ�����λ���ж�
	
A:
	LEA  DX, MSGSUC
    MOV  AH, 9
   	INT  21H
   	MOV  DL, 'A'
   	MOV   AH,2
   	INT  21H
   	MOV  DL, 0AH
   	MOV   AH,2
	INT   21H
	JMP START  ;����ɼ�A

B:
	LEA  DX, MSGSUC
    MOV  AH, 9
   	INT  21H
   	MOV  DL, 'B'
   	MOV   AH,2
   	INT  21H
	
   	MOV  DL, 0AH
   	MOV   AH,2
	INT   21H
	JMP START ;����ɼ�b
CR:
	LEA  DX, MSGSUC
    MOV  AH, 9
   	INT  21H
   	MOV  DL, 'C'
   	MOV   AH,2
   	INT  21H
   	MOV  DL, 0AH
   	MOV   AH,2
	INT   21H
	JMP START  ;����ɼ�c
D:
	LEA  DX, MSGSUC
    MOV  AH, 9
   	INT  21H
   	MOV  DL, 'D'
   	MOV   AH,2	
   	INT  21H
   	MOV  DL, 0AH
   	MOV   AH,2
	INT   21H
	JMP START  ;����ɼ�d
	
ERR:   	
	MOV  DL, 0AH
   	MOV   AH,2
	INT   21H
	LEA  DX, MSGERR
    MOV  AH, 9
   	INT  21H
	JMP START  	;����
CODES ENDS
    END START







