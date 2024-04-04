%{ 
#include <stdio.h> 
#include <string.h> 
#include <stdlib.h> 

extern int yylex(); 
void yyerror(char *msg); 

int flag; 
char* string;

%} 

%union { 
    char* str; 
} 

%token <str> STR 
%type <str> E 

%% 

S : E { 
    int n = strlen(string);
    if ((string[0] == '0' || string[0] == '1') && (string[n-1] == '0' || string[n-1] == '1')) {
        printf("Accepted\n");
    } else {
        printf("Not Accepted\n");
    }
    return 0;
} 
; 

E : STR { 
    string = $1;
} 
; 

%% 

void yyerror(char *msg) { 
    fprintf(stderr, "%s\n", msg); 
    exit(1); 
} 

int main() { 
    yyparse(); 
    return 0; 
} 
