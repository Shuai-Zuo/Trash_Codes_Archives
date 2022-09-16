#include <iostream>
#include <cstdlib>
#include <ctime> 
#include <windows.h>
//#define decknumber 15
//const long decknumber = 15;
using namespace std;
double gatya(long times);
double differenttime(SYSTEMTIME startTime);
long main() {
	long a;
	cout << "Please Enter Trial times:";
	cin >> a;
	srand((unsigned)time(NULL));
	SYSTEMTIME currentTime;
	GetSystemTime(&currentTime);
	cout << "The Expection is:" << gatya(a) << endl;
	cout << "Time used:" << differenttime(currentTime) << 's' << endl;
	return 0;
}

/*
double gatya(long times) {
	long megaminohiseki = 0;
	long i, j;
	long a;
	for (i = 0; i < times; i++) {
		for (j = 0; j < 9; j++){
			a = rand() % 200;
			if (a < 5)
				megaminohiseki += 50;
			else if (a < 41) 
				megaminohiseki += 10;
			else
				megaminohiseki += 1;
		}
		a = rand() % 200;
		if(a < 5)
			megaminohiseki += 50;
		else
			megaminohiseki += 10;
	}
	return (double)megaminohiseki/times;
}
*/

double gatya(long times) {
	int hoshi[3] = { 0 };
	long megaminohiseki = 0;
	long i, j;
	long a;
	for (i = 0; i < times; i++) {
		for (j = 0; j < 9; j++) {
			a = rand() % 200;
			if (a < 5)
				++hoshi[0];
			else if (a < 41)
				++hoshi[1];
			else
				++hoshi[2];
		}
		a = rand() % 200;
		if (a < 5)
			++hoshi[0];
		else
			++hoshi[1];
	}
	megaminohiseki = hoshi[0] * 50 + hoshi[1] * 10 + hoshi[2];
	return (double)megaminohiseki / times;
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