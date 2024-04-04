%{
#include <stdio.h>
#include <stdlib.h>

char buf[100];
char *s;
%}

%x STRING

%%

\"              { BEGIN STRING; s = buf; } // Enter STRING state when encountering a double quote
<STRING>\\n     { *s++ = '\n'; }           // Handle newline escape sequence
<STRING>\\t     { *s++ = '\t'; }           // Handle tab escape sequence
<STRING>\\\"    { *s++ = '\"'; }           // Handle double quote escape sequence
<STRING>\"      { 
                    *s = '\0';             // Null-terminate the string
                    BEGIN 0;               // Return to the initial state
                    printf("Found string: '%s'\n", buf); // Print the recognized string
                }
<STRING>\n      { 
                    printf("Invalid string: Unterminated\n"); // Handle unterminated string
                    exit(1); 
                }
<STRING>.       { *s++ = *yytext; }        // Capture any other character in the string

.               { /* Ignore other characters outside of strings */ }

%%

int main() {
    yylex();
    return 0;
}

void yyerror(char *s) {
    fprintf(stderr, "%s\n", s);
}
