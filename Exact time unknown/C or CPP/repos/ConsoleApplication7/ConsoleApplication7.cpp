#include <iostream>

int main()
{
    std::cout << "Hello World!\n";
}

void Josephus(int A[], int n, int  s, int m) {
	int i, j, k, tmp; 
	if (m == 0) { 
		std::cout << "m = 0 是无效的参数！" << std::endl;
		return;
	} 
	for (i = 0; i < n; i++)
		A[i] = i + 1; //初始化，执行 n 次 
	i = s - 1; //报名起始位置 
	for ( k = n; k > 1; i-- ) { //逐个出局，执行 n-1 次 
		if ( i == k ) i = 0; i = ( i + m - 1 ) % k; //寻找出局位置 
		if ( i != k-1 ) { tmp = A[i]; //出局者交换到第 k-1 位置 
		for ( j = i; j < k-1; j++ ) 
			A[j] = A[j+1]; A[k-1] = tmp; 
		}
	} 
	for ( k = 0; k < n / 2; k++ ) { //全部逆置, 得到出局序列 
		tmp = A[k]; 
		A[k] = A[n-k+1]; 
		A[n-k+1] = tmp;
	} 
}
