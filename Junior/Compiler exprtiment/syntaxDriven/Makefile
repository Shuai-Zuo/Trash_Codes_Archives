Compiler: lexicalAnalysis.l syntaxDriven.y
	bison -d syntaxDriven.y
	flex -olexicalAnalysis.lex.c lexicalAnalysis.l
	cc -o Compiler syntaxDriven.tab.c lexicalAnalysis.lex.c -lm
	rm lexicalAnalysis.lex.c
	rm syntaxDriven.tab.c
	rm syntaxDriven.tab.h
