%{
#include <stdio.h>
#include "y.tab.h"
%}

%%

[a-zA-Z]+ { yylval.str = strdup(yytext); return STR; }

%%

int yywrap() {
    return 1;
}
