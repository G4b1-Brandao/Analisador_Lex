all: analisador.l
	clear
	flex -i analisador.l
	gcc lex.yy.c -o out -lfl
	./out 
