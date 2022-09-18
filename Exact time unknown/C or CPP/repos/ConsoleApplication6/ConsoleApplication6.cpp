#include <iostream>
#include <stack>
#include <queue>
#include <string>
#include<math.h>
using namespace std;

class Node//结点类
{
public:
	char oper;
	Node* left;
	Node* right;
	int s; int t;
	Node()
	{
		left = right = NULL;
		oper = 0;
	}
	Node(char op) {
		left = right = NULL;
		oper = op;
	}
};


bool isOper(char op)//判断是否为运算符
{
	char oper[] = { '(',')','+','-','*','/','^' };
	for (int i = 0; i < sizeof(oper); i++)
	{
		if (op == oper[i])
		{
			return true;
		}
	}
	return false;
}

int getOperOrder(char op)//返回运算符op所对应的优先级
{
	switch (op) {
	case '(': return 1;
	case '+':
	case '-':return 2;
	case '*':
	case '/':return 3;
	case '^':return 4;
	default:
		return 0;
	}
}

void freeTree(Node*& p) //递归删除树
{
	if (p->left != NULL)
		freeTree(p->left);
	if (p->right != NULL)
		freeTree(p->right);
	delete(p);
}

void postOrder(Node* p) //先序遍历
{
	if (p)
	{
		postOrder(p->left);
		postOrder(p->right);
		cout << p->oper;
	}
}

void preOrder(Node* p) //后序遍历
{
	if (p)
	{
		cout << p->oper;
		preOrder(p->left);
		preOrder(p->right);
	}
}

void inOrder(Node* p)//中序遍历，同时输出不带冗余括号的中缀表达式
{
	if (p)
	{
		if (p->left)
		{//如果当前节点的左子树是运算符，且运算符优先级低于当前运算符，
			 //那么左边的表达式要先计算，需要加括号
			if (isOper(p->left->oper) && getOperOrder(p->left->oper) < getOperOrder(p->oper))
			{
				cout << "(";
				inOrder(p->left);
				cout << ")";
			}
			else//否则直接输出左子树
				inOrder(p->left);
		}

		cout << p->oper;//输出当前节点

		if (p->right)
		{  //如果当前节点的右子树是运算符，且运算符优先级不高于当前运算符，
			 //那么右边的表达式要先计算，需要加括号
			if (isOper(p->right->oper) && getOperOrder(p->right->oper) <= getOperOrder(p->oper))
			{
				cout << "(";
				inOrder(p->right);
				cout << ")";
			}
			else
				inOrder(p->right);
		}
	}
}

void post2tree(Node*& p, string str)//后缀表达式生成二叉树
{
	stack <Node*> nodeStack;//用于保存节点指针的栈
	char temp;
	int i = 0;
	temp = str[i++];
	while (temp != '\0')
	{
		if (temp != '\0' && !isOper(temp))//不是运算符，则进栈
		{
			p = new Node(temp);//以temp为结点值构造二叉树结点
			nodeStack.push(p);
			temp = str[i++];//读入下一个
		}
		else
		{  //如果遇到符号，则出栈，依次设为右节点和左节点
			p = new Node(temp);
			if (nodeStack.size())
			{
				p->right = nodeStack.top();//若非空则出栈并设为结点的右孩子
				nodeStack.pop();
			}
			if (nodeStack.size())
			{
				p->left = nodeStack.top();//若非空则出栈并设为结点的左孩子
				nodeStack.pop();
			}
			nodeStack.push(p);
			temp = str[i++];
		}
	}
}


void pre2tree(Node*& p, string str)//前缀表达式生成二叉树
{
	stack <Node*> nodeStack;
	char temp;
	int i = str.size() - 1;
	temp = str[i--];
	while (temp != '\0')
	{
		if (temp != '\0' && !isOper(temp))
		{
			p = new Node(temp);//以temp为内容来建立新的结点
			nodeStack.push(p);
			temp = str[i--];
		}
		else
		{
			p = new Node(temp);
			if (nodeStack.size())//栈非空
			{
				p->left = nodeStack.top(); //则栈顶指针所指结点设置成当前结点左孩子
				nodeStack.pop();
			}
			if (nodeStack.size())//栈非空
			{
				p->right = nodeStack.top();//则栈顶指针所指结点设置成当前结点右孩子
				nodeStack.pop();//栈顶元素左右孩子指针设置完毕弹出
			}
			nodeStack.push(p);
			temp = str[i--];
		}
	}
}
void in2tree(Node*& p, string str)//中缀表达式转换成后缀表达式生成二叉树
{
	stack<char> a;
	char temp;
	string Postfixexp = "";
	int i = 0;
	temp = str[i++];
	while (temp != '\0')
	{
		if (!isOper(temp))//操作数则直接进数据栈
		{
			Postfixexp += temp;
			temp = str[i++];
		}
		else if (temp == '(')//进栈
		{
			a.push(temp);
			temp = str[i++];
		}
		else if (temp == ')')
		{
			while (a.top() != '(')//脱括号
			{
				Postfixexp += a.top();
				a.pop();//在碰到开括号和栈为空前反复弹出栈中元素
			}
			a.pop();
			temp = str[i++];
		}
		else if (temp == '+' || temp == '-' || temp == '*' || temp == '/')//出栈
		{
			while (!a.empty() && a.top() != '(' && getOperOrder(a.top()) >= getOperOrder(temp))
				//若栈非空栈顶不是左括号且栈顶元素优先级不低于输入运算符时
			{
				Postfixexp += a.top(); a.pop();
			}
			a.push(temp);
			temp = str[i++];
		}
	}//end while(temp!='\0')
	while (!a.empty())
	{
		Postfixexp += a.top();
		a.pop();
	}
	Postfixexp += '\0';
	//cout<<Postfixexp;
	post2tree(p, Postfixexp);

}


void count(Node* p, int& height, int n) {//求树的高度
	if (p->left == NULL && p->right == NULL)
	{
		if (n > height)
			height = n;
	}
	if (p->left != NULL)
		count(p->left, height, n + 1);
	if (p->right != NULL)
		count(p->right, height, n + 1);
}

void paint(Node* p)//打印树
{
	int height = 0;
	int h = 0;
	int i;
	using std::queue;
	queue<Node*> aQueue;
	count(p, height, 1);
	Node* pointer = p;
	Node* lastpointer;
	if (pointer)
	{
		pointer->s = 1;
		pointer->t = 1;
		aQueue.push(pointer);
	}
	while (!aQueue.empty())
	{
		lastpointer = pointer;
		pointer = aQueue.front();
		aQueue.pop();
		if (pointer->s > h)
		{
			cout << endl;
			h = pointer->s;
		}
		if (pointer->t == 1)
		{
			for (i = 0; i < pow(2, height - pointer->s) - 1; i++)
				cout << " ";
		}
		else if (lastpointer->s != pointer->s) {
			for (i = 0; i < (pointer->t - 1) * (pow(2, height - pointer->s + 1) - 1) + (pointer->t - 1) - 1 + pow(2, height - pointer->s); i++)
				cout << " ";
		}
		else
		{
			for (i = 0; i < (pointer->t - lastpointer->t) * (pow(2, height - pointer->s + 1) - 1) + (pointer->t - lastpointer->t) - 1; i++)
				cout << " ";
		}
		cout << pointer->oper;
		if (pointer->left != NULL) {
			pointer->left->s = pointer->s + 1;
			pointer->left->t = pointer->t * 2 - 1;
			aQueue.push(pointer->left);
		}
		if (pointer->right != NULL) {
			pointer->right->s = pointer->s + 1;
			pointer->right->t = pointer->t * 2;
			aQueue.push(pointer->right);
		}
	}
}


int main()
{
	string expression;
	Node* tree;
	cout << "18074102 左帅 上机题三" << endl;
	cout << "请输入表达式类型 中缀0前缀1后缀2" << endl;
	int flag;
	cin >> flag;
	cout << "请输入表达式:" << endl;
	cin >> expression;

	if (flag == 1)//那么是前缀表达式
		pre2tree(tree, expression);
	else if (flag == 2)//那么是后缀表达式
		post2tree(tree, expression);
	else //否则中缀表达式
		in2tree(tree, expression);

	paint(tree);
	cout << endl;

	cout << "中缀表达式为";
	inOrder(tree);
	cout << endl;
	cout << "前缀表达式为";
	preOrder(tree);
	cout << endl;
	cout << "后缀表达式为";
	postOrder(tree);
	cout << endl;
	freeTree(tree);
	cout << endl;


	return 0;
}
