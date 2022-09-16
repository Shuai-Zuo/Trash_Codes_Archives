
#include <iostream>
using namespace std;

const int Cutoff = 28;  //阈值，当子序列元素个数小于Cutoff时，采用简单排序(在快排中)
const int RADIX = 10;  //进制数
const int MaxDigit = 4;  //单个元素所具有的的最大位数

//桶元素节点
struct Node
{
	int key;  //待排数据
	struct Node* next;  //指向下一个桶节点的指针
};
//桶头节点
struct HeadNode
{
	struct Node* head, * tail;
};
typedef struct HeadNode Bucket[RADIX];

template <class T>
class Sort
{
private:
	Bucket B;  //桶
	T* A;  //存放堆元素的数组
	int N;  //堆中的元素个数

public:
	Sort(int InputSize);  //构造函数
	~Sort() { delete[] A; cout << "析构函数执行成功" << endl; }  //析构函数

	//堆排序
	void HeapSort();  //堆排序
	void PercDown(int p, int N);  //将N个元素的数组中以A[p]为根的子堆调整为最大堆

	//快速排序
	void QuickSort(int Left, int Right);  //递归进行快排
	T Median3(int Left, int Right);  //选主原（轴值）- 取头、中、尾的中位数
	void InsertSort(T* B, int Nb);  //当子序列元素个数小于阈值时调用插入排序

	//基数排序
	int GetDigit(int X, int D);  //获得当前元素的当前位
	void LSD_RadixSort();  //基于次位优先的基数排序

	void Print();  //输出堆中的元素
	friend void Swap(T* a, T* b);  //交换堆顶和堆末尾的元素 - 友元函数类似于全局函数
};

//Sort类的实现
//Sort(int InputSize) - 构造函数
template <class T> Sort<T>::Sort(int InputSize)
{
	this->N = InputSize;  //this指当前对象
	this->A = new T[N];  //为数组分配空间
	for (int i = 0; i < N; ++i)
		cin >> A[i];
}

//Swap(T,T) - 交换两个元素
template <class T> void Swap(T* a, T* b)
{
	int tmp;
	tmp = *a;
	*a = *b;
	*b = tmp;
}

//Print()
template <class T> void Sort<T>::Print()
{
	for (int i = 0; i < N; ++i)
		cout << A[i] << " ";
	cout << endl;
}

//堆排序
template <class T> void Sort<T>::HeapSort()
{
	int i;
	//for循环中的语句是针对从下标为0的位置开始存放的情况 
	//该最大堆的建立是从完全二叉树的倒数第二层开始的 
	for (i = N / 2 - 1; i >= 0; i--)   //建立最大堆
		PercDown(i, N);
	for (i = N - 1; i > 0; i--)
	{
		//删除最大堆顶
		Swap(&A[0], &A[i]);  //将堆顶元素放到堆末尾，并且堆的规模减1 
		PercDown(0, i);  //将规模减小的堆再一次调整为最大堆 
	}
}

//将N个元素的数组中以A[p]为根的子堆调整为最大堆
//最大堆的建立不是一步到位的
//先调整其左、右子树，一步一步上滤
template <class T> void Sort<T>::PercDown(int p, int N)
{
	int parent, child;
	int x;

	x = A[p];      //取出根节点存放的值
	for (parent = p; (parent * 2 + 1) < N; parent = child)
	{
		child = parent * 2 + 1;
		if ((child != N - 1) && (A[child] < A[child + 1]))
			child++;   //child指向左右子节点的最大值
		if (x > A[child]) break;   //找到了合适的位置
		else        //下滤x
			A[parent] = A[child];
	}
	A[parent] = x;
}

//插入排序
template <class T> void Sort<T>::InsertSort(T* B, int Nb)
{
	int tmp, p, i;
	for (p = 1; p < Nb; ++p)  //总共摸取Nb-1张牌
	{
		tmp = B[p];  //当前摸到手中的一张牌
		for (i = p; i > 0 && A[i - 1] > tmp; i--)  //i很多情况下都是用来控制循环次数的
		{
			A[i] = A[i - 1];
		}
		A[i] = tmp;  //新牌归位
	}
}

//选轴值pivot
template <class T>  T Sort<T>::Median3(int Left, int Right)
{
	int Center = (Left + Right) / 2;

	if (A[Left] > A[Center])
		Swap(&A[Left], &A[Center]);
	if (A[Left] > A[Right])
		Swap(&A[Left], &A[Right]);
	if (A[Center] > A[Right])
		Swap(&A[Center], &A[Right]);
	//此时A[Left] <= A[Center] <= A[Right],为了接下来的分割过程，将轴值藏到右边
	//将轴值藏到子序列的右端只是为了不影响分割过程
	//分割时只需考虑A[Left+1] - A[Right-2]的区间
	Swap(&A[Center], &A[Right - 1]);
	//返回轴值
	return A[Right - 1];
}

//递归分割
template <class T> void Sort<T>::QuickSort(int Left, int Right)
{
	int Pivot, Low, High;  //基准、左、右指针

	if (Cutoff < Right - Left)  //如果序列元素充分多，则进入快排
	{
		Pivot = Median3(Left, Right);
		Low = Left;
		High = Right - 1;

		//分割过程
		while (true)
		{
			while (A[++Low] < Pivot);
			while (A[--High] > Pivot);
			if (Low < High)
				Swap(&A[Low], &A[High]);
			else
				break;
		}
		//将当前子序列的轴值一次性的放到他最终所在的位置上 - Low
		Swap(&A[Low], &A[Right - 1]);
		//当前子序列分割完成，递归进入更小一层子序列的分割
		QuickSort(Left, Low - 1);  //递归解决左边子序列
		QuickSort(Low + 1, Right);  //递归解决右边子序列
	}
	else
		InsertSort(A + Left, Right - Left + 1);  //当子序列足够短时，采用插入排序
}

//获得当前元素的当前位
template <class T> int Sort<T>::GetDigit(int X, int D)
{
	int d, i;
	for (i = 1; i <= D; ++i)
	{
		d = X % RADIX;  //求余
		X /= RADIX;  //缩小RADIX倍
	}

	return d;
}

//基于次位优先的基数排序
template <class T> void Sort<T>::LSD_RadixSort()
{
	int D, Di, i;  //D、Di - 当前位、i - 计数变量
	struct Node* tmp, * p, * List = NULL;  //初始链表表头List，采用头插法

										 //初始化每个桶为空链表
	for (i = 0; i < RADIX; ++i)
		B[i].head = B[i].tail = NULL;

	//List就是用来存储数组元素的链表
	//List采用头插法生成链表
	for (i = 0; i < N; ++i)
	{
		tmp = new Node;
		tmp->key = A[i];
		tmp->next = List;
		List = tmp;
	}

	//下面次用次位优先的方法对数据进行排序
	for (D = 1; D <= MaxDigit; ++D)
	{
		//下面是分配的过程,用p来暂时接管这趟排序用到的List链表
		p = List;
		while (p)  //当链表不为空
		{
			Di = GetDigit(p->key, D);  //获得当前元素的当前位
									   //从List中摘除，从list链表头拿走一个节点 
									   //这里的摘除只是从p链表中摘除，但是最初的List链表一直到在
									   //因为List要经历一次又一次的扫描，直到最高位 
			tmp = p;
			p = p->next;
			//插入B[Di]号桶尾,这里又采用尾插法
			tmp->next = NULL;
			if (B[Di].head == NULL)  //无头节点、链表为空
				B[Di].head = B[Di].tail = tmp;
			else
			{
				B[Di].tail->next = tmp;  //原先的尾节点连接上新加入进来的节点
				B[Di].tail = tmp;  //更新尾节点
			}
		}
		//一趟排序完成，下面扫描桶中的元素生成新的List链表
		List = NULL;
		for (Di = RADIX - 1; Di >= 0; --Di)
		{
			//这里建立的List链表也是采用头插法，倒着插
			if (B[Di].head)  //如果当前桶不为空
			{
				//将整桶插入List表头
				B[Di].tail->next = List;
				List = B[Di].head;  //更新表头
				B[Di].head = B[Di].tail = NULL;  //清空桶
			}
		}
	}

	//将List倒入A[]并释放空间
	for (i = 0; i < N; ++i)
	{
		tmp = List;
		List = List->next;
		A[i] = tmp->key;
		delete tmp;  //释放空间
		tmp = NULL;  //避免野指针
	}
}

int main()
{
	int QN, RN, HN;

	//快速排序
	cin >> QN;
	Sort<int> Q(QN);
	Q.QuickSort(0, QN - 1);
	cout << "快速排序：";
	Q.Print();

	//基数排序
	cin >> RN;
	Sort<int> R(RN);
	R.LSD_RadixSort();
	cout << "基数排序：";
	R.Print();

	//堆排
	cin >> HN;
	Sort<int> H(HN);
	H.HeapSort();
	cout << "堆排序：";
	H.Print();

	return 0;
}