
#include <iostream>
#include <time.h>
#include <vector>
#include <windows.h>
using namespace std;

const int base = 100;
const int unnormal_seeds = 10;
const char normal = 'x';
const char unnormal = 'o';
int search[8] = { 0,1,2,3,5,6,7,8 };

vector<vector<char>> elements(base);

void init_elements() {
	for (int i = 0; i < base; i++) {
		for (int j = 0; j < base; j++)
			elements[i].push_back(normal);
	}
}

void cout_elements() {
	for (int i = 0; i < base; i++) {
		for (int j = 0; j < base; j++) {
			if (elements[i][j] == unnormal)
				SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), FOREGROUND_INTENSITY | FOREGROUND_GREEN);
			cout << elements[i][j] << ' ';
			SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), FOREGROUND_INTENSITY);
		}
		cout << endl;
	}
	cout << endl;
}

void set_unnormal(int seeds) {
	srand((unsigned)time(NULL));
	int x, y;
	for (int i = 0; i < seeds; i++) {
		x = rand() % 100;
		y = rand() % 100;
		elements[x][y] = unnormal;
		if (x > 0)elements[x - 1][y] = unnormal;
		if (x < base - 1)elements[x + 1][y] = unnormal;
		if (y > 0)elements[x][y - 1] = unnormal;
		//if(y < base-1)elements[x][y+1] = unnormal;
	}
}

void unnormal_rule() {
	vector<vector<char>> temp = elements;
	int count;
	for (int i = 1; i < base - 1; i++) {
		for (int j = 1; j < base - 1; j++) {
			count = 0;
			for (int k = 0; k < 8; k++) {
				count += temp[i - 1 + search[k] / 3][j - 1 + search[k] % 3] == unnormal ? 1 : 0;
			}
			if (count == 3) elements[i][j] = unnormal;
			else if (count < 2) elements[i][j] = normal;
			else if (count > 3) elements[i][j] = normal;
		}
	}
}

int main()
{
	//cout << "...hello secret...\n";
	SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), FOREGROUND_INTENSITY);

	CONSOLE_CURSOR_INFO console_cursor_info;
	console_cursor_info.bVisible = false;
	console_cursor_info.dwSize = 100;

	HANDLE hConsole = GetStdHandle(STD_OUTPUT_HANDLE);
	SetConsoleCursorInfo(hConsole, &console_cursor_info);
	COORD coordScreen = { 0, 0 };

	init_elements();
	set_unnormal(unnormal_seeds);
	cout_elements();
	int n = 500;

	while (n--) {
		unnormal_rule();
		SetConsoleCursorPosition(hConsole, coordScreen);
		cout_elements();
		cout << "Left times: " << n << endl;
		srand((unsigned)time(NULL));
		int p = rand() % 5;
		if (p == 0) set_unnormal(1);
	}


	return 0;
}