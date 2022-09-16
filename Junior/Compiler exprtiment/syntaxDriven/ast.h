#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdarg.h>
#include <math.h>

/*
	expressionType
	1			P->L
	2			p->L P
	3			L->S ;
	4			S->id = E
	5			S->if C then S
	6			S->if C then S else S
	7			S->while C do S
	8			S->{ P }
	9			C->E > E
	10			C->E < E
	11			C->E = E
	12			E->E + T
	13			E->E - T
	14			E->T
	15			T->F
	16			T->T * F
	17			T->T / F
	18			F-> ( E )
	19			F->id
	20			F->INT8
	21			F->INT10
	22			F->INT16
	23			F->REAL8
	24			F->REAL10
	25			F->REAL16;

	101			INT8
	102			INT10
	103			INT16
	104			REAL8
	105			REAL10
	106			REAL16

	151			IDN
*/ 

extern char* fileName;
FILE* f;

struct ast {
	int expressionType;
	double number;
	char idn[1005];
	struct ast *left;
	struct ast *middle;
	struct ast *right;
};

char* checkProcedure(int no);
void displayAST(struct ast* root);

struct ast *newastwithidn(int expressionType, struct ast *idn, struct ast *l, struct ast *m, struct ast *r)
{
	struct ast *a;
	a = (struct ast*)malloc(sizeof(struct ast));
    a->expressionType = expressionType;
    a->number = -1;
    strcpy(a->idn, idn->idn);
    a->left = l;
    a->middle = m;
    a->right = r;
    return a;

}

struct ast *newast(int expressionType, struct ast *l, struct ast *m, struct ast *r)
{
/*
	if (expressionType > 100)
	{
		printf("Error on constructing the tree.\n");
		exit(0);
	}
*/	
	struct ast *a;
	a = (struct ast*)malloc(sizeof(struct ast));
	a->expressionType = expressionType;
	a->number = -1;
	memset(a->idn, 0, sizeof(a->idn));
	a->left = l;
	a->middle = m;
	a->right = r;
	return a;
}

struct ast *newnum(int expressionType, double number)
{
/*
	if (expressionType < 101 || expressionType > 150 )
	{
		printf("Error on creating new number node.\n");
		exit(0);
	}
*/	
	struct ast *a;
	a = (struct ast*)malloc(sizeof(struct ast));
	a->expressionType = expressionType;
	a->number = number;
	memset(a->idn, 0, sizeof(a->idn));
	a->left = NULL;
	a->middle = NULL;
	a->right = NULL;
	return a;
}

struct ast *newidn(int expressionType, char *idn)
{
/*
    if (expressionType < 151)
    {
        printf("Error on creating new idn node.\n");
        exit(0);
    }
*/
    struct ast *a;
	a = (struct ast*)malloc(sizeof(struct ast));
    a->expressionType = expressionType;
    a->number = -1;
    strcpy(a->idn, idn);
    a->left = NULL;
    a->middle = NULL;
    a->right = NULL;
    return a;
}

char* checkProcedure(int no)
{
	switch(no)
	{
		case 1:		return "P-> L";
		case 2:		return "P-> L P";
		case 3:		return "L-> S ;";
		case 4:		return "S-> id = E";
		case 5:		return "S-> if C then S";
		case 6:		return "S-> if C then S else S";
		case 7:		return "S-> while C do S";
		case 8:		return "S-> { P }";
		case 9:		return "C-> E > E";
		case 10:	return "C-> E < E";
		case 11:	return "C-> E = E";
		case 12:	return "E-> E + T";
		case 13:	return "E-> E - T";
		case 14:	return "E-> T";
		case 15:	return "T-> F";
		case 16:	return "T-> T * F";
		case 17:	return "T-> T / F";
		case 18:	return "F-> ( E )";
		case 19:	return "F-> id";
		case 20:	return "F-> INT8";
		case 21:	return "F-> INT10";
		case 22:	return "F-> INT16";
		case 23:	return "F-> REAL8";
		case 24:	return "F-> REAL10";
		case 25:	return "F-> REAL16";
		default: 	return "ERROR";
	}
}

void displayAST(struct ast* root)
{
	if (root == NULL)
	{
		printf("root is NULL.\n");
		return;
	}

	fprintf(f, "%s", checkProcedure(root->expressionType));
	if (root->number != -1)
	{
//		printf("ExpressionType = %d\n", root->expressionType);
		if (root->expressionType >= 20 && root->expressionType <= 22)
			fprintf(f, "\t%d", (int)root->number);
		else if (root->expressionType >= 23 && root->expressionType <= 25)
			fprintf(f, "\t%lf", root->number);
	}
	if (strlen(root->idn) > 0)
		fprintf(f, "\t%s", root->idn);
	fprintf(f, "\n");

	if (root->left != NULL)
		displayAST(root->left);
	if (root->middle != NULL)
		displayAST(root->middle);
	if (root->right != NULL)
		displayAST(root->right);
}
