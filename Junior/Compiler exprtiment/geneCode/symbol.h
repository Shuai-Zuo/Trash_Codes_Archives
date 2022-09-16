#include <stdlib.h>
#include <string.h>

#define NHASH 9997

enum Type {
	IDENTIFIER=1,
	INT8,
	INT10,
	INT16,
	REAL8,
	REAL10,
	REAL16,
	UNKNOWN
};

struct symbol {
	char *name;
	char *filename;
	void* value;
	int lineno;
	int startCol, endCol;
	int flags;
};

struct symbol symtab[NHASH];

char*
getType(int flags)
{
	switch(flags)
	{
		case 1: return "IDN";
		case 2:	return "INT8";
		case 3:	return "INT10";
		case 4:	return "INT16";
		case 5:	return "REAL8";
		case 6:	return "REAL10";
		case 7:	return "REAL16";
		default: return "UNKNOWN";
	}
}

static unsigned
symhash(char *sym)
{
	unsigned int hash = 0;
	unsigned c;

	while(c = *sym++) hash = hash * 9 ^ c;

	return hash;
}

struct symbol*
lookup(char *sym)
{
	struct symbol *sp = &symtab[symhash(sym)%NHASH];
	int scount = NHASH;
	
	while(--scount >= 0)
	{
		if (sp->name && !strcmp(sp->name, sym)) return sp;
		
		if (!sp->name)
		{
			sp->name = strdup(sym);
			sp->lineno = -1;
			sp->value = NULL;
			sp->flags = -1;
			sp->startCol = -1;
			sp->endCol = -1;
			return sp;
		}
		
		if (++sp >= symtab+NHASH) sp = symtab;
	}
	fputs("symbol table overflow\n", stderr);
	abort();
}

void
addref(char* filename, int lineno, char *word, int flags, int startCol)
{
	struct symbol *sp = lookup(word);
	
	if (sp->lineno == lineno && sp->flags == flags)	
		return;
	
	sp->filename = strdup(filename);
	sp->lineno = lineno;
	sp->startCol = startCol;
	sp->endCol = startCol+strlen(word)-1;
	sp->flags = flags;
}

void
changevalue(char *name, void* value)
{
	struct symbol *sp = lookup(name);
	
	sp->value = value;
}

static int
symcompare(const void *xa, const void *xb)
{
	const struct symbol *a = xa;
	const struct symbol *b = xb;
	
	if (!a->name)
	{
		if (!b->name) return 0;
		return 1;
	}
	
	if(!b->name)
		return -1;

	return strcmp(a->name, b->name);
}

void
printrefs()
{
	FILE* symTable;
	symTable = fopen("symTab.txt", "w");
	if (symTable == NULL)
	{
		printf("Unable to open file \"symTab.txt\".\n");
		exit(1);
	}

	struct symbol *sp;

	qsort(symtab, NHASH, sizeof(struct symbol), symcompare);

	for (sp = symtab; sp->name && sp < symtab+NHASH; sp++)
		fprintf(symTable, "%s:\tfile: %s,\tlineno: %d,\tstartCol: %d\tendCol: %d\ttype: %s\n", sp->name, sp->filename, sp->lineno, sp->startCol, sp->endCol, getType(sp->flags));
}




