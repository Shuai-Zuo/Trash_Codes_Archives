#include<stdio.h>
#include<pthread.h>
void *Thread1(void *arg){
	char*chr;
	chr=(char*)arg;
	printf("myThread1 received char %c\n",*chr);
}
void *Thread2(void *arg){
	int*num;
	num=(int*)arg;
	printf("myThread2 received integer %d\n",*num);
}
int main(){
	char chr='a';
	int num=7;
	char*attr1=&chr;
	int*attr2=&num;
	pthread_t myThread1;
	pthread_t myThread2;
	pthread_create(&myThread1, NULL, &Thread1, (void *)attr1);
	pthread_create(&myThread2, NULL, &Thread2, (void *)attr2);
	pthread_join(myThread1, NULL);
	pthread_join(myThread2, NULL);
}
