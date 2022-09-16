#include<sys/types.h>
#include<sys/ipc.h>
#include<sys/msg.h>
#include<stdio.h>
#include<stdlib.h>
#include<stdlib.h>
#include<sys/wait.h>
#include<unistd.h>
#include<string.h>
#include<sys/shm.h>
struct sharedmem_int
{
    int writable;
    int square[10];
};

void send(int shmid){
	int i=0;
	void *shm = NULL;
	struct sharedmem_int*s=NULL;
	shm = shmat(shmid, 0, 0);
	if (shm == (void *)-1){
        	printf("shmat failed.\n");
	exit(1);
	}
	s=(struct sharedmem_int *)shm;
	while (1){
		while (s->writable == 1);
	scanf("%d",&s->square[i]);
	i++;
	s->writable = 1;
	if(i==10)
		break;
        }
}
void  receive(int shmid){
	void *shm = NULL;
	int i=0;
    	struct sharedmem_int*s; 
	shm = shmat(shmid, 0, 0);
	if (shm == (void *)-1){
        	printf("shmat failed.\n");
        exit(1);
	}
	s = (struct sharedmem_int*)shm;
	s->writable = 0;
	
	while (1){
		if (s->writable == 1){
            		printf("%d\n", s->square[i]*s->square[i]);
            	s->writable = 0;
 		i++;
 		if(i==10)
 			break;
        	}
    	}
	if (shmdt(shm) == -1){
		printf("shmdt failed.\n");
		exit(1);
	 }

	if (shmctl(shmid, IPC_RMID, 0) == -1){
		printf("shmctl(IPC_RMID) failed.\n");
		exit(1);
	}
}
	

int main() {
    	pid_t sender, receiver;
    	int shmid;
    	shmid = shmget((key_t)1111, sizeof(struct sharedmem_int), 0666|IPC_CREAT);
	if (shmid == -1){
        	printf("shmget failed.\n");
        	exit(1);
	}
	sender=fork();
	if(sender < 0){
		printf("fork has failed.");
		exit(1);
	}
	else if(sender == 0){
	    	send(shmid);
	}
	else{
		receiver=fork();
		if(receiver < 0){
			printf("fork has failed.");
			exit(1);
		}
		else if(receiver == 0){
			receive(shmid);
		}
		else{
			wait(0);
		}
	    }  
	return (EXIT_SUCCESS);
}
