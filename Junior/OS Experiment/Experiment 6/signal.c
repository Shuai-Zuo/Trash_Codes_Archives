#include<stdio.h>
#include<signal.h>
#include<stdlib.h>
#include<unistd.h>
static void sig_usr(int signo){
	pid_t pid;
	if (signo == SIGUSR1){
		pid=getpid();
		printf("received SIGUSR1. current process pid is %d\n",(int)pid);
	}
	else if (signo == SIGUSR2){
		pid=getpid();
		printf("received SIGUSR2. current process pid is %d\n",(int)pid);
	}
	else if (signo == SIGINT){
		pid=getpid();
		printf("received SIGINT. current process pid is %d\n",(int)pid);
		exit(0);
	}
}
int main(void)
{
	pid_t p1;
	if (signal(SIGUSR1, sig_usr) == SIG_ERR){
		printf("can't catch SIGUSR1\n");
		exit(1);
	}
	if (signal(SIGUSR2, sig_usr) == SIG_ERR){
		printf("can't catch SIGUSR2\n");
		exit(1);
	}
	if (signal(SIGINT, sig_usr) == SIG_ERR){
		printf("can't catch SIGINT\n");
		exit(1);
	}
	p1=fork();
	if(p1<0){
		printf("fork has failed.\n");
		exit(1);
	}
	else if(p1==0){
		for ( ; ; )
			pause();
	}
	else{
		for ( ; ; )
			pause();
	}
}


