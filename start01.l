%{
#include <stdio.h>
#include "y.tab.h"
%}

%%

[a-zA-Z0-9]+ { yylval.str = strdup(yytext); return STR; }

%%

int yywrap() {
    return 1;
}
