#include<stdio.h>
#include<stdlib.h>
#include<semaphore.h>
#include<pthread.h>
int arr[2] = {0};
int i = 0;  
int j = 0;
int k = 0;
sem_t empty;
sem_t prod1;
sem_t prod2;
sem_t cons1;
sem_t cons2;
sem_t data;
sem_t operate;
void *productor1(void *arg){
	int a;
	FILE*fp;
	fp=fopen("./1.dat","r");
	for(a=0;a<10;a++){
    		sem_wait(&prod1);
    		sem_wait(&empty);
    		fscanf(fp,"%d",arr+i%2);
    		i++;
    		sem_post(&prod2);
    		sem_post(&data);
    	}
}
void *productor2(void *arg){  
	int a;
	FILE*fp;
	fp=fopen("./2.dat","r");
	for(a=0;a<10;a++){
    		sem_wait(&prod2);
    		sem_wait(&empty);
    		fscanf(fp,"%d",arr+i%2);
    		i++;
    		sem_post(&prod1);
    		sem_post(&data);
    	}  
} 
void *consumer1(void *arg){  
	int a;
	int count1,count2;
	while(1){
		if(k>=10){
			break;
		}
		k++;
		sem_wait(&cons1);
		sem_wait(&operate);
		sem_wait(&data);
		count1=arr[j%2];
		j++;
		sem_post(&empty);
		sem_wait(&data);
		count2=arr[j%2];
		j++;
		printf("%d+%d=%d\n",count1,count2,count1+count2);
		sem_post(&empty);
		sem_post(&operate);
		sem_post(&cons2);
	}
} 
void *consumer2(void *arg){  
	int a;
	int count1,count2;
	while(1){
		if(k>=10){
			break;
		}
		k++;
		sem_wait(&cons2);
		sem_wait(&operate);
		sem_wait(&data);
		count1=arr[j%2];
		j++;
		sem_post(&empty);
		sem_wait(&data);
		count2=arr[j%2];
		j++;
		printf("%d*%d=%d\n",count1,count2,count1*count2);
		sem_post(&empty);
		sem_post(&operate);
		sem_post(&cons1);
	}
}
int main(){
	sem_init(&empty, 0, 2);
	sem_init(&prod1, 0, 1);
	sem_init(&prod2, 0, 0);
	sem_init(&cons1, 0, 1);
	sem_init(&cons2, 0, 0);
	sem_init(&data, 0, 0);
	sem_init(&operate, 0, 1);
	pthread_t read1;
	pthread_t read2;
	pthread_t operate1;
	pthread_t operate2;
	pthread_create(&read1, NULL, &productor1, NULL);
	pthread_create(&read2, NULL, &productor2, NULL);
	pthread_create(&operate1, NULL, &consumer1, NULL);
	pthread_create(&operate2, NULL, &consumer2, NULL);
	pthread_join(read1, NULL);
	pthread_join(read2, NULL);
	pthread_join(operate1, NULL);
	pthread_join(operate2, NULL);
	sem_destroy(&empty);
	sem_destroy(&prod1);
	sem_destroy(&prod2);
	sem_destroy(&cons1);
	sem_destroy(&cons2);
	sem_destroy(&data);
	sem_destroy(&operate);
	return (EXIT_SUCCESS);
}
