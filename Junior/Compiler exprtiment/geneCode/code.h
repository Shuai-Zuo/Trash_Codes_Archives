#ifndef CP_H
#define CP_H

#include <stdio.h>
#include <string.h>
#include <malloc.h>

typedef struct listele //链表元素
{
    int instrno;
    struct listele *next;
}listele;

listele* new_listele(int no) //新建链表元素
{
    listele* p = (listele*)malloc(sizeof(listele));
    p->instrno = no;
    p->next = NULL;
    return p;
}

typedef struct instrlist//链表
{
    listele *first,*last;
}instrlist;

instrlist* makelist(int instrno)
    {
        instrlist* p = (instrlist*)malloc(sizeof(instrlist));
        p->first = p->last = new_listele(instrno);
        return p;
    }

instrlist* merge(instrlist *list1, instrlist *list2)//合并两个链表 并返回合并后的链表指针
{
    instrlist *p;
    if (list1 == NULL) p = list2;
    else
    {
        if (list2!=NULL)
        {
            if (list1->last == NULL)
            {
                list1->first = list2->first;
                list1->last =list2->last;
            }else list1->last->next = list2->first;
            list2->first = list2->last = NULL;
            free(list2);
        }
        p = list1;
    }
    return p;
}

typedef struct node//结点
{
    instrlist *truelist, *falselist, *nextlist;
    char addr[256];//地址
    char lexeme[256];//
    char oper[3];//操作
    int quad;
}node;

int filloperator(node *dst, char *src)
{
    strcpy(dst->oper, src);
    return 0;
}    
int filllexeme(node *dst, char *yytext)
{
    strcpy(dst->lexeme, yytext);
    return 0;
}
int copyaddr(node *dst, char *src)
{
    strcpy(dst->addr, src);
    return 0;
}
int new_temp(node *dst, int index)
{
    sprintf(dst->addr, "t%d", index);
    return 0;
}
int copyaddr_fromnode(node *dst, node src)
{
    strcpy(dst->addr, src.addr);
    return 0;
}

typedef struct codelist
{
    int linecnt, capacity;//计数  容量
    int temp_index;
    char **code;
}codelist;

codelist* newcodelist()//新建代码 容量1k
{
    codelist* p = (codelist*)malloc(sizeof(codelist));
    p->linecnt = 0;
    p->capacity = 1024;
    p->temp_index = 0;
    p->code = (char**)malloc(sizeof(char*)*1024);
    return p;
}
int get_temp_index(codelist* dst) { return dst->temp_index++; }
int nextquad(codelist *dst) { return dst->linecnt; }

int Gen(codelist *dst, char *str)//生成代码
{
    if (dst->linecnt >= dst->capacity)
    {
        dst->capacity += 1024;
        dst->code = (char**)realloc(dst->code, sizeof(char*)*dst->capacity);
        if (dst->code == NULL)
        {
            printf("short of memeory\n");
            return 0;
        }
    }
    dst->code[dst->linecnt] = (char*)malloc(strlen(str)+20);
    strcpy(dst->code[dst->linecnt], str);
    dst->linecnt++;
    return 0;
}

char tmp[1024];
int gen_goto_blank(codelist *dst)//跳转 暂不明确标签
{
    sprintf(tmp, "goto");
    Gen(dst, tmp);
    return 0;
}
int gen_goto(codelist *dst, int instrno)//跳转到标签
{
    sprintf(tmp, "goto L%d", instrno);
    Gen(dst, tmp);
    return 0;
}
int gen_if(codelist *dst, node left, char* op, node right)
{
    sprintf(tmp, "if %s %s %s goto", left.addr, op, right.addr);
    Gen(dst, tmp);
    return 0;
}
int gen_1addr(codelist *dst, node left, char* op)
{
    sprintf(tmp, "%s %s", left.addr, op);
    Gen(dst, tmp);
    return 0;
}
int gen_2addr(codelist *dst, node left, char* op, node right)//一个操作数
{
    sprintf(tmp, "%s = %s %s", left.addr, op, right.addr);
    Gen(dst, tmp);
    return 0;
}
int gen_3addr(codelist *dst, node left, node op1, char* op, node op2)//两个操作数
{
    sprintf(tmp, "%s = %s %s %s", left.addr, op1.addr, op, op2.addr);
    Gen(dst, tmp);
    return 0;
}
int gen_assignment(codelist *dst, node left, node right)
{
    gen_2addr(dst, left, "", right);
    return 0;
}

int backpatch(codelist *dst, instrlist *list, int instrno)
{
    if (list!=NULL)
    {
        listele *p=list->first;
        char tmp[20];
    
        sprintf(tmp, " L%d", instrno);
        while (p!=NULL)
        {
            if (p->instrno<dst->linecnt)
                strcat(dst->code[p->instrno], tmp);//将标号回填
            p=p->next;
        }
    }
    return 0;
}

int print(codelist* dst)
{
    int i;
    for (i=0; i < dst->linecnt; i++)
        printf("    L%d:  %s\n", i, dst->code[i]);
    return 0;
}

#endif



