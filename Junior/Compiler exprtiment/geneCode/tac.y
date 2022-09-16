%locations

%{
#include "code.h"
#define YYERROR_VERBOSE 1
#define YYSTYPE nodes
#include <string.h>

int errflag;

FILE* errorFile;
codelist* list;

%}

%union {
	struct* node nod;
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

%type <nod> P L S C E T F I M N

%left ADD SUB
%left MUL DIV

%nonassoc LOWER_THAN_ELSE
%nonassoc ELSE


%%

P: L									{ $$.nextlist = $1.nextlist; }				
 | L M P									{ backpatch(list, $1.nextlist, $2.quad); $$.nextlist = $3.nextlist; }
 ;

L: S SEMICOLON							{ $$.nextlist=$1.nextlist; }
 ;

S: I EQUAL E							{ copyaddr(&$1, $1.lexeme); gen_assignment(list, $1, $3); }
 | IF C THEN M S N ELSE M S					{ backpatch(list,$2.truelist,$4.quad); backpatch(list,$2.falselist, $8.quad); $$.nextlist:=merge($5.nextlist,merge($6.nextlist,$9.nextlist)); }
 | IF C THEN M S %prec LOWER_THAN_ELSE						{ backpatch(list,$2.truelist, $4.quad);$$.nextlist:=merge($2.falselist, $5.nextlist);  }
 | WHILE M C DO M S							{ backpatch(list,$6.nextlist,$2.quad); backpatch(list,$3.truelist, $5.quad); $$.nextlist:=$3.falselist; gen_goto(list,$2.quad); }
 | LBR P RBR							{ $$.nextlist=$2.nextlist; }
 ;

C: E GREATER E							{ $$.truelist=makelist(nextquad(list)); $$.falselist=makelist(nextquad(list)+1); gen_if(list,$1,'>',$3); gen_goto_blank(list); }
 | E LESS E								{ $$.truelist=makelist(nextquad(list)); $$.falselist=makelist(nextquad(list)+1); gen_if(list,$1,'<',$3); gen_goto_blank(list); }
 | E EQUAL E							{ $$.truelist=makelist(nextquad(list)); $$.falselist=makelist(nextquad(list)+1); gen_if(list,$1,'=',$3); gen_goto_blank(list); }
 ;

E: E ADD T								{ new_temp(&$$, get_temp_index(list));  gen_3addr(list, $$, $1, "+", $3); }
 | E SUB T								{ new_temp(&$$, get_temp_index(list));  gen_3addr(list, $$, $1, "-", $3); }
 | T									{ copyaddr_fromnode(&$$, $1); } 
 ;

T: T MUL F								{ new_temp(&$$, get_temp_index(list));  gen_3addr(list, $$, $1, "*", $3); }
 | T DIV F								{ new_temp(&$$, get_temp_index(list));  gen_3addr(list, $$, $1, "/", $3); }
 | T MUL I								{ new_temp(&$$, get_temp_index(list));  gen_3addr(list, $$, $1, "*", $3); }
 | T DIV I								{ new_temp(&$$, get_temp_index(list));  gen_3addr(list, $$, $1, "/", $3); }
 | F									{ copyaddr_fromnode(&$$, $1); }
 | I									{ copyaddr_fromnode(&$$, $1); }

F: LB E RB								{ copyaddr_fromnode(&$$, $2); }
 | OREAL								{ copyaddr(&$$, $1.lexeme); }
 | HREAL								{ copyaddr(&$$, $1.lexeme); }
 | DREAL								{ copyaddr(&$$, $1.lexeme); }
 | OINT									{ copyaddr(&$$, $1.lexeme); }
 | HINT									{ copyaddr(&$$, $1.lexeme); }
 | DINT									{ copyaddr(&$$, $1.lexeme); }
 ;

I: IDN									{ copyaddr(&$$, $1.lexeme); }
 ;

N : {$$.nextlist = new_instrlist(nextinstr(list)); gen_goto_blank(list);}
;

M : {$$.quad=nextquad(list);}
;             


%%

main(int argc, char** argv)
{
list = newcodelist();
    yyparse();
    return 0;
}


