#include<iostream>
using namespace std;
int vis[500];
typedef struct LNode
{
	int data;
	struct LNode* next;
}LNode, * LinkList;

int jose(int n, int m, int s);
void Jose2(int n, int s, int m);

int main() {
	int n, s, m,i;
	cout << "18074102 左帅 上机题1" << endl;
	cin >> n>> s>> m;
	cout << "顺序存储" << endl;
	jose(n, m, s);
	cout<< endl;
	for (i = 0; i < 500; i++)
		vis[i] = 0;
	cout << "链式存储" << endl;
	Jose2(n, m, s);
	return 0;
}


int jose(int n, int m,int s) {
	int cnt = 0, dead = 0, i = s;
	cout << i << ' ';
	while (dead <= n) {
		i++;
		if (i > n) i = 1;  //当计数超过n时，需要回到1
		if (!vis[i]) cnt++;  //报数是只有没有出列的人才能报数
		if (cnt == m) {   //报数时报到m的人需要出列
			cnt = 0;   //下一轮需要从0开始报数
			dead++;    //出列的人个数
			cout << i << ' ';
			vis[i] = 1;  //标记其已经出列
			if (dead == n) //当第n个人出列时，它就是安全的
				break;
		}
	}
	return 0;
}

void Jose2(int n, int s, int m){
	LinkList p, r, list = NULL;
	int i;
	//建立一个循环链表
	for (i = 0; i < n; i++){
		p = (LinkList)malloc(sizeof(LNode));
		p->data = i + 1;        //存放第i个结点的编号
		if (list == NULL)
			list = p;
		else
			r->next = p;
		r = p;
	}
	p->next = list;

	p = list;
	for (i = 1; i < s; i++){
		r = p;
		p = p->next;
	}//此时p指向第1个出发结点

	cout << "出列次序为：";
	while (p->next != p){
		for (i = 1; i < m; i++){
			r = p;
			p = p->next;
		}                    //p指向第m个结点,r指向第m-1个结点
		r->next = p->next;     //删除第m个结点
		cout << p->data << " ";
		delete p;
		p = r->next;
	}
	cout << p->data;
	cout << endl;
}
