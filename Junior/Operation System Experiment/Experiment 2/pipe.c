#include <stdio.h>
#include<stdlib.h>
#include <sys/wait.h>
#include <unistd.h>
#include <string.h>
int main( ){
	int filedis[2];
	int pid1,pid2;
	char output[50],input[50];
	pipe(filedis);
	pid1=fork();
	if(pid1==0){
		lockf(filedis[1],1,0);
		sprintf(output,"Child 1 is sending a message!");
		write(filedis[1],output,50);
		lockf(filedis[1],0,0);
	}
	else if(pid1<0){
		printf("fork has failed.");
            	exit(1);
	}
	else{
		pid2=fork();
		if(pid2==0){
			lockf(filedis[1],1,0);
			sprintf(output,"Child 2 is sending a message!");
			write(filedis[1],output,50);
			lockf(filedis[1],0,0);
		}
		else if(pid2<0){
			printf("fork has failed.");
            		exit(1);
            	}
		else{
			wait(0);
			read(filedis[0],input,50);
			printf("%s\n",input);
			wait(0);
			read(filedis[0],input,50);
			printf("%s\n",input);
		}
	}
	return (EXIT_SUCCESS);
}

