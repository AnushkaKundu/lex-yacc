%{
#include <stdio.h>
#include <stdlib.h>
extern int yylex();
extern int yylval;
extern FILE *yyin;
int yyerror(const char *msg);
%}

%token NUM

%%

input: /* empty */
    | input line
    ;

line: '\n'
    | exp '\n' { printf("Result: %d\n", $1); }
    ;

exp: NUM           { $$ = $1; }
    | exp '+' exp { $$ = $1 + $3; }
    | exp '-' exp { $$ = $1 - $3; }
    | exp '*' exp { $$ = $1 * $3; }
    | exp '/' exp { 
        if ($3 != 0)
            $$ = $1 / $3; 
        else {
            printf("Error: Division by zero\n");
            exit(1);
        }
    }
    | '(' exp ')'  { $$ = $2; }
    ;

%%

int main() {
    yyin = stdin;
    yyparse();
    return 0;
}

int yyerror(const char *msg) {
    printf("Error: %s\n", msg);
    return 0;
}
