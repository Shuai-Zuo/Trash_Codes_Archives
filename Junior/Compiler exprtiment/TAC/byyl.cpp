#include<stdio.h>
#include<string.h>
#include<stdlib.h>
#include<ctype.h>
#include<fstream>
#include<list>

using namespace std;
//宏定义种别码
enum Tag
{
	IF = 256, THEN, ELSE, DO, WHILE, ID, INT10, INT8, INT16, END
};
//定义属性值联合
union values
{
	int intvalue; //整数
	char charvalue[20]; //字符
};
//二元组
typedef struct SYMBOL
{
	int kind; //种别码
	values value; //属性值
}symbol;
//表达式
struct Expr
{
	char opt;
	int place;
	static int count;
	Expr(char opt) :opt(opt)
	{
		place = count++;
	}
	virtual void code()
	{
		//printf("%c T%d\n",opt,place);
	}
};
int Expr::count = 0;
// 条件表达式
struct Cond :Expr
{
	int True, False;
	Expr* E1, * E2;
	Cond(char opt, Expr* E1, Expr* E2) :Expr(opt), E1(E1), E2(E2) {}
	virtual void code()
	{
		// C.code = E1.code || E2.code || code(‘ if’ E1.place’ >’ E2.place’ goto’ C.true) ||code(‘ goto’ C.false);
		E1->code();
		E2->code();
		printf("if T%d %c T%d goto L%d\n", E1->place, opt, E2->place, True);
		printf("goto L%d\n", False);
	}
};
// 算术表达式
struct Arith :Expr
{
	Expr* E1, * E2;
	Arith(char opt, Expr* E1, Expr* E2) :Expr(opt), E1(E1), E2(E2) {}
	virtual void code()
	{
		E1->code();
		E2->code();
		printf("T%d :=T%d %c T%d\n", place, E1->place, opt, E2->place);
	}
};
// ID
struct Id :Expr
{
	symbol* s;
	Id(symbol* s) :Expr('@'), s(s)
	{ }
	virtual void code()
	{
		if (s->kind == ID)
		{
			printf("T%d:=%s\n", place, s->value.charvalue);
		}
		else
		{
			printf("T%d:=%d\n", place, s->value.intvalue);
		}
	}
};
//语句
struct Stmt
{
	int begin, next;
	static int label;
	static int newlabel()
	{
		return label++;
	}
	virtual void code()
	{}
};
//语句块
struct Stmts :Stmt
{
	list<Stmt*> Ss;
	virtual void code()
	{
		list<Stmt*>::iterator iter;
		for (iter = Ss.begin(); iter != Ss.end(); iter++)
		{
			(*iter)->code();
		}
	}
};
int Stmt::label = 0;
struct Assign :Stmt
{
	Id* E1;
	Expr* E2;
	virtual void code()
	{
		E2->code();
		printf("%s := T%d\n", E1->s->value.charvalue, E2->place);
	}
};
struct If :Stmt
{
	Cond* C;
	Stmt* S1;
	virtual void code()
	{
		// C.true = newlabel; C.false = S.next;S1.next = S.next
		next = newlabel();
		C->True = newlabel();
		C->False = next;
		S1->next = next;
		// S.code = C.code || code(C.true’ :’ ) || S1.code
		C->code();
		printf("L%d:\n", C->True);
		S1->code();
		printf("L%d:\n", next);
	}
};
struct While :Stmt
{
	Cond* C;
	Stmt* S1;
	virtual void code()
	{
		// S.begin=newlabel; C.true = newlabel; C.false = S.next;S1.next = S.begin;
		begin = newlabel();
		next = newlabel();
		C->True = newlabel();
		C->False = next;
		S1->next = begin;
		// S.code = code(S.begin’ :’ ) || C.code || code(E.true’ :’ ) || S1.code ||code(‘ goto’ S.begin);
		printf("L%d:\n", begin);
		C->code();
		printf("L%d:\n", C->True);
		S1->code();
		printf("goto L%d\n", begin);
		printf("L%d:\n", next);
	}
};
symbol* s;
ifstream inf;// 文件输入流
// 词法分析器
//判断是关键字还是标识符
symbol* keyWordOrId(char* word)
{
	symbol* s = new symbol();
	if (strcmp(word, "if") == 0) {
		s->kind = IF;
		sprintf(s->value.charvalue, "if");
	}
	else if (strcmp(word, "then") == 0) {
		s->kind = THEN;
		sprintf(s->value.charvalue, "then");
	}
	else if (strcmp(word, "do") == 0) {
		s->kind = DO;
		sprintf(s->value.charvalue, "do");
	}
	else if (strcmp(word, "while") == 0) {
		s->kind = WHILE;
		sprintf(s->value.charvalue, "while");
	}
	else if (strcmp(word, "else") == 0) {
		s->kind = ELSE;
		sprintf(s->value.charvalue, "else");
	}
	else {
		//不是关键字,就是标识符
		s->kind = ID;
		sprintf(s->value.charvalue, word);
	}
	return s;
}
//16 进制整数转换成 10 进制整数
int hexToDec(char word[20])
{
	char* str;
	int l = strtol(word, &str, 16);
	return l;
}
//8 进制整数转换成 10 进制整数
int octToDec(char word[20])
{
	char* str;
	int l = strtol(word, &str, 8);
	return l;
}
// 词法分析器
symbol* scan()
{
	int i = 0;
	char ch; //读入字符
	char word[20]; //存放构成单词的字符串
	symbol* result = new symbol();
	do
	{
		inf.read(&ch, sizeof(ch));
	} while (ch == ' ' || ch == '\n' || ch == '\t');//判断是否是空格,回车或 tab，如果是则跳过
//判断输入流是否空
	if (ch == 10)
	{
		result->kind = END;
		return result;
	}
	//判断是否是标识符
	if (isalpha(ch))
	{
		do
		{
			word[i++] = ch;
			inf.read(&ch, sizeof(ch));
		} while (isalnum(ch)); //1 状态
		word[i] = '\0';
		inf.seekg(-1, ios::cur);//回退一个字符
		result = keyWordOrId(word);//判断是关键字还是标识符
		return result;
	}
	//判断是否是 integer
	if (isdigit(ch))
	{
		//2，6，7 状态
		if (ch == '0')
		{
			word[i] = ch;
			i++;
			inf.read(&ch, sizeof(ch));
			//十六进制整数, 8 状态
			if (ch == 'x' || ch == 'X')
			{
				word[i] = ch;
				i++;
				inf.read(&ch, sizeof(ch));
				//9 状态
				if (isdigit(ch) || (ch >= 'a' && ch <= 'f') || (ch >= 'A' && ch <= 'F'))
				{
					do
					{
						word[i++] = ch;
						inf.read(&ch, sizeof(ch));
					} while (isdigit(ch) || (ch >= 'a' && ch <= 'f') || (ch >= 'A' && ch <= 'F'));
					inf.seekg(-1, ios::cur);//回退一个字符
					word[i] = '\0';
					result->kind = INT16;
					result->value.intvalue = hexToDec(word);
					return result;
				}
				else
				{
					printf("错误的十六进制!");//回退，报错
				}
			}
			else if (ch >= '0' && ch <= '7')
			{
				//八进制整数,3 状态
				do
				{
					word[i++] = ch;
					inf.read(&ch, sizeof(ch));
				} while (ch >= '0' && ch <= '7');
				inf.seekg(-1, ios::cur);//回退一个字符
				word[i] = '\0';
				result->kind = INT8;
				result->value.intvalue = octToDec(word);
				return result;
			}
			else
			{
				//十进制整数 0
				inf.seekg(-1, ios::cur);//回退一个字符
				word[i] = '\0';
				result->kind = INT10;
				result->value.intvalue = octToDec(word);
				return result;
			}
		}
		else
		{
			//除 0 外十进制整数,5 状态
			do
			{
				word[i++] = ch;
				inf.read(&ch, sizeof(ch));
			} while (isdigit(ch));
			inf.seekg(-1, ios::cur);//回退一个字符
			word[i] = '\0';
			result->kind = INT10;
			result->value.intvalue = atoi(word); //转换成整型数
			return result;
		}
	}
	else
	{
		//判断运算符，分隔符
		word[i] = ch;
		i++;
		word[i] = '\0';
		switch (ch)
		{
		case '+':sprintf(result->value.charvalue, "add"); break;
		case '-':sprintf(result->value.charvalue, "sub"); break;
		case '*':sprintf(result->value.charvalue, "mul"); break;
		case '/':sprintf(result->value.charvalue, "div"); break;
		case '<':sprintf(result->value.charvalue, "<"); break;
		case '>':sprintf(result->value.charvalue, ">"); break;
		case '=':sprintf(result->value.charvalue, "="); break;
		case '(':sprintf(result->value.charvalue, "("); break;
		case ')':sprintf(result->value.charvalue, ")"); break;
		case ';':sprintf(result->value.charvalue, ";"); break;
		default:sprintf(result->value.charvalue, "%c", ch); break;
		}
		result->kind = ch;
		return result;
	}
}
// 匹配 kind并预读一个词法单元
bool match(int kind)
{
	if (s->kind == kind)
	{
		s = scan();
		return true;
	}
	s = scan();
	//printf("%s not matched.\n", kind);
	return false;
}
// 语法分析器
Stmt* S();
Stmt* A();
Stmt* I();
Stmt* W();
Cond* C();
Expr* E();
Expr* T();
Expr* F();
//S->id=E;|if C thenS|while C do S
Stmt* S()
{
	Stmt* st = NULL;
	switch (s->kind)
	{
	case ID:st = A(); break;
	case IF:st = I(); break;
	case WHILE:st = W(); break;
	default:match(s->kind); break;
	}
	return st;
}
//A->ID=E
Stmt* A()
{
	Assign* a = new Assign;
	//printf("S->id = E;\n");
	a->E1 = new Id(s);
	match(ID);
	match('=');
	a->E2 = E();
	match(';');
	return a;
}
//I->if C thenS
Stmt* I()
{
	If* i = new If;
	//printf("S->if C then S\n");
	match(IF);
	i->C = C();
	match(THEN);
	i->S1 = S();
	return i;
}
//W->while C do S
Stmt* W()
{
	While* w = new While;
	/*printf("S->while C do S\n");*/ match(WHILE);
	w->C = C();
	match(DO);
	w->S1 = S();
	return w;
}
//C->E(>|<|=)E
Cond* C()
{
	//printf("C->E\n");
	Expr* e = E();
	if (s->kind == '<' || s->kind == '>' || s->kind == '=')
	{
		char opt = s->kind;
		match(s->kind);
		Expr* r = E();
		//printf("C->C %c E\n", opt);
		return new Cond(opt, e, r);
	}
	return NULL;
}
//E->T[(+|-)T]*
Expr* E()
{
	//printf("E->T\n");
	Expr* e = T();
	while (s->kind == '+' || s->kind == '-')
	{
		char opt = s->kind;
		match(s->kind);
		//printf("E->T%c T\n", opt);
		Expr* r = T();
		e = new Arith(opt, e, r);
	}
	return e;
}
//T->F[(*|/)F]^*
Expr* T()
{
	//printf("T->F\n");
	Expr* e = F();
	while (s->kind == '*' || s->kind == '/')
	{
		char opt = s->kind;
		match(s->kind);
		//printf("T->F%c F\n", opt);
		Expr* r = F();
		e = new Arith(opt, e, r);
	}
	return e;
}
//F->(E)|id|int8|int10|int16
Expr* F()
{
	Expr* e = NULL;
	switch (s->kind)
	{
	case '(':/* printf("F->(E)\n");*/ match('('); e = E(); match(')'); break;
	case ID: /*printf("F->ID\n");*/ e = new Id(s); match(ID); break;
	case INT8: /*printf("F->INT8\n");*/ e = new Id(s); match(INT8); break;
	case INT10: /*printf("F->INT10\n");*/ e = new Id(s); match(INT10); break;
	case INT16: /*printf("F->INT16\n");*/ e = new Id(s); match(INT16); break;
	default: /*printf("F->('%c')\n", s->kind);*/ match(s->kind); break;
	}
	return e;
}
// 主程序
int main()
{
	char c;
	inf.open(".\\test.txt", ios::in);
	if (!inf.is_open())
	{
		//printf("openfile failed");
		c = getchar();
		return 1;
	}
	//printf("openfile successfully\n");
	Stmts sts;
	Stmt* st;
	//printf("start parsing.\n");
	s = scan();
	printf("%d",s->kind);
	// 预读一个词法单元，以便启动语法分析
	while (s->kind != END)
	{
		st = S();
		if (st)sts.Ss.push_back(st);
	}
	//printf("parsing finished.\n");
	sts.code();
	//printf("press any key to end.\n");
	//c = getchar();
	inf.close();
}
