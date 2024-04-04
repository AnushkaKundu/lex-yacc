%{
#include "y.tab.h"
%}

%%
[0-9]+      { yylval = atoi(yytext); return NUM; }
[-+*/\n]    { return yytext[0]; }
[ \t]       ; /* skip whitespace */
.           { return yytext[0]; } /* any other character is considered invalid */
%%

int yywrap() {
    return 1;
}
