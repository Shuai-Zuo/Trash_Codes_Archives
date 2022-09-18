#include<stdio.h>
#include<stdlib.h>
#include<sys/types.h>
#include<unistd.h>
int main() {
    pid_t pid1, pid2;
    int i;
    pid1=fork();
    if(pid1 < 0){
        printf("fork has failed.");
        exit(1);
    }
    else if(pid1 == 0){
    	for(i=0;i<1000;i++)
        	printf("b");
        printf("\n");
    }
    else{
        pid2=fork();
        if(pid2 < 0){
            printf("fork has failed.");
            exit(1);
        }
        else if(pid2 == 0){
        	for(i=0;i<1000;i++)
        		printf("c");
        	printf("\n");
        }
        else{
		for(i=0;i<1000;i++)
        		printf("a");
        	printf("\n");
        }
    }  
    return (EXIT_SUCCESS);
}
