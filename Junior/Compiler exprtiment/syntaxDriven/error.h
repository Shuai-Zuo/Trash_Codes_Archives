#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdarg.h>
#include "syntaxDriven.tab.h"

extern int yylineno;
int column;

char* fileName=NULL;

extern int yylex(void);
extern int yyparse(void);
extern void yyerror(const char*);


void beginToken(char *t)
{
	yylloc.first_line = yylineno;
	yylloc.first_column = column > 0 ? column : 1;
	yylloc.last_line = yylineno;
	yylloc.last_column = (column + strlen(t) - 1 > 0) ? column + strlen(t) - 1 : 1;
	column += strlen(t);
}

void setColumn()
{
	column = 1;
}
