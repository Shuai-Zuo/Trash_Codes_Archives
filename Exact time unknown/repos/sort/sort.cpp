#include <iostream>   
using namespace std;
typedef struct {
	int data;
	int keys[8];
	int next;
}ListNode;
//静态链表结构
typedef struct {
	ListNode r[10000];
	int keynum;
	int recnum;
} SList;

typedef int  ArrType[10];
void Distribute(ListNode* r, int i, ArrType f, ArrType e) {
	int j;
	//初始化指针数组
	for (j = 0; j < 10; j++) {
		f[j] = 0;
	}
	//遍历各个关键字
	int p;
	for (p = r[0].next; p; p = r[p].next) {
		int j = r[p].keys[i];//取出每个关键字的第 i 位
		if (!f[j]) {//如果只想该位数字的指针不存在
			f[j] = p;
		}
		else {//如果存在，说明之前已经有同该关键字相同位的记录，所以需要将其进行连接，将最后一个相同的关键字的next指针指向该关键字所在的位置，同时最后移动尾指针的位置。
			r[e[j]].next = p;
		}
		e[j] = p;//移动尾指针的位置
	}
}
void Collect(ListNode* r, int i, ArrType f, ArrType e) {
	int j;
	//从 0 开始遍历，查找头指针不为空的情况，为空表明该位没有该类型的关键字
	for (j = 0; !f[j]; j++);
	r[0].next = f[j];//重新设置头结点
	int t = e[j];//找到尾指针的位置
	while (j < 10) {
		for (j++; j < 10; j++) {
			if (f[j]) {
				r[t].next = f[j];//重新连接下一个位次的首个关键字
				t = e[j];//t代表下一个位次的尾指针所在的位置
			}
		}
	}
	r[t].next = 0;//0表示链表结束
}
void RadixSort(SList* L) {
	ArrType f, e;
	int i;
	//根据记录中所包含的关键字的最大位数，一位一位的进行分配与收集
	for (i = 0; i < L->keynum; i++) {
		//秉着先分配后收集的顺序
		Distribute(L->r, i, f, e);
		Collect(L->r, i, f, e);
	}
}
//创建静态链表
void creat(SList* L,int*a,int size) {
	int key, i = 1, j;
	cin>>key;
	a[0] = key;
	for (int k = 1; k <= size;k++) {
		L->r[i].data = key;
		for (j = 0; j <= L->keynum; j++) {
			L->r[i].keys[j] = key % 10;
			key /= 10;
		}
		L->r[i - 1].next = i;
		if (k != size) {
			cin >> key;
			a[i] = key;
			i++;
		}
	}
	L->recnum = i;
	L->r[L->recnum].next = 0;
}
//输出静态链表
void printL(SList* L) {
	int p;
	for (p = L->r[0].next; p; p = L->r[p].next) {
		cout<<L->r[p].data<<' ';
	}
	cout<<endl;
}
void swap(int& a, int& b)
{
	int temp = a;
	a = b;
	b = temp;
}

int Partition(int a[], int low, int high)
{
	int pivotValue = a[high];
	int i = low - 1;
	for (int j = low; j <= high - 1; j++)
	{
		if (a[j] <= pivotValue)
		{
			i = i + 1;
			swap(a[i], a[j]);
		}
	}
	swap(a[i + 1], a[high]);
	return i + 1;
}

void QuickSort(int a[], int left, int right)
{
	if (left < right)
	{
		int pivotPos = Partition(a, left, right);
		QuickSort(a, left, pivotPos - 1);
		QuickSort(a, pivotPos + 1, right);
	}
}

void HeapAdjust(int* a, int i, int size)  //调整堆 
{
	int lchild = 2 * i;       //i的左孩子节点序号 
	int rchild = 2 * i + 1;     //i的右孩子节点序号 
	int max = i;
	if (i <= size / 2)          //如果i不是叶节点就不调整 
	{
		if (lchild <= size && a[lchild] > a[max])
			max = lchild;
		if (rchild <= size && a[rchild] > a[max])
			max = rchild;
		if (max != i)
		{
			swap(a[i], a[max]);
			HeapAdjust(a, max, size);    //避免调整之后以max为父节点的子树不是堆 
		}
	}
}

void BuildHeap(int* a, int size)    //建立堆 
{
	int i;
	for (i = size / 2; i >= 1; i--)    //非叶节点最大序号值为size/2 
		HeapAdjust(a, i, size);
}

void HeapSort(int* a, int size)    //堆排序 
{
	int i;
	BuildHeap(a, size);
	for (i = size; i >= 1; i--)
	{
		swap(a[1], a[i]);           //交换堆顶和最后一个元素，即每次将剩余元素中的最大者放到最后面 
		HeapAdjust(a, 1, i - 1);      //重新调整堆顶节点成为大顶堆
	}
	for (i = 0; i < size; i++) {
		if (a[i] > a[i + 1]) {
			swap(a[i], a[i+1]);
		}
	}
}


void print(int array[],int size)
{
	for (int i = 0; i <= size - 1; i++)
		cout<<array[i]<<' ';
	cout<<endl;
}

int main()
{
	int num, t;
	int a1[10000];
	int a2[10000];
	int A[10000];
	cout << "请输入序列长度：";
	cin >> num;
	SList* L = new SList;
	L->keynum = 3;
	L->recnum = 0;

	//for (int i = 0; i < num; i++) {
	//	cin >> t;
	//	A[i] = t;
	//}
	cout << "请输入序列：";
	creat(L, A, num);//创建静态链表
	for (int i = 0; i < num; i++) {
		a1[i] = A[i];
		a2[i] = A[i];
	}
	cout << "快速排序：";
	QuickSort(a1, 0, num - 1);
	print(a1,num);
	cout << "-----------------------" << endl;
	cout << "堆排序：";
	HeapSort(a2, num - 1);
	print(a2,num);
	cout << "-----------------------" << endl;
	RadixSort(L);
	cout << "基数排序：";
	printL(L);
	return 0;
}
