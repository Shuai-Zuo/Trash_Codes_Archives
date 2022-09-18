#include <windows.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
double differenttime(SYSTEMTIME startTime);
int main() {
	double a;
	SYSTEMTIME currentTime;
	GetSystemTime(&currentTime);
	Sleep(3151);
	printf_s("%d",differenttime(currentTime));
	return 0;
}



double differenttime(SYSTEMTIME startTime) {
	SYSTEMTIME currentTime;
	GetSystemTime(&currentTime);
	double sta, cur;
	sta = (long)startTime.wHour * (double)3600 + (long)startTime.wMinute * (double)60 + (long)startTime.wSecond + (double)startTime.wMilliseconds / 1000.0;
	cur = (long)currentTime.wHour * (double)3600 + (long)currentTime.wMinute * (double)60 + (long)currentTime.wSecond + (double)currentTime.wMilliseconds / 1000.0;
	if (sta > cur) {
		return -1.0;
	}
	else return cur - sta;
}