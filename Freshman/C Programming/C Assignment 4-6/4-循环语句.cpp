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


//���������
#include <stdio.h>
int main(void)
{
	int n=0,m=0,ch;
	double a,b;
	char c;
	while (1)
	{
		printf("\t\t\t���������\n\t\t\t1.��������\n\t\t\t2.��������\n\t\t\t0.�˳�\n");
		scanf("%d",&ch);
		switch (ch)
		{
			case 1:
				{
				printf("����������:");
				scanf("%lf%lf",&a,&b);
				n=1;break;
				}
			case 2:	
				printf("�����������:");
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
