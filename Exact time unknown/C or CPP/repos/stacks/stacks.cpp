#include <iostream>
#include <stack>
using namespace std;
string transfer(string InfixExp) {
	string PostExp;
	stack<char>Simbols;
	int i;
	for (i = 0; i < InfixExp.size(); i++) {
		if (InfixExp[i] >= '0' && InfixExp[i] <= '9'){
			while (i < InfixExp.size()){
				if (InfixExp[i] >= '0' && InfixExp[i] <= '9') {
					PostExp.push_back(InfixExp[i]);
					i++;
				}
				else {
					PostExp.push_back(' ');
					break;
				}
			}
		}
		if (InfixExp[i] == '(') {
				Simbols.push(InfixExp[i]);
		}
		if (InfixExp[i] == '+' || InfixExp[i] == '-' || InfixExp[i] == '*' || InfixExp[i] == '/') {
			if (Simbols.empty() || Simbols.top() == '(')
				Simbols.push(InfixExp[i]);
			else {
				while (!Simbols.empty() && !((Simbols.top() == '+' && InfixExp[i] == '*') || (Simbols.top() == '+' && InfixExp[i] == '/') || (Simbols.top() == '-' && InfixExp[i] == '*') || (Simbols.top() == '-' && InfixExp[i] == '/'))) {
					if (Simbols.top() != '(') {
						PostExp.push_back(Simbols.top());
						Simbols.pop();
					}
					else
						break;
				}
				Simbols.push(InfixExp[i]);
			}
		}
		if (InfixExp[i] == ')') {
			while (!Simbols.empty() && Simbols.top() != '(') {
				PostExp.push_back(Simbols.top());
				Simbols.pop();
			}
			if (!Simbols.empty())
				Simbols.pop();
		}
	}
	while (!Simbols.empty()) {
		if(Simbols.top()!='(')
			PostExp.push_back(Simbols.top());
		Simbols.pop();
	}
	return PostExp;
}
double cac(string Exp) {
	stack<double>op;
	int i;
	int opt = 0;
	double op1, op2;
	for (i = 0; i < Exp.size(); i++) {
		if (Exp[i] >= '0' && Exp[i] <= '9') {
			while (i < Exp.size()) {
				if (Exp[i] >= '0' && Exp[i] <= '9') {
					opt = opt * 10 + (Exp[i] - 48);
					i++;
				}
				else {
					op.push(opt);
					opt = 0;
					break;
				}
			}
		}
		if (!op.empty() && (Exp[i] == '+' || Exp[i] == '-' || Exp[i] == '/' || Exp[i] == '*')) {
			op2= op.top();
			op.pop();
			if (!op.empty()) {
				op1 = op.top();
				op.pop();
			}
			else 
				return -1;
			switch(Exp[i]){ 
			case '+':op.push(op1 + op2); break;
			case '-':op.push(op1 - op2); break;
			case '*':op.push(op1 * op2); break;
			case '/':if (op2 != 0)
				op.push(op1 / op2);
					else
				return -1;
				break;
			}
		}
	}
	return op.top();
}
int main(){
	return 0;
}