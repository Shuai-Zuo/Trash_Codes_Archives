/*
//ѧ��������ɼ�
#include <stdio.h>
int main(void)
{
	int a,b,i;
	printf("������������");
	scanf("%d",&a);
	printf("������ɼ���");
	for (i=1;i<=a;i++)
	{
		scanf("%d",&b);
		if (b>=0&&b<=100)
		{
		
			switch (b/10)
			{
				case 10:printf("��\n");break;
				case 9:printf("��\n");break;
				case 8:printf("��\n");break;
				case 7:printf("��\n");break;
				case 6:printf("����\n");break;
				default:printf("������\n");
			}
		}
		else printf("Err!\n");
		
	
	}

}
*/


/*
//���������
#include <stdio.h>
int main(void)
{
	int n=0,m=0,ch;
	double a,b;
	char c;
	while (1)
	{
		printf("\t\t���������\n\t\t1.��������\n\t\t2.��������\n\t\t0.�˳�\n");
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
				printf("�����:");
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
//100-999ż��
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
//��С������
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
		printf("��С������:%d\n",a1*b1/b);
}
*/

/*
//ˮ�ɻ���
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
//100��������
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
//��ʽ�ֽ�
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


//���к�
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
