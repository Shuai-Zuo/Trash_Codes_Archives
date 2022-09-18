#include<sys/types.h>
#include<sys/ipc.h>
#include<sys/msg.h>
#include<stdio.h>
#include<stdlib.h>
#include<stdlib.h>
#include<sys/wait.h>
#include<unistd.h>
#include<string.h>
struct msg_str{
	long int msg_type;
	char text[100];
};

void send(int msgid){
	char buf[100];
	struct msg_str s;
	while (1){
		scanf("%s",buf);
		s.msg_type = 1; 
		strcpy(s.text, buf);
		if (msgsnd(msgid, (void *)&s, sizeof(char)*100, IPC_NOWAIT) == -1){
			printf("msgsnd failed.\n");
			exit(1);
		}
		if (strcmp(buf, "exit") == 0){
			break;
		}
	}
}
void  receive(int msgid){
	struct msg_str s;
	long int msgtype=0;
	while (1){
		if (msgrcv(msgid, (void *)&s, 100, msgtype, 0) == -1){
			printf("msgrcv failed.\n");
			exit(1);
		}
		printf("%s\n",s.text);
		if (strcmp(s.text, "exit") == 0){
			break;
		}
	}
	if (msgctl(msgid, IPC_RMID, 0) == -1){
        printf("msgctl(IPC_RMID) failed.\n");
    }
}
int main() {
    	pid_t sender, receiver;
    	int msgid = -1;
    	struct msg_str s;
    	long int msgtype = 0;
    	msgid = msgget((key_t)1111, 0666 | IPC_CREAT);
    	if (msgid == -1){
		printf("msgget failed.\n");
		exit(1);
	}
	sender=fork();
	if(sender < 0){
		printf("fork has failed.");
		exit(1);
	}
	else if(sender == 0){
	    	send(msgid);
	}
	else{
		receiver=fork();
		if(receiver < 0){
			printf("fork has failed.");
			exit(1);
		}
		else if(receiver == 0){
			receive(msgid);
		}
		else{
			wait(0);
		}
	    }  
	return (EXIT_SUCCESS);
}
