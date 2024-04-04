%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

void yyerror(char *);
%}

%{
int a;
float b;
char c;
char input_buffer[1024]; // string
int input_index = 0;
%}

%{
#define DIGIT 100
#define FLOAT 101
#define IDENTIFIER 102
#define OPERATOR 103
#define NEWLINE 104
%}

DIGIT [0-9]
LETTER [A-Za-z]
FLOAT {DIGIT}+(\.{DIGIT}+)? 
IDENTIFIER {LETTER}({LETTER}|{DIGIT})*
LINE .*[\n]
OPERATOR [-+()=/*]
OPEN_PARENTHESIS "("
CLOSED_PARENTHESIS ")"
EXTRA [ \t]
NEWLINE [\n]


%%
{DIGIT}+ {
    a = atoi(yytext); 
    printf("Integer: %d\n", a);
    return DIGIT;
}
{FLOAT} {
    b = atof(yytext);
    printf("Float: %f\n", b);
    return FLOAT;
}
{IDENTIFIER} {
    printf("Identifier: %s\n", yytext);
    return IDENTIFIER;
}
{OPERATOR} {
    printf("Operator: %s\n", yytext);
    return OPERATOR;
}
{NEWLINE} {
    return NEWLINE;
}
{EXTRA} {
    ;
}
. {
    yyerror("Invalid character");
}
%%

int main() {
    int token;
    while ((token = yylex())) {
        if (token != NEWLINE) {
            printf("\n");
        } else {
            break;
        }
    }
    return 0;
}

int yywrap() {
    return 0;
}

void yyerror(char *s) {
    fprintf(stderr, "%s\n", s);
}

