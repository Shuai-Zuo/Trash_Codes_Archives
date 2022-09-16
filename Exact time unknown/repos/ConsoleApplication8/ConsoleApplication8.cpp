#include <iostream>
#include <stdio.h> 
#include <math.h> 
#include <stdlib.h> 

#define STACK_INIT_SIZE 100 //栈初始大小
#define STACKINCREMENT 10 //栈满后扩展大小

typedef struct {
	char* base;
	char* top;
	int stacksize;
}SqStack1;

typedef struct {
	double* base;
	double* top;
	int stacksize;
}SqStack2;

SqStack1 OPTR;
SqStack2 OPND;


//栈初始化
void CHAR_InitStack(SqStack1& S);
void DOUBLE_InitStack(SqStack2& S);
//取栈顶
char CHAR_GetTop(SqStack1 S);
double DOUBLE_GetTop(SqStack2 S);
//入栈
int CHAR_Push(SqStack1& S, char e);
int DOUBLE_Push(SqStack2& S, double e);
//出栈
char CHAR_Pop(SqStack1& S, char& e);
double DOUBLE_Pop(SqStack2& S, double& e);

char Precede(char a, char b);//判断优先级
double Operate(double d, char e, double f);//二元运算
int In(char c);//是否为运算符
double EvaluateExpression();//产生后缀表达式

int main(void)
{
	double result;
	printf("18074102 左帅 上机题2\n");
	printf("请输入表达式:\n");
	result = EvaluateExpression();
	printf("\n后缀求值:%.2f\n\n\n", result);
}

void CHAR_InitStack(SqStack1& S)//符号栈初始化
{
	S.base = (char*)malloc(STACK_INIT_SIZE * sizeof(char));
	if (!S.base)exit(OVERFLOW);
	S.top = S.base;
	S.stacksize = STACK_INIT_SIZE;
}

void DOUBLE_InitStack(SqStack2& S)//数栈初始化
{
	S.base = (double*)malloc(STACK_INIT_SIZE * sizeof(double));
	if (!S.base)exit(OVERFLOW);
	S.top = S.base;
	S.stacksize = STACK_INIT_SIZE;
}

char CHAR_GetTop(SqStack1 S)//符号栈取栈顶
{
	char e;
	if (S.top == S.base) return -1;
	e = *(S.top - 1);
	return e;
}

double DOUBLE_GetTop(SqStack2 S)//数栈取栈顶
{
	double e;
	if (S.top == S.base) return -1;
	e = *(S.top - 1);
	return e;
}

int CHAR_Push(SqStack1& S, char e)//符号栈入栈
{
	if (S.top - S.base >= S.stacksize)//判断栈是否满，满则增加栈的大小
	{
		S.base = (char*)realloc(S.base, (S.stacksize + STACKINCREMENT) * sizeof(char));
		if (!S.base) exit(OVERFLOW);
		S.top = S.base + S.stacksize;
		S.stacksize += STACKINCREMENT;
	}
	*S.top++ = e;
	return 1;
}

int DOUBLE_Push(SqStack2& S, double e)//数栈入栈
{
	if (S.top - S.base >= S.stacksize)
	{
		S.base = (double*)realloc(S.base, (S.stacksize + STACKINCREMENT) * sizeof(double));
		if (!S.base) exit(OVERFLOW);
		S.top = S.base + S.stacksize;
		S.stacksize += STACKINCREMENT;
	}
	*S.top++ = e;
	return 1;
}

char CHAR_Pop(SqStack1& S, char& e)//符号栈出栈
{
	if (S.top == S.base)return -1;
	e = *--S.top;
	return e;
}

double DOUBLE_Pop(SqStack2& S, double& e)//数栈出栈
{
	if (S.top == S.base)return -1;
	e = *--S.top;
	return e;
}

int In(char c)  // 判断是否为运算符 
{
	if (c == '(' || c == '+' || c == '-' || c == '*' || c == '/' || c == ')' || c == '#' || c == '^')
		return 1;
	else
		return 0;
}

char Precede(char a, char b) //判断优先级 
{
	char op;
	switch (a)
	{
	case '#':
		if (b == '#')
			op = '=';
		else op = '<';
		break;
	case '+':
		if (b == '*' || b == '/' || b == '(' || b == '^')
			op = '<';
		else op = '>';
		break;
	case '-':
		if (b == '*' || b == '/' || b == '(' || b == '^')
			op = '<';
		else op = '>';
		break;
	case '*':
		if (b == '(' || b == '^')
			op = '<';
		else op = '>';
		break;
	case '/':
		if (b == '(' || b == '^')
			op = '<';
		else op = '>';
		break;
	case'^':
		if (b == '(')
			op = '<';
		else op = '>';
		break;
	case '(':
		if (b == ')')
			op = '=';
		else op = '<';
		break;
	case ')':
		op = '>';
		break;
	}
	return op;
}

double Operate(double d, char e, double f) //二元运算 
{
	double g;
	switch (e)
	{
	case '+':
		g = d + f;
		break;
	case '-':
		g = d - f;
		break;
	case '*':
		g = d * f;
		break;
	case '/':
		g = d / f;
		break;
	case '^':
		g = pow(d, f);
		break;
	}
	return g;
}

double EvaluateExpression()//表达式转换并产生输出表达式
{
	char c = 0, theta, x;
	double a, b, number, n = 0;
	CHAR_InitStack(OPTR);//运算符栈
	CHAR_Push(OPTR, '#');
	DOUBLE_InitStack(OPND);//运算数栈
	c = getchar();
	printf("中缀->后缀:\n");
	while (c != '#' || CHAR_GetTop(OPTR) != '#') //遍历每一个字符 直到字符为‘#’结束
	{
		if (!In(c))//如果不是运算符
		{
			number = 0;
			while (!In(c))//整数
			{
				if (c == '.')
					break;
				number = number * 10 + (c - 48);//ascii码转数字
				c = getchar();
			}
			if (c == '.')//小数
			{
				n = 1;
				while (!In(c = getchar()))
				{
					number = number + (c - 48) * (double)pow(0.1, n);
					n++;
				}
			}
			DOUBLE_Push(OPND, number);
			printf("%.2f ", number);
		}
		else//如果是运算符
			switch (Precede(CHAR_GetTop(OPTR), c))
			{
			case '<'://当前运算符优先级高 入栈
				CHAR_Push(OPTR, c);
				c = getchar();
				break;
			case '='://优先级相等
				CHAR_Pop(OPTR, x);
				c = getchar();
				break;
			case '>': //当前运算符优先级低
				CHAR_Pop(OPTR, theta);//运算符出栈,和操作数的头两个数运算 
				printf("%c ", theta);
				DOUBLE_Pop(OPND, a);
				DOUBLE_Pop(OPND, b);
				DOUBLE_Push(OPND, Operate(b, theta, a));//计算结果入栈
				break;
			}
	}
	return (DOUBLE_GetTop(OPND));//返回运算数栈顶元素，即运算结果 
}
