#include <stdio.h>
#include <stdlib.h>
#include <time.h>
char calculateVerifaction(char* str);
int isVerTrue(char* str);
int digs(int a);
char calculateVerifaction(char* str){
    int i, ver;
    int total = 0;
    int Coefficient[17] = {7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2};
    char Confusion[11] = {"10X98765432"};
    for(i=0;i<17;i++){
        total += Coefficient[i] * (str[i] - 48);
    }
    ver = total%11;
    return Confusion[ver];
}

int isVerTrue(char* str){
    if(calculateVerifaction(str) == str[17])
        return 1;
    else
        return 0;
}

int digs(int a){
	int length = 1;
	while (a /= 10){
		++length;
	}
	return length;
}