%option noyywrap yylineno

%{
#include <stdio.h>
#include "numberConversion.h"
#include "symbolTable.h"

int column;
char* fileName=NULL;
FILE* recogFile=NULL;
void lyyerror(char*, int);

%}


%%

[ \t\r]											{ column += strlen(yytext); }
[\n]											{ column = 1; }
"if"											{ fprintf(recogFile, "IF\t_\n"); column += strlen(yytext); }
"then"											{ fprintf(recogFile, "THEN\t_\n"); column += strlen(yytext); }
"else"											{ fprintf(recogFile, "ELSE\t_\n"); column += strlen(yytext); }
"while"											{ fprintf(recogFile, "WHILE\t_\n"); column += strlen(yytext); }
"do"											{ fprintf(recogFile, "DO\t_\n"); column += strlen(yytext); }
[0][0-7]+\.[0-7]+								{ fprintf(recogFile, "REAL8\t%lf\n", OctRealToDecReal(yytext)); column += strlen(yytext); }
[[0][xX][0-9a-fA-F]+\.[0-9a-fA-F]+				{ fprintf(recogFile, "REAL16\t%lf\n", HexRealToDecReal(yytext)); column += strlen(yytext); }
([0]|[1-9][0-9]*)\.[0-9]+						{ fprintf(recogFile, "REAL10\t%lf\n", PutDecReal(yytext)); column += strlen(yytext); }
[0]([0]|[1-7][0-7]*)							{ fprintf(recogFile, "INT8\t%d\n", OctToDec(yytext)); column += strlen(yytext); }
[0][xX][0-9a-fA-F]+			     				{ fprintf(recogFile, "INT16\t%d\n", HexToDec(yytext)); column += strlen(yytext); }
[0]|[1-9][0-9]*									{ fprintf(recogFile, "INT10\t%d\n", PutDec(yytext)); column += strlen(yytext); }
"+"												{ fprintf(recogFile, "%s\t_\n", yytext); column += strlen(yytext); }
"-"												{ fprintf(recogFile, "%s\t_\n", yytext); column += strlen(yytext); }
"*"												{ fprintf(recogFile, "%s\t_\n", yytext); column += strlen(yytext); }
"/"												{ fprintf(recogFile, "%s\t_\n", yytext); column += strlen(yytext); }
">"												{ fprintf(recogFile, "%s\t_\n", yytext); column += strlen(yytext); }
"<"												{ fprintf(recogFile, "%s\t_\n", yytext); column += strlen(yytext); }
"="												{ fprintf(recogFile, "%s\t_\n", yytext); column += strlen(yytext); }
"("												{ fprintf(recogFile, "%s\t_\n", yytext); column += strlen(yytext); }
")"												{ fprintf(recogFile, "%s\t_\n", yytext); column += strlen(yytext); }
"{"												{ fprintf(recogFile, "%s\t_\n", yytext); column += strlen(yytext); }
"}"												{ fprintf(recogFile, "%s\t_\n", yytext); column += strlen(yytext); }
";"												{ fprintf(recogFile, "%s\t_\n", yytext); column += strlen(yytext); }
[a-zA-Z][a-zA-Z0-9]*[_|.][a-zA-Z0-9]+		 	{ fprintf(recogFile, "IDN\t%s\n", yytext); addref(fileName, yylineno, yytext, UNKNOWN, column); column += strlen(yytext); }
[a-zA-Z][a-zA-Z0-9]*                    		{ fprintf(recogFile, "IDN\t%s\n", yytext); addref(fileName, yylineno, yytext, UNKNOWN, column); column += strlen(yytext); }
.												{ lyyerror("Undefine character!", yylineno); column += strlen(yytext); }

%%

main(int argc, char **argv)
{
	column = 1;
	recogFile = fopen("recogResult.txt", "w");
	if (recogFile == NULL)
	{
		printf("Unable to open file \"recogResult.txt\".\n");
		exit(1);
	}
	if (argc < 2)
	{
		fileName = strdup("stdin");
    	yylex();
	}
	else
	{
		int i;
		for (i = 1; i < argc; i++)
		{
			fileName = strdup(argv[i]);
			FILE *f = fopen(argv[i], "r");
			if (f == NULL)
			{
				perror(argv[i]);
				exit(1);
			}
			yyrestart(f);
			yylex();
			if (fclose(f) != 0)
			{
				printf("Unable to close file \"%s\".\n", fileName);
				exit(1);
			}
		}
	}
	
	printrefs();
}

void lyyerror(char *str, int yylineno)
{
	FILE* errFile;
	errFile = fopen("errMsg.txt", "w");
	if (errFile == NULL)
	{
		printf("Unable to open file \"errMsg.txt\".\n");
		exit(1);
	}
	fprintf(errFile,"%s on line %d\n", str, yylineno);
	if (fclose(errFile) != 0)
	{
		printf("Unable to close file \"errMsg.txt\".\n");
		exit(1);
	}
}
