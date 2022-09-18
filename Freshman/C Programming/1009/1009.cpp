/*
#include <stdio.h>
void main()
{
	int l[26]={0},i;
	char a;
	while(1)
	{
		scanf("%c",&a);
		if(a>='a'&&a<='z')
			l[a-'a']++;
		if(a>='A'&&a<='Z')
			l[a-'A']++;
		if (a=='\n')
			break;
	}
	for (i=0;i<=25;i++)
		printf("[%c]%d\n",(i+'a'),l[i]);
}
*/
/*
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
void main()
{
	int i,r[100],n=0;
	srand((unsigned)time(NULL));
	for (i=0;i<100;i++)
	{
		r[i]=rand()%101;
		if (r[i]<=50&&r[i]%2==0)
		{
			n++;
		//	printf("%d\t",r[i]);
		}

	}
printf("\n\n%d",n);
}
*/

#include <stdio.h>
#define NUM 11
int main()
{
	int a[NUM]={2,1,6,4,3,5,8,9,8,7,9};
	int i,k=10,t;
	for (i=0;i<k;i++)
	{
		while(a[i]%2==0&&k >= i)
		{
			t=a[i];
			a[i]=a[k];
			a[k]=t;
			k--;
			//if (k<=i) break;
		}
	}
	for (i=0;i<=10;i++)
	printf("a[%d]%d\n",i,a[i]);
	return 0;	
}

/*
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#define NUM 11
int main()
{
	srand((unsigned)time(NULL));
	int a[NUM]={rand()%11,rand()%11,rand()%11,rand()%11,rand()%11,rand()%11,rand()%11,rand()%11,rand()%11,rand()%11,rand()%11};
	int i,k=10,t;
	for (i=0;i<k;i++)
	{
		while(a[i]%2==0)
		{
			t=a[i];
			a[i]=a[k];
			a[k]=t;
			k--;
			if (k<=i) break;
		}
	}
	for (i=0;i<=10;i++)
	printf("a[%d]%d\n",i,a[i]);
	return 0;
	
}
*/
/*
#include <stdio.h>
int main()
{
	int num[10]={11,19,9,12,5,20,1,18,4,16};
	int a[2],b[2],c[2],s,m=0,i;
	for (i=1;i<=9;i++)
	{
		a[1]=i;
		b[1]=i+1;
		if (b[1]>=10)
			b[1]-=10;
		c[1]=i+2;
		if (c[1]>=10)
			c[1]-=10;
		s=num[a[1]]+num[b[1]]+num[c[1]];
		if (m<s)
		{
			a[0]=a[1],b[0]=b[1],c[0]=c[1];
			m=s;
		}
	}
	printf("num[%d]:%d\nnum[%d]:%d\nnum[%d]:%d\n",a[0],num[a[0]],b[0],num[b[0]],c[0],num[c[0]]);
	return 0;
	
}
*/
/*	
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
int main()
{

	srand((unsigned)time(NULL));
	int num[10]={rand()%11,rand()%21,rand()%21,rand()%21,rand()%21,rand()%21,rand()%21,rand()%21,rand()%21,rand()%21};
	int a[2],b[2],c[2],s,m=0,i;
	for (i=1;i<=9;i++)
	{
		a[1]=i;
		b[1]=i+1;
		if (b[1]>=10)
			b[1]-=10;
		c[1]=i+2;
		if (c[1]>=10)
			c[1]-=10;
		s=num[a[1]]+num[b[1]]+num[c[1]];
		if (m<s)
		{
			a[0]=a[1],b[0]=b[1],c[0]=c[1];
			m=s;
		}
	}
	for (i=0;i<10;i++)
		printf("\tnum[%d]%d\n",i,num[i]);
	printf("num[%d]:%d\nnum[%d]:%d\nnum[%d]:%d\n",a[0],num[a[0]],b[0],num[b[0]],c[0],num[c[0]]);
	return 0;
	
}
*/