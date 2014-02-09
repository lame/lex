a.out: lex.yy.c token.h driver.cpp
	g++ driver.cpp -lfl
lex.yy.c: lexer.l
	lex lexer.l
clean:
	rm -f *.o
	rm -f lex.yy.c
	rm -f *~
