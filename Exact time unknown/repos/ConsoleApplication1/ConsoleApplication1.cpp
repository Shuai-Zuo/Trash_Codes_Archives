#include <iostream>
using namespace std;
int main()
{
	int m, n, i, j, k, l = 0, f = 0;
	cin >> m >> n;
	for (i = 0; i < m; i++) {
		for (j = 0; j < n; j++) {
			if (l < n + 1)
				l++;
			else
				l = 0;
			f = 0;
			for (k = 0; k < ((2 * n - 1) * m + n - 1) / 2 + i * n + j; k++) {
				if (k < (((2 * n - 1) * m + n - 1) / 2 - i * n - j - 1)) {
					cout << " ";
				}
				else {
					if (f < 2 * l) {
						f++;
						cout << "*";
					}
					else {
						if (f < 2 * n)
							f = 0;
						cout << "2";
					}
				}
			}
			cout << endl;
		}
	}
//		2n-1*m+n-1
}
