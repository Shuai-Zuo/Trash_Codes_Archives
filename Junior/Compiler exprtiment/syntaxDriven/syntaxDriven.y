%locations

%{

#include "error.h"
#include "ast.h"
#define YYERROR_VERBOSE 1

int errflag;
struct ast* root;

FILE* errorFile;

%}

%union {
	struct ast* node;
	char* string;
	double value;
}

%token IF THEN ELSE WHILE DO
%token LBR RBR
%token <value> OREAL HREAL DREAL OINT HINT DINT
%token ADD SUB MUL DIV GREATER LESS EQUAL LB RB
%token SEMICOLON
%token <string> IDN
%token ERROR

%type <node> P L S C E T F I

%left ADD SUB
%left MUL DIV

%nonassoc LOWER_THAN_ELSE
%nonassoc ELSE


%%

P: L									{ $$ = newast(1, NULL, $1, NULL); root = $$; }				
 | L P									{ $$ = newast(2, $1, NULL, $2); root = $$; }
 ;

L: S SEMICOLON							{ $$ = newast(3, NULL, $1, NULL); }
 | S error SEMICOLON						{ yyerrok; }
 | ERROR					{ yyerror("syntax error, undefined identifier."); yyerrok; }
 ;

S: I EQUAL E							{ $$ = newastwithidn(4, $1, NULL, $3, NULL); }
 | IF C THEN S ELSE S					{ $$ = newast(6, $2, $4, $6); }
 | IF C THEN S %prec LOWER_THAN_ELSE						{ $$ = newast(5, $2, $4, NULL); }
 | WHILE C DO S							{ $$ = newast(7, $2, NULL, $4); }
 | LBR P RBR							{ $$ = newast(8, NULL, $2, NULL); }
 | error EQUAL E						{ yyerrok; }
 | I EQUAL error E						{ yyerrok; }
 | I error							{ yyerrok; }
 | I error EQUAL E						{ yyerrok; }
 | error EQUAL error						{ yyerrok; }
 | IF error C THEN S						{ yyerrok; }
 | IF C error THEN S						{ yyerrok; }
 | IF C THEN error S						{ yyerrok; }
 | IF error THEN S						{ yyerrok; }
 | IF C THEN S ELSE error S					{ yyerrok; }
 | WHILE error C DO S						{ yyerrok; }
 | WHILE C error DO S						{ yyerrok; }
 | WHILE C DO error S						{ yyerrok; }
 ;

C: E GREATER E							{ $$ = newast(9, $1, NULL, $3); }
 | E LESS E								{ $$ = newast(10, $1, NULL, $3); }
 | E EQUAL E							{ $$ = newast(11, $1, NULL, $3); }
 | E error GREATER E 						{ yyerrok; }
 | E GREATER error E					 	{ yyerrok; }
 | E error LESS E 						{ yyerrok; }
 | E LESS error E 						{ yyerrok; }
 | E error EQUAL E 						{ yyerrok; }
 | E EQUAL error E 						{ yyerrok; }
 | error GREATER E 						{ yyerrok; } 
 | E GREATER error 						{ yyerrok; }
 | error LESS E 						{ yyerrok; } 
 | E LESS error 						{ yyerrok; }
 | error EQUAL E 						{ yyerrok; } 
 | E EQUAL error 						{ yyerrok; }
 | error GREATER error 						{ yyerrok; }
 | error LESS error 						{ yyerrok; }
 | error EQUAL error 						{ yyerrok; }
 ;

E: E ADD T								{ $$ = newast(12, $1, NULL, $3); }
 | E SUB T								{ $$ = newast(13, $1, NULL, $3); }
 | T									{ $$ = newast(14, NULL, $1, NULL); } 
 | E ADD error T						{ yyerrok; }
 | E SUB error T						{ yyerrok; }
 ;

T: T MUL F								{ $$ = newast(16, $1, NULL, $3); }
 | T DIV F								{ $$ = newast(17, $1, NULL, $3); }
 | T MUL I								{ $$ = newast(16, $1, NULL, $3); }
 | T DIV I								{ $$ = newast(17, $1, NULL, $3); }
 | F									{ $$ = newast(15, NULL, $1, NULL); }
 | I									{ $$ = newast(15, NULL, $1, NULL); }
 | T MUL error F						{ yyerrok; }
 | T DIV error F						{ yyerrok; }
 | T MUL error I						{ yyerrok; }
 | T DIV error I						{ yyerrok; }
 ;

F: LB E RB								{ $$ = newast(18, NULL, $2, NULL); }
 | OREAL								{ $$ = newnum(23, yylval.value); }
 | HREAL								{ $$ = newnum(25, yylval.value); }
 | DREAL								{ $$ = newnum(24, yylval.value); }
 | OINT									{ $$ = newnum(20, yylval.value); }
 | HINT									{ $$ = newnum(22, yylval.value); }
 | DINT									{ $$ = newnum(21, yylval.value); }
 | LB E error								{ yyerrok; }
 ;

I: IDN									{ $$ = newidn(19, yylval.string); }
 ;

%%

main(int argc, char** argv)
{
	char errFile[] = {"????????????.txt"};
	errorFile = fopen(errFile,"w");
        if (errorFile == NULL)
        {
	    printf("Unable to open file \"????????????.txt\".\n");
	    exit(1);
        }
	errflag = 0;
	column = 1;	
	int i = 0;
	if (argc < 2)
	{
		fileName = strdup("stdout");
		yyparse();
		if (errflag == 0)
		{
			char* outFileName = strdup("result_stdout.txt");
			f = fopen(outFileName, "w");
			if (f == NULL)
			{
				printf("Unable to open file \"%s\".\n", outFileName);
				exit(1);
			}
			displayAST(root);
			if (fclose(f) != 0)
			{
				printf("Unable to close file \"%s\".\n", outFileName);
				exit(1);
			}
		}
	}
	else
	{
		column = 1;
		int i;
		for (i = 1; i < argc; i++)
		{
			fileName = strdup(argv[i]);
			FILE *fi = fopen(argv[i], "r");
			if (fi == NULL)
			{
				perror(argv[i]);
				exit(1);
			}
			yyrestart(fi);
			yyparse();
			if (fclose(fi) != 0)
			{
				printf("Unable to close file \"%s\".\n", fileName);
				exit(1);
			}
			if (errflag == 0)
			{
				char* outFileName = strdup("result_");
				strcat(outFileName, fileName);
				f = fopen(outFileName, "w");
				if (f == NULL)
				{
					printf("Unable to open file \"%s\".\n", outFileName);
					exit(1);
				}
				displayAST(root);
				if (fclose(f) != 0)
				{
					printf("Unable to close file \"%s\".\n", outFileName);
					exit(1);
				}
			}
		}
	}
	printrefs();
	if (fclose(errorFile))
        {
	    printf("Unable to close file \"????????????.txt\".\n");
	    exit(1);
        }
	return 0;
}

extern
void yyerror(const char *s) {
    errflag = 1;
    int start = yylloc.first_column;
    int end = yylloc.last_column;
    int i;
    
    fprintf(errorFile, "Error: %s on Line: %d:c%d to %d:c%d\n", s, yylineno, start, yylineno, end);
}

