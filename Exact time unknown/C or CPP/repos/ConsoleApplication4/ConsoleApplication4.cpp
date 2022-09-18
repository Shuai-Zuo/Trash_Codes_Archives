#include "stdio.h"
#include<math.h>
int main()
{
	FILE* f;
	double a[15][15], l[15][15], y[15], b[15], x[15];
	double s;
	int i, j, k, n;
	f = fopen("sqrt.txt", "r");
	fscanf(f, "%d", &n);
	for (i = 1; i <= n; i++)
	{
		for (j = 1; j <= i; j++)
		{
			fscanf(f, "%lf", &a[i][j]);
		}
		fscanf(f, "%lf", &b[i]);
	}
	fclose(f);
	for (i = 1; i <= n; i++)
	{
		for (j = 1; j <= i - 1; j++)
		{
			for (s = 0, k = 1; k <= j - 1; k++)
				s += l[i][k] * l[j][k];
			l[i][j] = (a[i][j] - s) / l[j][j];//分解公式第二步
		}
		s = 0;
		for (s = 0, k = 1; k <= i - 1; k++)
			s += l[i][k] * l[i][k];
		l[i][i] = sqrt(a[i][i] - s);//分解公式第一步
	}
	for (i = 1; i <= n; i++)
	{
		for (j = 1; j <= i; j++)
			printf("%lf  ", l[i][j]);
		printf("\n");
	}
	for (i = 1; i <= n; i++)
	{
		for (s = 0, k = 1; k <= i - 1; k++)
			s += l[i][k] * y[k];
		y[i] = (b[i] - s) / l[i][i];
	}
	for (i = n; i >= 1; i--)
	{
		for (s = 0, k = i + 1; k <= n; k++)
			s += l[k][i] * x[k];
		x[i] = (y[i] - s) / l[i][i];
	}
	for (i = 1; i <= n; i++)
		printf("x[%d]=%lf\n", i, x[i]);
}