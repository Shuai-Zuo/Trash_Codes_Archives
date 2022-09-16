/*
//学生人数与成绩
#include <stdio.h>
int main(void)
{
	int a,b,i;
	printf("请输入人数：");
	scanf("%d",&a);
	printf("请输入成绩：");
	for (i=1;i<=a;i++)
	{
		scanf("%d",&b);
		if (b>=0&&b<=100)
		{
		
			switch (b/10)
			{
				case 10:printf("优\n");break;
				case 9:printf("优\n");break;
				case 8:printf("良\n");break;
				case 7:printf("中\n");break;
				case 6:printf("及格\n");break;
				default:printf("不及格\n");
			}
		}
		else printf("Err!\n");
		
	
	}

}
*/


/*
//迷你计算器
#include <stdio.h>
int main(void)
{
	int n=0,m=0,ch;
	double a,b;
	char c;
	while (1)
	{
		printf("\t\t迷你计算器\n\t\t1.输入数据\n\t\t2.四则运算\n\t\t0.退出\n");
		scanf("%d",&ch);
		switch (ch)
		{
			case 1:
				{
				printf("Enter two Num:");
				scanf("%lf%lf",&a,&b);
				n=1;break;
				}
			case 2:	
				printf("运算符:");
				getchar();
				scanf("%c",&c);
				if (c=='+'||c=='-'||c=='*'||c=='/') 
					m=1;
				else printf("err1");
				break;
			case 0:break;
			default:printf("err2");
		}
		if (ch==0) break;
		if (n==1&&m==1)
		{
			switch (c)
			{
				case '+':printf("+=%lf\n",a+b);n=0,m=0;break;
				case '-':printf("-=%lf\n",a-b);n=0,m=0;break;
				case '*':printf("*=%lf\n",a*b);n=0,m=0;break;
				case '/':printf("/=%.2lf\n",a/b);n=0,m=0;break;
			}
		}

	}
}
*/

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

/*
//水仙花数
#include <stdio.h>
int main()
{
	int a,b,c,i;
	for (i=100;i<1000;i++)
	{
		a=i/100,b=i/10%10,c=i%10;
		//printf("%d%d%d\n",a,b,c);
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
	printf("Enter:");
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
	printf("%lf\n",s);
}
