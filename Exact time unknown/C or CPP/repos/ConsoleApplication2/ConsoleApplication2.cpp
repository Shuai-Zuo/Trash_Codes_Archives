#include <iostream>
#include <cstdlib>
#include <ctime> 
#include <windows.h>
//#define decknumber 15
//const int decknumber = 15;
using namespace std;
int draw(int times);
void shuffle(int deck[]);
double differenttime(SYSTEMTIME startTime);
int main(){
	int a;
	cout << "Please Enter Trial times:";
	cin >> a;
	srand((unsigned)time(NULL));
	SYSTEMTIME currentTime;
	GetSystemTime(&currentTime);
	cout << "The percentage is:" << (double)draw(a) * 100 / a << '%' << endl;
	cout << "Time used:" << differenttime(currentTime) << 's' << endl;
	return 0;
}


int draw(int times) {
	const int decknumber = 15;
	int deck[decknumber];
	int i/*, j*/;
	int counter = 0;
	for (i = 0; i < times; i++) {
		shuffle(deck);
		if (deck[0] == 1 && deck[1] == 1 && deck[2] == 1) {
			counter++;
		}
		/*
		for (j = 0; j < decknumber; j++) {
			cout << deck[j] << "  ";
		}
		cout << endl;
		*/
	}
	return counter;
}

void shuffle(int deck[]) {
	const int decknumber = 15;
	int i, j;
	int a;
	int temp;
	for (i = 0; i < decknumber; i++) {
		deck[i] = 0;
	}
	for (i = 0; i < 3; i++) {
		a = rand() % (decknumber - 2 + i);
		for (j = a; j < decknumber - 3 + i; j++) {
			temp = deck[j + 1];
			deck[j + 1] = deck[a];
			deck[a] = temp;
		}
		deck[a] = 1;
	}
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