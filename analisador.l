%{
#include <stdio.h>
#include <stdlib.h>

%}

/* DEFINICOES */
D_INT             "INT"
D_DEC             "DEC"
D_LOG             "LOG"
D_STR             "STR"
D_BOOL            "BOOL"
D_FLOAT           "FLOAT"

D_LEIA            "leia"
D_ESCREVA         "escreva"

D_IF              "if"
D_ELSE_IF         "else if"
D_ELSE            "else"
D_FOR             "for"
D_ENQUANTO        "enquanto"
D_REPETICAO       "repeticao"

DELIMITADOR       "{"|"}"|"("|")"|"["|"]"
ATRIBUICAO        "="
FIM_LINHA         ";"
IGNORE            [' '\n\t]+
DIGITOS           [0-9]+
LETRAS            [a-zA-Z]
/* LETRA (b) */
ID_VARIAVEIS      {LETRAS}({LETRAS}|{DIGITOS})* 

%%

    /* letra (f) e (i)TIPOS E PALAVRAS RESERVADAS */
{D_INT}           {printf("TIPO: INTEIRO | %s\n", yytext);}
{D_DEC}           {printf("TIPO: DECIMAL | %s\n", yytext);}
{D_LOG}           {printf("TIPO: LOGICO | %s\n", yytext);}
{D_STR}           {printf("TIPO: STRING | %s\n", yytext);}
{D_BOOL}          {printf("TIPO: BOOLEANO | %s\n", yytext);}
{D_FLOAT}         {printf("TIPO: FLOAT | %s\n", yytext);}
"true"            {printf("VALOR LOGICO: VERDADEIRO | %s\n", yytext);}
"false"           {printf("VALOR LOGICO: FALSO | %s\n", yytext);}

    /* LETRA (d) e (e) INSTRUCOES DE ENTRADA E SAÍDA  */
{D_LEIA}          {printf("INSTRUCAO: LEITURA | %s\n", yytext);}
{D_ESCREVA}       {printf("INSTRUCAO: ESCRITA | %s\n", yytext);}

    /* letra (g) ESTRUTURAS DE CONTROLE */
{D_ENQUANTO}      {printf("ESTRUTURA: REPETICAO 'ENQUANTO' | %s\n", yytext);}
{D_REPETICAO}     {printf("ESTRUTURA: REPETICAO 'REPETICAO' | %s\n", yytext);}
{D_IF}            {printf("ESTRUTURA: INICIO CONDICIONAL | %s\n", yytext);}
{D_ELSE_IF}       {printf("ESTRUTURA: CONDICIONAL INTERMEDIARIA | %s\n", yytext);}
{D_ELSE}          {printf("ESTRUTURA: FIM CONDICIONAL | %s\n", yytext);}
{D_FOR}           {printf("ESTRUTURA: REPETICAO 'FOR' | %s\n", yytext);}

    /* LETRA (C)OPERADORES */
"=="              {printf("OPERADOR: IGUALDADE | %s\n", yytext);}
"!="              {printf("OPERADOR: DIFERENCA | %s\n", yytext);}
">="              {printf("OPERADOR: MAIOR_IGUAL | %s\n", yytext);}
"<="              {printf("OPERADOR: MENOR_IGUAL | %s\n", yytext);}
">"               {printf("OPERADOR: MAIOR QUE | %s\n", yytext);}
"<"               {printf("OPERADOR: MENOR QUE | %s\n", yytext);}
"&&"              {printf("OPERADOR LOGICO: AND | %s\n", yytext);}
"||"              {printf("OPERADOR LOGICO: OR | %s\n", yytext);}
"!"               {printf("OPERADOR LOGICO: NOT | %s\n", yytext);}
"+"               {printf("OPERADOR: SOMA | %s\n", yytext);}
"++"               {printf("OPERADOR: INCREMENTADOR| %s\n", yytext);}
"-"               {printf("OPERADOR: SUBTRACAO | %s\n", yytext);}
"*"               {printf("OPERADOR: MULTIPLICACAO | %s\n", yytext);}
"/"               {printf("OPERADOR: DIVISAO | %s\n", yytext);}
"%"               {printf("OPERADOR: RESTO DA DIVISAO | %s\n", yytext);}
{ATRIBUICAO}      {printf("OPERADOR: ATRIBUICAO | %s\n", yytext);}

   /* LETRA (h) e (j) DELIMITADORES E CARACTERES ESPECIAIS */
{DELIMITADOR}       {printf("DELIMITADOR | %s\n", yytext);}
{FIM_LINHA}         {printf("FIM DE INSTRUCAO | %s\n", yytext);}
"\"".*?"\""         {printf("STRING | %.*s\n", (int)yyleng - 2, yytext + 1);}
"\'"."\'"           {printf("CARACTERE | %.*s\n", (int)yyleng - 2, yytext + 1);}
","                 {printf("CARACTERE ESPECIAL: VIRGULA | %s\n", yytext);}

    /* letra (a) COMENTARIOS */
"//".* {}
"/*"[^*]*"*"*([^*/][^*]*"*"*)*"/" {} {printf("COMENTARIO | %s\n", yytext);} 

    /* RECONHECIMENTO GERAL */
{DIGITOS}("."[0-9]+)? {printf("LITERAL: NUMERICO | %s\n", yytext);}
{ID_VARIAVEIS}              {printf("IDENTIFICADOR | %s\n", yytext);}
{IGNORE}          {}

.                 {printf("TOKEN DESCONHECIDO: %s\n", yytext);}

%%


int main(){
    yyin = fopen("code.gabs", "r");
    if(!yyin) {
        printf("ERRO: Nao foi possivel abrir o arquivo 'code.gabs'\n");
        return 1;
    }
    yylex();
    fclose(yyin);
    return 0;
}

