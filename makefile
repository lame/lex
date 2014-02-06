a.out: lex.yy.o driver.o
	g++ lex.yy.o driver.o -lfl
lex.yy.o: token.l
	flex token.l
	g++ -c lex.yy.c
driver.o: driver.c
	g++ -c driver.c
clean:
	rm *.o
	rm lex.yy.c
	rm *~
