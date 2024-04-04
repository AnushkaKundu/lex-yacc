%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

void yyerror(char *);
%}

%%
%%

int yywrap() {
    return 0;
}

void yyerror(char *s) {
    fprintf(stderr, "%s\n", s);
}

int main(int argc, char *argv[]) {
    yyin = fopen(argv[1], "r");
    int token;
    while ((token = yylex())) {
        if (token != NEWLINE) {
            printf("\n");
        } else {
            break;
        }
    }
    fclose(yyin);
    return 0;
}