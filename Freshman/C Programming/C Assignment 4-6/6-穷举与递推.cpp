/*
//水仙花数
#include <stdio.h>
int main()
{
	int a,b,c,i;
	for (i=100;i<1000;i++)
	{
		a=i/100,b=i/10%10,c=i%10;
		if ((a*a*a+b*b*b+c*c*c)==i)
		{
			printf("%-4d",i);
		}
		
	}
	printf("\n");
}
*/


/*
//100以内质数
#include <stdio.h>
int main()
{
	int i,m,n=0,a;
	for (i=1;i<=100;i++)
	{
		a=0;
		for (m=1;m<=i;m++)
		{
			if (i%m==0)
				a=a+1;
		}
		if (a==2)
		{
			printf("%-3d",i);
			n++;
			if (n%5==0)
				printf("\n");
		}
	}
	printf("\n");
}
*/


/*
//因式分解
#include <stdio.h>
int main()
{
	int n,a,b;
	printf("请输入一个整数:");
	scanf("%d",&a);
	for (n=1;n<=a;n++)
	{
		if (a%n==0)
		{
			printf("%-2d ",n);
			b++;
			if (b%5==0)
				printf("\n");
		}
	}
	printf("\n");
}
*/

/*
//数列和
#include <stdio.h>
int main()
{
	int i;
	double a=1,s=0;
	for (i=1;;i++,a++)
	{
		if (i%2==1)
			s=s+1/a;
		else s=s-1/a;
		if (1/a<1E-4)
			break;
	}
	printf("数列的和为%lf\n",s);
}
*/