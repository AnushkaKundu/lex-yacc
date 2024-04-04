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
    printf("String: %s\n", string);
    printf("Length of the string: %ld\n", strlen(string));
    int n = strlen(string);
    for (int i=0; i<n/2; i++) {
        if (string[i] != string[n-i-1]) {
            printf("Not palindrome\n");
            return 0;
        }
    }
    printf("Palindrome\n");
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
    printf("Enter a string: ");
    yyparse(); 
    return 0; 
} 
