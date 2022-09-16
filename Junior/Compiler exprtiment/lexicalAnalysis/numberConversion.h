#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include <math.h>

int indexOf(char *input, char findC)
{
    int length = strlen(input);
    int pos = -1;
    int i;
    for (i = 0; i < length; i++)
	if (input[i] == findC)
	{
	    pos = i;
	    break;
	}	
    return pos;
}


int HexToDec(char *input)
{
    int num = 0;
    int length = strlen(input);
    int i, j;
    for (i = length-1, j = 0; i >= 2; i--, j++)
    {
        if (input[i] >= '0' && input[i] <= '9')
	    num += (input[i]-'0')*pow(16, j);
	else if (input[i] >= 'a' && input[i] <= 'f')
	    num += (input[i]-'a'+10)*pow(16, j);
	else if (input[i] >= 'A' && input[i] <= 'F')
	    num += (input[i]-'A'+10)*pow(16, j);
    }
    return num;
}

int OctToDec(char *input)
{
    int num = 0;
    int length = strlen(input);
    int i, j;
    for (i = length-1, j = 0; i >= 1; i--, j++)
	num += (input[i]-'0')*pow(8, j);
    return num;
}

int PutDec(char *input)
{
    int num = 0;
    int length = strlen(input);
    int i, j;
    for (i = length-1, j = 0; i >= 0; i--, j++)
        num += (input[i]-'0')*pow(10, j);
    return num;
}

double HexRealToDecReal(char *input)
{
    double num = 0;
    int length = strlen(input);
    int indexOfPoint = indexOf(input, '.');
    int i, j;
    for (i = indexOfPoint-1, j = 0; i >= 2; i--, j++)
    {
        if (input[i] >= '0' && input[i] <= '9')
            num += (input[i]-'0')*pow(16, j);
        else if (input[i] >= 'a' && input[i] <= 'f')
            num += (input[i]-'a'+10)*pow(16, j);
        else if (input[i] >= 'A' && input[i] <= 'F')
            num += (input[i]-'A'+10)*pow(16, j);
    }
    for (i = indexOfPoint+1, j = 1; i < length; i++, j++)
    {
        if (input[i] >= '0' && input[i] <= '9')
            num += (input[i]-'0')*pow(0.0625, j);
        else if (input[i] >= 'a' && input[i] <= 'f')
            num += (input[i]-'a'+10)*pow(0.0625, j);
        else if (input[i] >= 'A' && input[i] <= 'F')
            num += (input[i]-'A'+10)*pow(0.0625, j);
    }
    return num;
}

double OctRealToDecReal(char *input)
{
    double num = 0;
    int length = strlen(input);
    int indexOfPoint = indexOf(input, '.');
    int i, j;
    for (i = indexOfPoint-1, j = 0; i >= 1; i--, j++)
	num += (input[i]-'0')*pow(8, j);
    for (i = indexOfPoint+1, j = 1; i < length; i++, j++)
	num += (input[i]-'0')*pow(0.125, j);
    return num;
}

double PutDecReal(char *input)
{
    double num = 0;
    int length = strlen(input);
    int indexOfPoint = indexOf(input, '.');
    int i, j;
    for (i = indexOfPoint-1, j = 0; i >= 0; i--, j++)
        num += (input[i]-'0')*pow(10, j);
    for (i = indexOfPoint+1, j = 1; i < length; i++, j++)
        num += (input[i]-'0')*pow(0.1, j);
    return num;

}
