%option noyywrap yylineno

%{
#include "symbol.h"
#include "number.h"
#include "y.tab.h"

/*
#define YY_INPUT(buf,result,max_size)  {\
    result = GetNextChar(buf, max_size); \
    if (  result <= 0  ) \
      result = YY_NULL; \
    }
*/

extern int column;
extern void beginToken(char *t);
extern void setColumn();
extern char* fileName;

%}


%%

[ \t\r]											{ beginToken(yytext); }
[\n]											{ setColumn(); }
"if"											{ beginToken(yytext); return IF; }
"then"											{ beginToken(yytext); return THEN; }
"else"											{ beginToken(yytext); return ELSE; }
"while"											{ beginToken(yytext); return WHILE; }
"do"											{ beginToken(yytext); return DO; }
[0][0-7]+\.[0-7]+								{ yylval.value=OctRealToDecReal(yytext); beginToken(yytext); return OREAL; }
[0][xX][0-9a-fA-F]+\.[0-9a-fA-F]+				{ yylval.value=HexRealToDecReal(yytext); beginToken(yytext); return HREAL; }
([0]|[1-9][0-9]*)\.[0-9]+						{ yylval.value=PutDecReal(yytext); beginToken(yytext); return DREAL; }
[0]([0]|[1-7][0-7]*)							{ yylval.value=(double)OctToDec(yytext); beginToken(yytext); return OINT; }
[0][xX][0-9a-fA-F]+			     				{ yylval.value=(double)HexToDec(yytext); beginToken(yytext); return HINT; }
[0]|[1-9][0-9]*									{ yylval.value=(double)PutDec(yytext); beginToken(yytext); return DINT; }
"+"												{ beginToken(yytext); return ADD; }
"-"												{ beginToken(yytext); return SUB; }
"*"												{ beginToken(yytext); return MUL; }
"/"												{ beginToken(yytext); return DIV; }
">"												{ beginToken(yytext); return GREATER; }
"<"												{ beginToken(yytext); return LESS; }
"="												{ beginToken(yytext); return EQUAL; }
"("												{ beginToken(yytext); return LB; }
")"												{ beginToken(yytext); return RB; }
"{"												{ beginToken(yytext); return LBR; }
"}"												{ beginToken(yytext); return RBR; }
";"												{ beginToken(yytext); return SEMICOLON; }
[a-zA-Z][a-zA-Z0-9]*[_|.][a-zA-Z0-9]+		 	{
												  addref(fileName, yylineno, yytext, UNKNOWN, column); 
												  beginToken(yytext);
												  yylval.string=strdup(yytext);
												  return IDN;
												}
[a-zA-Z][a-zA-Z0-9]*                    		{ 
												  addref(fileName, yylineno, yytext, UNKNOWN, column);
												  beginToken(yytext); 
												  yylval.string=strdup(yytext);
												  return IDN; 
												}
.												{ beginToken(yytext); return ERROR; }

%%
