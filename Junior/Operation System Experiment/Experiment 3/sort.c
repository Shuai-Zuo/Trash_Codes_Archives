#include<stdio.h>
#include<pthread.h>
void bubblesort(int*a,int sync){
	int i,j,temp;
	if(sync==0)//big to small
		for(i=0;i<9;i++){
			for(j=0;j<9-i;j++){
				if(a[j]<a[j+1]){
					temp = a[j+1];
					a[j+1] = a[j];
					a[j] = temp;
				}
			}
		}
	else//small to big
		for(i=0;i<9;i++){
			for(j=0;j<9-i;j++){
				if(a[j]>a[j+1]){
					temp = a[j+1];
					a[j+1] = a[j];
					a[j] = temp;
				}
			}
		}
}
void *Thread1(void *arg){
	int*arr;
	int i;
	int sortarr[10];
	arr=(int*)arg;
	for(i=0;i<10;i++)
		sortarr[i]=*(arr+i);
	bubblesort(sortarr,0);
	printf("myThread1 sort:");
	for(i=0;i<10;i++){
		printf("%d ",*(sortarr+i));
	}
	printf("\n");
}
void *Thread2(void *arg){
	int*arr;
	int i;
	int sortarr[10];
	arr=(int*)arg;
	for(i=0;i<10;i++)
		sortarr[i]=*(arr+i);
	bubblesort(sortarr,1);
	printf("myThread2 sort:");
	for(i=0;i<10;i++){
		printf("%d ",*(sortarr+i));
	}
	printf("\n");
}
int main(){
	int arr[10]={5,4,6,2,1,3,7,0,9,8};
	int*attr=arr;
	pthread_t myThread1;
	pthread_t myThread2;
	pthread_create(&myThread1, NULL, &Thread1, (void *)attr);
	pthread_create(&myThread2, NULL, &Thread2, (void *)attr);
	pthread_join(myThread1, NULL);
	pthread_join(myThread2, NULL);
}
