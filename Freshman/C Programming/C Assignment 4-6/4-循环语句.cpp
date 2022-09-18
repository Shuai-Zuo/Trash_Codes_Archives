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


//迷你计算器
#include <stdio.h>
int main(void)
{
	int n=0,m=0,ch;
	double a,b;
	char c;
	while (1)
	{
		printf("\t\t\t迷你计算器\n\t\t\t1.输入数据\n\t\t\t2.四则运算\n\t\t\t0.退出\n");
		scanf("%d",&ch);
		switch (ch)
		{
			case 1:
				{
				printf("请输入数据:");
				scanf("%lf%lf",&a,&b);
				n=1;break;
				}
			case 2:	
				printf("请输入运算符:");
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
				case '+':printf("%lf+%lf=%lf\n",a,b,a+b);n=0,m=0;break;
				case '-':printf("%lf-%lf=%lf\n",a,b,a-b);n=0,m=0;break;
				case '*':printf("%lf*%lf=%lf\n",a,b,a*b);n=0,m=0;break;
				case '/':printf("%lf/%lf=%lf\n",a,b,a/b);n=0,m=0;break;
			}
		}

	}
}
