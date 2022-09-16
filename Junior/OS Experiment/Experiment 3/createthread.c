#include<stdio.h>
#include<pthread.h>
void *Thread1(void *arg){
	printf("myThread1 printed this message.\n");
}
void *Thread2(void *arg){
	printf("myThread2 printed this message.\n");
}
int main(){
	pthread_t myThread1;
	pthread_t myThread2;
	pthread_create(&myThread1, NULL, &Thread1, NULL);
	pthread_create(&myThread2, NULL, &Thread2, NULL);
	pthread_join(myThread1, NULL);
	pthread_join(myThread2, NULL);
}
