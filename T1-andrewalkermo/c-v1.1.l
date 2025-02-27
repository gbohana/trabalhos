%option noyywrap yylineno

%{

#include "c-v1.1.tab.h"

%}

id                         [A-Za-z]([A-Za-z]|[0-9]|[_])*
numbers                    [0-9]+
inlinecomment              \/\/.*
blank                      [ \t\n]+

%%

{inlinecomment}             { /* no action */ }
{blank}                     { /* no action */ }

else                        { return KEY; }
if                          { return KEY; }
int                         { return KEY; }
return                      { return KEY; }
void                        { return KEY; }
while                       { return KEY; }
const                       { return KEY; }
for                         { return KEY; }

{id}                        { return ID; }
{numbers}                   { return NUM; }

("+"|"-"|"*"|"/")           { return SYM; }
("="|"<"|">")               { return SYM; }
("<="|">="|"=="|"!=")       { return SYM; }
(";"|",")                   { return SYM; }
("("|")"|"["|"]"|"{"|"}")   { return SYM; }

.                           { return ERROR; }


%%

int main(int argc, char **argv) {
    int token;

    while ((token = yylex())) {
        switch (token) {
         case ERROR:
            printf("(%d,ERROR,\"%s\")\n", yylineno, yytext);
            break;
         case NUM: 
            printf("(%d,NUM,\"%s\")\n", yylineno, yytext);
            break; 
         case ID: 
            printf("(%d,ID,\"%s\")\n", yylineno, yytext);
            break;
         case KEY:
            printf("(%d,KEY,\"%s\")\n", yylineno, yytext);
            break;
         case SYM: 
            printf("(%d,SYM,\"%s\")\n", yylineno, yytext);
            break;
        }
    }
}

