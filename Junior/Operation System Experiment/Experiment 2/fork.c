#include<stdio.h>
#include<stdlib.h>
#include<sys/types.h>
#include<sys/wait.h>
#include<unistd.h>
int main() {
    pid_t pid1, pid2;
    pid1=fork();
    if(pid1 < 0){
        printf("fork has failed.");
        exit(1);
    }
    else if(pid1 == 0){
        printf("b");
    }
    else{
        pid2=fork();
        if(pid2 < 0){
            printf("fork has failed.");
            exit(1);
        }
        else if(pid2 == 0){
            printf("c");
        }
        else{
            printf("a");
        }
    }  
    return (EXIT_SUCCESS);
}
