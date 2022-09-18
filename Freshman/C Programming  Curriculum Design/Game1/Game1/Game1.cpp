#include "pch.h"
#include <graphics.h>
#include <conio.h>
#include<math.h>
#include<stdio.h>
#include<stdlib.h>
#include<time.h>

#pragma comment(lib,"Winmm.lib")

#define WIDTH 1280 //resolution 1280x720
#define HEIGHT 720

#define PI 3.141592654
#define LINE (WIDTH*7/8)
#define BOTTONX1 (WIDTH*29/32)
#define BOTTONX2 (WIDTH*31/32)
#define BOTTONY (HEIGHT/32)// (1/32 to 3/32) (5/32 to 7/32) (9/32 to 11/32) (13/32 to 15/32)
#define BOTTONGAME (WIDTH/320)

typedef struct {
	char name[20];
	int score = 0;
	int life = 10;
	int lifeflag = 0;
}USERDATA;

typedef struct targetnode{
	int x;
	int y;
	char cal;
	int answer;
	int q1;
	int q2;
	char str[7];
	int pattern;
	int clicked;
	struct targetnode*next;
}TARNODE;

//绘图相关
TARNODE*init(IMAGE background);//初始化界面
void targetmove(TARNODE*tarnod, IMAGE background, IMAGE target[], IMAGE targett[], int mouseX, int mouseY, int answer, time_t start, USERDATA user);//主要绘图函数
void displayButton();//初始化按钮
void displayButton_Game(int chkbut, int press);//显示游戏区内按钮
void ChangeButton(int*flagStart, time_t*start);//切换暂停与继续按钮
void put_Lnode(TARNODE*h, IMAGE target[], IMAGE targett[], time_t start);//顺序检索链表,作putimage
void put_Once(TARNODE*h);//生成一遍链表储存的图片

//检测鼠标相关
int checkmouseposition_Botton(int mouseX, int mouseY);//检测鼠标坐标按钮 按钮区
int checkmouseposition_Game(int mouseX, int mouseY);//检测鼠标坐标按钮 游戏区
TARNODE*checkmouseposition_Target(int mouseX, int mouseY, TARNODE*h);//检测鼠标坐标按钮 目标

//链表相关
TARNODE*create(TARNODE*f);//生成链表(非头) 输入链表尾部,返回新的链表尾部
TARNODE*createhead(); //生成链表头,返回链表头
TARNODE*delete_out_of_bound_target(TARNODE*h, USERDATA*user);//清除出界目标
void freeAll(TARNODE*h);//清除全部链表
void reinitline(IMAGE background);//重新绘制边界线与背景
TARNODE*delete_on_target(TARNODE*d, TARNODE*h);//目标命中清除
TARNODE*findf(TARNODE*h);//寻找链表尾

//运行逻辑,文件
void logic(int flagmouse, int mouseX, int mouseY);//主体逻辑
void save(USERDATA user, TARNODE*h, time_t start);//保存
TARNODE*load(USERDATA*user, time_t*start);//载入
void savefile(char username[], int userscore,time_t start);//游戏结束生成计分板

//其他
void change_Text_style(int a, COLORREF color, int b);//改变字体颜色,字号,粗细
void BackgroundMusic();//设置BGM并调节音量
void createquestion(TARNODE*p);//生成题目
void welcome();//开始界面
void Game_Over();//结束

int main(void) {
	//Main Function
	TARNODE*h = NULL, *f = NULL;
	int mouseX=-1, mouseY=-1, flagmouse = 0;
	int answer = -1;
	MOUSEMSG mmsg;
	srand((unsigned)time(NULL));
	while (1)
	{
		while (MouseHit()) {//检测鼠标信息
			mmsg = GetMouseMsg();
			switch (mmsg.uMsg) {
			case WM_MOUSEMOVE:
				mouseX = mmsg.x;
				mouseY = mmsg.y;
				break;
			case WM_LBUTTONDOWN:
				flagmouse = 1;
				break;
			case WM_LBUTTONUP:
				flagmouse = 0;
				break;
			}
		}
		logic(flagmouse, mouseX, mouseY);//主体逻辑
	}
	Sleep(20);
}

TARNODE*init(IMAGE background)
{
	LOGFONT f;
	initgraph(WIDTH, HEIGHT);  //界面大小
	setbkcolor(WHITE);         //背景色
	welcome();
	cleardevice();             //清屏
	putimage(0, 0, &background);
	setcolor(BLUE);             //线颜色
	setlinestyle(PS_SOLID, 2);
	rectangle(1, 1, WIDTH - 1, HEIGHT - 1);  //最外侧线
	line(LINE, 0, LINE, HEIGHT);
	line(LINE, HEIGHT / 2, WIDTH, HEIGHT / 2);
	gettextstyle(&f);
	f.lfHeight = 16;
	_tcscpy_s(f.lfFaceName, "宋体");//设置字体
	f.lfQuality = ANTIALIASED_QUALITY;
	f.lfWeight = FW_NORMAL;
	settextstyle(&f);
	displayButton();
	BackgroundMusic();
	return createhead();
}

void displayButton()
{
	setfillcolor(RGB(128, 255, 255));
	change_Text_style(16, BLUE,400);
	setbkmode(TRANSPARENT);

	fillrectangle(BOTTONX1, BOTTONY, BOTTONX2, BOTTONY*3);
	outtextxy(BOTTONX1 * 59 / 58, BOTTONY * 1 + BOTTONY * 3 / 4, "开 始");

	fillrectangle(BOTTONX1, BOTTONY * 5, BOTTONX2, BOTTONY * 7);
	outtextxy(BOTTONX1 * 59 / 58, BOTTONY * 5 + BOTTONY * 3 / 4, "暂 停");

	fillrectangle(BOTTONX1, BOTTONY * 9, BOTTONX2, BOTTONY * 11);
	outtextxy(BOTTONX1 * 59 / 58, BOTTONY * 9 + BOTTONY * 3 / 4, "删 除");

	fillrectangle(BOTTONX1, BOTTONY * 13, BOTTONX2, BOTTONY * 15);
	outtextxy(BOTTONX1 * 59 / 58, BOTTONY * 13 + BOTTONY * 3 / 4, "退 出");

	fillrectangle(BOTTONX1, BOTTONY * 25, BOTTONX2, BOTTONY * 27);
	outtextxy(BOTTONX1 * 59 / 58, BOTTONY * 25 + BOTTONY * 3 / 4, "载 入");

	fillrectangle(BOTTONX1, BOTTONY * 29, BOTTONX2, BOTTONY * 31);
	outtextxy(BOTTONX1 * 59 / 58, BOTTONY * 29 + BOTTONY * 3 / 4, "保 存");

	displayButton_Game(0,0);


	//fillrectangle(100, GAME_HEIGHT + 10, 150, GAME_HEIGHT + 50);
	//outtextxy(110, GAME_HEIGHT + 20, "退出");
}

void displayButton_Game(int chkbut,int press) {
	{
		static int flagload = 0;
		static IMAGE bullet[3];
		if (flagload == 0) {
			loadimage(bullet, "Image\\bullet_c.jpg");
			loadimage(bullet + 1, "Image\\bullet_uc.jpg");
			loadimage(bullet + 2, "Image\\bullet_trans.jpg");
			flagload = 1;
		}
		int bulletn=1;
		setfillcolor(RGB(128, 255, 255));//press与chkbut分别表示是否被按下与是否在相应区域内
		change_Text_style(40, RED, 900);
		setbkmode(TRANSPARENT);
		if (press == 3) {
			setfillcolor(RGB(0, 200, 200));
			bulletn = 0;
		}
		else if(chkbut==3)
			setfillcolor(RGB(0, 255, 255));
		else
			setfillcolor(RGB(128,255,255));
		clearrectangle(BOTTONGAME * 63, HEIGHT * 9 / 12, BOTTONGAME * 105, HEIGHT * 11 / 12);
		fillrectangle(BOTTONGAME * 63, HEIGHT * 9 / 12, BOTTONGAME * 105, HEIGHT * 11 / 12);
		putimage(BOTTONGAME * 63 + 50, HEIGHT * 9 / 12+15, bullet+2, SRCAND);
		putimage(BOTTONGAME * 63 + 50, HEIGHT * 9 / 12 + 15, bullet+bulletn, SRCINVERT);
		bulletn = 1;
		outtextxy(BOTTONGAME * 63 + 30, HEIGHT * 9 / 12 + 30, "3");
		if (press == 4) {
			setfillcolor(RGB(0, 200, 200));
			bulletn = 0;
		}
		else if (chkbut == 4)
			setfillcolor(RGB(0, 255, 255));
		else
			setfillcolor(RGB(128, 255, 255));
		clearrectangle(BOTTONGAME * 119, HEIGHT * 9 / 12, BOTTONGAME * 161, HEIGHT * 11 / 12);
		fillrectangle(BOTTONGAME * 119, HEIGHT * 9 / 12, BOTTONGAME * 161, HEIGHT * 11 / 12);
		putimage(BOTTONGAME * 119 + 50, HEIGHT * 9 / 12 + 15, bullet + 2, SRCAND);
		putimage(BOTTONGAME * 119 + 50, HEIGHT * 9 / 12 + 15, bullet + bulletn, SRCINVERT);
		bulletn = 1;
		outtextxy(BOTTONGAME * 119 + 30, HEIGHT * 9 / 12 + 30, "4");
		if (press == 5) {
			setfillcolor(RGB(0, 200, 200));
			bulletn = 0;
		}
		else if (chkbut == 5)
			setfillcolor(RGB(0, 255, 255));
		else
			setfillcolor(RGB(128, 255, 255));
		clearrectangle(BOTTONGAME * 175, HEIGHT * 9 / 12, BOTTONGAME * 217, HEIGHT * 11 / 12);
		fillrectangle(BOTTONGAME * 175, HEIGHT * 9 / 12, BOTTONGAME * 217, HEIGHT * 11 / 12);
		putimage(BOTTONGAME * 175 + 50, HEIGHT * 9 / 12 + 15, bullet + 2, SRCAND);
		putimage(BOTTONGAME * 175 + 50, HEIGHT * 9 / 12 + 15, bullet + bulletn, SRCINVERT);
		bulletn = 1;
		outtextxy(BOTTONGAME * 175 + 30, HEIGHT * 9 / 12 + 30, "5");
		if (press == 6) {
			setfillcolor(RGB(0, 200, 200));
			bulletn = 0;
		}
		else if (chkbut == 6)
			setfillcolor(RGB(0, 255, 255));
		else
			setfillcolor(RGB(128, 255, 255));
		clearrectangle(BOTTONGAME * 231, HEIGHT * 9 / 12, BOTTONGAME * 273, HEIGHT * 11 / 12);
		fillrectangle(BOTTONGAME * 231, HEIGHT * 9 / 12, BOTTONGAME * 273, HEIGHT * 11 / 12);
		putimage(BOTTONGAME * 231 + 50, HEIGHT * 9 / 12 + 15, bullet + 2, SRCAND);
		putimage(BOTTONGAME * 231 + 50, HEIGHT * 9 / 12 + 15, bullet + bulletn, SRCINVERT);
		bulletn = 1;
		outtextxy(BOTTONGAME * 231 + 30, HEIGHT * 9 / 12 + 30, "6");
	}
}

void ChangeButton(int*flagStart,time_t*start)
{
	static time_t continueTime;//计算暂停持续的时间,并修改start
	setfillcolor(RGB(128, 255, 255));
	change_Text_style(16, BLUE, 400);
	setbkmode(TRANSPARENT);
	clearrectangle(BOTTONX1, BOTTONY * 5, BOTTONX2, BOTTONY * 7);
	fillrectangle(BOTTONX1, BOTTONY * 5, BOTTONX2, BOTTONY * 7);
	if (*flagStart == 0)
	{
		outtextxy(BOTTONX1 * 59 / 58, BOTTONY * 5 + BOTTONY * 3 / 4, "继 续");
		*flagStart = 1;
		continueTime = time(NULL);
	}
	else if (*flagStart == 1)
	{
		outtextxy(BOTTONX1 * 59 / 58, BOTTONY * 5 + BOTTONY * 3 / 4, "暂 停");
		*flagStart = 0;
		*start = *start + (time(NULL) - continueTime);
	}
}

void targetmove(TARNODE*tarnod,IMAGE background, IMAGE target[], IMAGE targett[],int mouseX, int mouseY,int answer,time_t start,USERDATA user) {
		//static float mov_x = 0, mov_y = 0;
		int chkbut;
		IMAGE target_img1;
		static IMAGE aim,aimt;
		static int flagload=0;
		char Scostr[10],str[10],Lifstr[10];
		if (flagload == 0) {
			loadimage(&aimt, "Image\\Aim_trans.jpg");//鼠标
			loadimage(&aim, "Image\\Aim.png");
			flagload = 1;
		}
		getimage(&target_img1, LINE, 0, WIDTH, HEIGHT);
		if (mouseX > BOTTONGAME * 63 && mouseX <= BOTTONGAME * 273 && mouseY > HEIGHT * 9 / 12 && mouseY <= HEIGHT * 11 / 12) {
			chkbut = checkmouseposition_Game(mouseX, mouseY);
		}
		else {
			chkbut = -1;
		}
		_itoa_s(user.score, Scostr, 10);
		_itoa_s(user.life, Lifstr, 10);
		BeginBatchDraw();//开始批量绘图
		reinitline(background);
		put_Lnode(tarnod, target,targett,start);
		displayButton_Game(chkbut,answer);
		putimage(mouseX - 40, mouseY - 40, &aim, SRCAND);
		putimage(mouseX - 40, mouseY - 40, &aimt, SRCINVERT);
		sprintf_s(str, "%d", (int)(time(NULL)-start));//将时间转换为char*
		putimage(LINE, 0, &target_img1);
		change_Text_style(16, BLACK, 400);
		clearrectangle(LINE + 80, HEIGHT / 2 + 40, WIDTH - 2, HEIGHT / 2 + 120);
		outtextxy(LINE + 80, HEIGHT / 2 + 40, Scostr);
		outtextxy(LINE + 80, HEIGHT / 2 + 70, str);
		outtextxy(LINE + 80, HEIGHT / 2 + 100, Lifstr);
		line(WIDTH - 1, 1, WIDTH - 1, HEIGHT - 1);
		EndBatchDraw();//结束
		if (user.life == 0) {
			savefile(user.name, user.score, start);
			Game_Over();
			_getch();
			exit(0);
		}
}

TARNODE*create(TARNODE*f)
{
	TARNODE *p;
		p = (TARNODE*)malloc(sizeof(TARNODE));
		p->next = NULL;
		p->x = 0;
		p->y = 0;
		p->pattern = rand() % 3;
		p->clicked = 0;
		createquestion(p);
		f->next = p;
		f = p;
	return f;
}

TARNODE*createhead()
{
	TARNODE *h;
	h = (TARNODE*)malloc(sizeof(TARNODE));
	h->next = NULL;
	h->x = 0;
	h->y = 0;
	h->pattern = rand() % 3;
	h->clicked = 0;
	createquestion(h);
	return h;
}

void createquestion(TARNODE*p) {
	p->answer = rand() % 4 + 3;
	switch (rand() % 4) {
	case 0:p->cal = '+';
		p->q2 = rand() % (p->answer - 1) + 1;
		p->q1 = p->answer - p->q2;
		p->str[0] = '0' + p->q1;
		p->str[1] = ' ';
		p->str[2] = p->cal;
		p->str[3] = ' ';
		p->str[4] = '0' + p->q2;
		p->str[5] = '\0';
		break;
	case 1:p->cal = '-';
		p->q2 = p->q2 = rand() % 9 + 1;
		p->q1 = p->answer + p->q2;
		if (p->q1 < 10) {
			p->str[0] = '0' + p->q1;
			p->str[1] = ' ';
			p->str[2] = p->cal;
			p->str[3] = ' ';
			p->str[4] = '0' + p->q2;
			p->str[5] = '\0';
		}
		else {
			p->str[0] = '0' + p->q1 / 10;
			p->str[1] = '0' + p->q1 % 10;
			p->str[2] = ' ';
			p->str[3] = p->cal;
			p->str[4] = ' ';
			p->str[5] = '0' + p->q2;
			p->str[6] = '\0';
		}
		break;
	case 2:p->cal = '*';
		switch (p->answer) {
		case 3:
			p->q1 = (int)(1.5*(rand() % 2 + 1));
			p->q2 = 3 / p->q1;
			break;
		case 4:
			p->q1 = rand() % 2 + 1;
			p->q2 = 4 / p->q1;
			break;
		case 5:
			if (rand() % 2 == 0) {
				p->q1 = 5;
				p->q2 = 1;
			}
			else {
				p->q1 = 1;
				p->q2 = 5;
			}
			break;
		case 6:
			p->q1 = rand() % 3 + 1;
			p->q2 = 6 / p->q1;
			break;
		}
		p->str[0] = '0' + p->q1;
		p->str[1] = ' ';
		p->str[2] = p->cal;
		p->str[3] = ' ';
		p->str[4] = '0' + p->q2;
		p->str[5] = '\0';
		break;
	case 3:
		p->cal = '/';
		p->q2 = p->q2 = rand() % 9 + 1;
		p->q1 = p->answer * p->q2;
		if (p->q1 < 10) {
			p->str[0] = '0' + p->q1;
			p->str[1] = ' ';
			p->str[2] = p->cal;
			p->str[3] = ' ';
			p->str[4] = '0' + p->q2;
			p->str[5] = '\0';
		}
		else {
			p->str[0] = '0' + p->q1 / 10;
			p->str[1] = '0' + p->q1 % 10;
			p->str[2] = ' ';
			p->str[3] = p->cal;
			p->str[4] = ' ';
			p->str[5] = '0' + p->q2;
			p->str[6] = '\0';
		}
		break;
	}
}

void welcome(){
	IMAGE start;
	loadimage(&start, "Image\\start.jpg");
	putimage(0, 0, &start);
	_getch();
}

void Game_Over() {
	IMAGE start;
	loadimage(&start, "Image\\End.jpg");
	putimage(0, 0, &start);
	_getch();
}

void put_Lnode(TARNODE*h, IMAGE target[],IMAGE targett[],time_t start)
{
	TARNODE*p = NULL;
	int a , temp;
	p = h;
	temp = (int)(time(NULL) - start) / 10 + 1;
	if (temp > 100) {
		a = 100;
	}
	else {
		a = temp;
	}
	while (p != NULL)
	{
		//当牌子运动时，若曲线运动,可视为满足函数 y = Asin(ωx) ω= π/7S  s=Screen_x/16
		p->y = (int)(25 * sin(p->x * (PI / (WIDTH / 16 * 7))));
		p->x += a;
		putimage(WIDTH * 7 / 8 - p->x, p->y + 35, targett + p->pattern, SRCAND);
		putimage(WIDTH * 7 / 8 - p->x, p->y + 35, target + p->pattern,SRCINVERT);
		change_Text_style(30, RGB(240, 100, 75),800);
		setbkmode(TRANSPARENT);
		outtextxy(WIDTH * 7 / 8 - p->x + 50, p->y + 92, p->str);
		//outtextxy(WIDTH * 7 / 8 - p->x + 30, p->y + 35,'0'+ p->answer);
		p = p->next;
	}
}

int checkmouseposition_Botton(int mouseX, int mouseY)
{
	if(mouseX >= BOTTONX1 && mouseX <= BOTTONX2 && mouseY >= BOTTONY && mouseY <= BOTTONY * 3)
		return 1; //开始
	else if(mouseX >= BOTTONX1 && mouseX <= BOTTONX2 && mouseY >= BOTTONY * 5 && mouseY <= BOTTONY * 7)
		return 2; //暂停
	else if(mouseX >= BOTTONX1 && mouseX <= BOTTONX2 && mouseY >= BOTTONY * 9 && mouseY <= BOTTONY * 11)
		return 3; //删除
	else if(mouseX >= BOTTONX1 && mouseX <= BOTTONX2 && mouseY >= BOTTONY * 13 && mouseY <= BOTTONY * 15)
		return 4; //退出
	else if(mouseX >= BOTTONX1 && mouseX <= BOTTONX2 && mouseY >= BOTTONY * 25 && mouseY <= BOTTONY * 27)
		return 5; //载入
	else if (mouseX >= BOTTONX1 && mouseX <= BOTTONX2 && mouseY >= BOTTONY * 29 && mouseY <= BOTTONY * 31)
		return 6; //保存
	else return -1;
}

int checkmouseposition_Game(int mouseX, int mouseY){
	if (mouseX >= BOTTONGAME * 63 && mouseX <= BOTTONGAME * 105 && mouseY >= HEIGHT * 9 / 12 && mouseY <= HEIGHT * 11 / 12)
		return 3; //3
	else if (mouseX >= BOTTONGAME * 119 && mouseX <= BOTTONGAME * 161 && mouseY >= HEIGHT * 9 / 12 && mouseY <= HEIGHT * 11 / 12)
		return 4; //4
	else if (mouseX >= BOTTONGAME * 175 && mouseX <= BOTTONGAME * 217 && mouseY >= HEIGHT * 9 / 12 && mouseY <= HEIGHT * 11 / 12)
		return 5; //5
	else if (mouseX >= BOTTONGAME * 231 && mouseX <= BOTTONGAME * 273 && mouseY >= HEIGHT * 9 / 12 && mouseY <= HEIGHT * 11 / 12)
		return 6; //6
	else
		return -1;
}

TARNODE*checkmouseposition_Target(int mouseX, int mouseY, TARNODE*h) {
	TARNODE*p = h;
	while (p != NULL)
	{
		if (mouseX >= WIDTH * 7 / 8 - p->x && mouseX <= WIDTH * 7 / 8 - p->x +180&& mouseY >= p->y+35 && mouseY <= p->y + 155/* && p->answer == answer*/) {
			return p;
		}
		p = p->next;
	}
		return NULL;
}

TARNODE*delete_out_of_bound_target(TARNODE*h,USERDATA*user) {
	TARNODE*p = NULL;
	//char Scostr[10];
	if (h->x >= WIDTH*7/8+180) {
		p = h;
		h = h->next;
		free(p);
		user->score -= 50;
		user->life -= 1;
		//clearrectangle(LINE + 80, HEIGHT / 2 + 40, WIDTH , HEIGHT / 2 + 60);
		//_itoa_s(*score, Scostr, 10);
		//change_Text_style(16, BLACK, 400);
		//outtextxy(LINE + 80, HEIGHT / 2 + 40, Scostr);
		//line(WIDTH - 1, 1, WIDTH - 1, HEIGHT - 1);
	}
	return h;
}

void freeAll(TARNODE*h)
{
	TARNODE*p = h, *q;
	while (p != NULL)
	{
		q = p->next;
		free(p);
		p = q;
	}
}

void reinitline(IMAGE background) {
	putimage(0, 0, &background);
	line(LINE, 0, LINE, HEIGHT);
	rectangle(1, 1, WIDTH - 1, HEIGHT - 1);
}

TARNODE*delete_on_target(TARNODE*d, TARNODE*h)
{
	TARNODE*f, *p;
	if (h != NULL) {
		if (d == h) {
			h = h->next;
			free(d);
			return h;
		}
		else {
			f = h;
			p = f;
			while (f != d) {
				p = f;
				f = f->next;
			}
			f = f->next;
			free(d);
			p->next = f;
			return h;
		}
	}
	return NULL;
}

TARNODE * findf(TARNODE * h)
{
	TARNODE*f = h;
	while (f != NULL&&f->next!=NULL) {
		f = f->next;
	}
	return f;
}

void logic(int flagmouse, int mouseX,int mouseY){
	TARNODE*chk;
	static USERDATA user;
	static TARNODE*h = NULL, *f = NULL;
	static IMAGE background, target[3], target_trans[3];
	static IMAGE aim, aimt;
	static int flag = -1, flagStart = -1, flagpause, flagload = 0, flagpress = 0, flagtime = 0;
	static int answer=0;
	static time_t start;
	//char Scostr[10];
	if (flagload == 0) {
		loadimage(&background, "Image\\Background1280x720.png");
		loadimage(target, "Image\\bear.jpg");
		loadimage(target + 1, "Image\\duck.jpg");
		loadimage(target + 2, "Image\\eagle.jpg");
		loadimage(target_trans, "Image\\bear_trans.jpg");
		loadimage(target_trans + 1, "Image\\duck_trans.jpg");
		loadimage(target_trans + 2, "Image\\eagle_trans.jpg");
		loadimage(&aimt, "Image\\Aim_trans.jpg");
		loadimage(&aim, "Image\\Aim.png");
		h=init(background);
		change_Text_style(16, BLACK, 400);
		outtextxy(LINE + 20, HEIGHT / 2 + 10, "Name: ");
		outtextxy(LINE + 20, HEIGHT / 2 + 40, "Score: ");
		outtextxy(LINE + 20, HEIGHT / 2 + 70, "Time: ");
		outtextxy(LINE + 80, HEIGHT / 2 + 40, "0");
		outtextxy(LINE + 80, HEIGHT / 2 + 70, "0");
		outtextxy(LINE + 20, HEIGHT / 2 + 100, "Life; ");
		outtextxy(LINE + 80, HEIGHT / 2 + 100, "10");
		InputBox(user.name, 20, "请输入用户名：");
		if (user.name[0] == '\0')
			sprintf_s(user.name, "null");
		outtextxy(LINE + 70, HEIGHT / 2 + 10, user.name);
		f = h;
		flagload = 1;
	}
	if (flagmouse == 1) {
		if (mouseX > LINE && mouseX <= WIDTH && mouseY > 0 && mouseY <= HEIGHT) {
			flagpause = flag;
			flag = checkmouseposition_Botton(mouseX, mouseY);
			if (flag == -1) {
				flag = flagpause;
			}
		}
		if (mouseX > BOTTONGAME * 63 && mouseX <= BOTTONGAME * 273 && mouseY > HEIGHT * 9 / 12 && mouseY <= HEIGHT * 11 / 12) {
			answer = checkmouseposition_Game(mouseX, mouseY);
		}
		if (mouseX > 0 && mouseX <= LINE && mouseY > 0 && mouseY <= HEIGHT * 9 / 12) {
			chk = checkmouseposition_Target(mouseX, mouseY, h);
			if (chk != NULL) {
				change_Text_style(16, BLACK, 400);
				if (chk->answer != answer) {
					if (chk->clicked == 0&&answer!=0) {
						user.life -= 1;
						user.score -= 25;
						chk->clicked = 1;
					}
				}
				else {
					h = delete_on_target(chk, h);
					user.score += 100;
					f = findf(h);
				}
				//clearrectangle(LINE + 80, HEIGHT / 2 + 40, WIDTH - 2, HEIGHT / 2 + 60);
				//_itoa_s(user.score, Scostr, 10);
				//outtextxy(LINE + 80, HEIGHT / 2 + 40, Scostr);
				//line(WIDTH - 1, 1, WIDTH - 1, HEIGHT - 1);
			}
		}
	}
	else flagpress = 0;
	if (flagpress == 0) {
		flagpress = 1;
		switch (flag)
		{
		case 1:
			if (flagStart != 1) {
				if (flagStart != 0)
					if(flagtime==0)
						start = time(NULL);
					flagStart = 0;
				if (h == NULL) {
					h = createhead();
					f = h;
				}
				if (f->x > LINE / 4)
					f = create(f);

				if ((time(NULL) - start) % 10 == 0 && (time(NULL) - start) / 10 > user.lifeflag) {
					user.life += 5;
					user.lifeflag += 1;
				}
				targetmove(h, background, target, target_trans, mouseX, mouseY,answer,start,user);
				h = delete_out_of_bound_target(h,&user);
			}
			break;
		case 2:
			if (flagStart != -1) {
				ChangeButton(&flagStart,&start);
				flag = 1;
			}
			break;
		case 3:
			if (flagStart != -1) {
				freeAll(h);
				h = NULL;
				if (flagStart == 0)
					ChangeButton(&flagStart, &start);
				BeginBatchDraw();
				putimage(0, 0, &background);
				displayButton_Game(0, 0);
				EndBatchDraw();
				flag = 1;
			}
			break;
		case 4:
			savefile(user.name, user.score,start);
			freeAll(h);
			exit(0);
			break;
		case 5:
			if (flagStart != -1) {
				freeAll(h);
				h = load(&user, &start);
				f = findf(h);
				if (flagStart == 1)
					ChangeButton(&flagStart, &start);
				flagStart = -1;
				flagtime = 1;
				flag = -1;
			}
			else {
				h = load(&user, &start);
				f = findf(h);
				flagtime = 1;
			}
			break;
		case 6:
			if (flagStart != -1) {
				flag = 1;
				save(user, h, start);
			}
			break;
		}
	}
	else{
		if (flagStart == 0) {
			if (h == NULL) {
				h = createhead();
				f = h;
			}
			if (f->x > LINE / 4)
				f = create(f);
			if ((time(NULL) - start) % 10 == 0 && (time(NULL) - start) / 10 > user.lifeflag) {
				user.life += 5;
			}
			targetmove(h, background, target, target_trans, mouseX, mouseY,answer,start,user);
			h = delete_out_of_bound_target(h,&user);
		}
	}
}

void change_Text_style(int a,COLORREF color,int b) {
	LOGFONT f;
	gettextstyle(&f);
	f.lfWeight = b;
	f.lfHeight = a;
	settextstyle(&f);
	settextcolor(color);
}

void save(USERDATA user, TARNODE*h, time_t start) {
	TARNODE*p = NULL;
	FILE*fp;
	p = h;
	fopen_s(&fp, "save.txt", "w");
	while (p != NULL)
	{
		fprintf(fp, "> %d %d %d %s %d", p->x, p->y, p->pattern, p->str, p->answer);
		p = p->next;
	}
	fprintf(fp, "e %d ", (int)(time(NULL) - start));
	fprintf(fp, "%d %d %d%s", user.life, user.lifeflag, user.score, user.name);
	fclose(fp);
}

TARNODE*load(USERDATA*user, time_t*start) {
	TARNODE*h,*p,*f=NULL;
	int a;
	char chk;
	char Scostr[10],str[10], Lifstr[10];
	h = createhead();
	p = h;
	f = h;
	FILE*fp;
	IMAGE background, get_img;
	loadimage(&background, "Image\\Background1280x720.png");
	fopen_s(&fp, "save.txt", "r");
	if (fp != NULL) {
		fscanf_s(fp, "%c", &chk, sizeof(char));
		while (chk == '>') {
			fscanf_s(fp, "%d%d%d%d %c", &p->x, &p->y, &p->pattern, &p->q1, &p->cal, 4*sizeof(int)+sizeof(char));
			fscanf_s(fp, "%d%d", &p->q2, &p->answer);
			fscanf_s(fp, "%c", &chk, sizeof(char));
			sprintf_s(p->str, "%d %c %d", p->q1, p->cal, p->q2);
			if (chk == '>') {
				f = create(f);
				p->next = f;
				p = f;
			}
		}
		fscanf_s(fp, "%d", &a);
		*start = time(NULL) - a;
		fscanf_s(fp, "%d%d%d", &user->life ,&user->lifeflag ,&user->score);
		fgets(user->name, 10, fp);
		BeginBatchDraw();
		getimage(&get_img, LINE, 0, WIDTH, HEIGHT/2);
		putimage(0, 0, &background);
		displayButton_Game(0, 0);
		put_Once(h);
		change_Text_style(16, BLACK, 400);
		clearrectangle(LINE + 80, HEIGHT / 2 + 40, WIDTH - 2, HEIGHT / 2 + 120);
		change_Text_style(16, BLACK, 400);
		outtextxy(LINE + 70, HEIGHT / 2 + 10, user->name);
		_itoa_s(user->score, Scostr, 10);
		outtextxy(LINE + 80, HEIGHT / 2 + 40, Scostr);
		_itoa_s(a, str, 10);
		outtextxy(LINE + 80, HEIGHT / 2 + 70, str);
		_itoa_s(user->life, Lifstr, 10);
		outtextxy(LINE + 80, HEIGHT / 2 + 100, Lifstr);
		putimage(LINE, 0, &get_img);
		line(WIDTH - 1, 1, WIDTH - 1, HEIGHT - 1);
		EndBatchDraw();
		fclose(fp);
	}

	return h;
}

void savefile(char username[], int userscore,time_t start) {
	FILE*fp;
	fopen_s(&fp, "score.txt", "a");
	fprintf(fp, "\nusername:%s    score:%d    Time:%d", username, userscore,(int)(time(NULL) - start));
	fclose(fp);
}

void put_Once(TARNODE*h){
	IMAGE target[3], target_trans[3];
	TARNODE*p = NULL;
	p = h;
	loadimage(target, "Image\\bear.jpg");
	loadimage(target + 1, "Image\\duck.jpg");
	loadimage(target + 2, "Image\\eagle.jpg");
	loadimage(target_trans, "Image\\bear_trans.jpg");
	loadimage(target_trans + 1, "Image\\duck_trans.jpg");
	loadimage(target_trans + 2, "Image\\eagle_trans.jpg");
	while (p != NULL)
	{
		putimage(WIDTH * 7 / 8 - p->x, p->y + 35, target_trans + p->pattern, SRCAND);
		putimage(WIDTH * 7 / 8 - p->x, p->y + 35, target + p->pattern, SRCINVERT);
		change_Text_style(30, RGB(240, 100, 75), 800);
		setbkmode(TRANSPARENT);
		outtextxy(WIDTH * 7 / 8 - p->x + 42, p->y + 80, p->str);
		p = p->next;
	}
}

void BackgroundMusic() {
	TCHAR cmd[256];
	TCHAR volume[256]; 
	int nVolume; 	
	mciSendString(_T("open Music\\qiisanaboukensha.mp3 alias music"), NULL, 0, NULL);
	wsprintf(cmd, "status %s volume", "music");
	mciSendString(cmd, volume, sizeof(volume), 0); 
	nVolume = atoi(volume);
	wsprintf(cmd, "setaudio %s volume to %i", "music", nVolume - 900); 
	mciSendString(cmd, NULL, 0, NULL);
	mciSendString(_T("play music repeat"), NULL, 0, NULL);
}