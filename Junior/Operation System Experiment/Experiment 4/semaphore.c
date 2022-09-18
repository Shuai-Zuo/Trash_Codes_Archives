#include<stdio.h>
#include<stdlib.h>
#include<semaphore.h>
#include<pthread.h>
int arr[2] = {0};
int i = 0;  
int j = 0;
int k = 0;
sem_t empty;
sem_t data;
sem_t operate;
sem_t prod;
void *productor1(void *arg){
	int a;
	FILE*fp;
	fp=fopen("./1.dat","r");
	for(a=0;a<10;a++){
		sem_wait(&prod);
    		sem_wait(&empty);
    		if(i==0){
    			fscanf(fp,"%d",arr);
    			i=1;
    		}
    		else{
    		    	fscanf(fp,"%d",arr+1);
    			i=0;
    		}
    		sem_post(&data);
    		sem_post(&prod);
    	}
}
void *productor2(void *arg){  
	int a;
	FILE*fp;
	fp=fopen("./2.dat","r");
	for(a=0;a<10;a++){
		sem_wait(&prod);
    		sem_wait(&empty);
    		if(i==0){
    			fscanf(fp,"%d",arr);
    			i=1;
    		}
    		else{
    		    	fscanf(fp,"%d",arr+1);
    			i=0;
    		}
    		sem_post(&data);
    		sem_post(&prod);
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
		sem_wait(&operate);
		sem_wait(&data);
		count1=arr[j%2];
		j++;
		sem_post(&empty);
		sem_wait(&data);
		count2=arr[j%2];
		if(count2==0)
			printf("%d %d\n",arr[1],arr[2]);
		j++;
		printf("%d+%d=%d\n",count1,count2,count1+count2);
		sem_post(&empty);
		sem_post(&operate);
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
	}
}
int main(){  
	sem_init(&empty, 0, 2);
	sem_init(&data, 0, 0);
	sem_init(&operate, 0, 1);
	sem_init(&prod, 0, 1);
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
	sem_destroy(&data);
	sem_destroy(&operate);
	sem_destroy(&prod);
	return (EXIT_SUCCESS);
}
