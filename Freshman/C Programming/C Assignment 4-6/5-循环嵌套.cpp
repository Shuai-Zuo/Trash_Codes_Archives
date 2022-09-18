/*
//100-999偶数
#include <stdio.h>
int main()
{
	int i,n=0;
	for (i=100;i<1000;i++)
	{
		if (i%2==0)
		{
			printf("%-5d",i);
			n++;
			if (n%10==0)
				printf("\n");
		}
	}
}
*/

/*
//最小公倍数
#include <stdio.h>
int main()
{
	int a,b,t,x,a1,b1;
	printf("enter:");
	scanf("%d%d",&a,&b);
	a1=a,b1=b;
	if (b>a)
		t=a,a=b,b=t;
		x=a%b;
		while(x!=0)
		{
			a=b;
			b=x;
			x=a%b;
		}
		printf("最小公倍数:%d\n",a1*b1/b);
}
*/