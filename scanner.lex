%{
// Definition section   
    #include <iostream>
    #include "hw3_output.hpp"
    #include "utils.hpp"
    #include "parser.tab.hpp"

%}

%option yylineno
%option noyywrap


VOID          "void"
INT           "int"
BYTE          "byte"
B             "b"
BOOL          "bool"
AND           "and"
OR            "or"
NOT           "not"
TRUE          "true"
FALSE         "false"
RETURN        "return"
IF            "if"
ELSE          "else"
WHILE         "while"
BREAK         "break"
CONTINUE      "continue"
SC            ";"
COMMA         ","
LPAREN        "("
RPAREN        ")"
LBRACE        "{"
RBRACE        "}"
ASSIGN        "="
RELATIONAL_RELOP         <|>|<=|>=
EQUALITY_RELOP           ==|!=
ADD_BINOP      \+|-
MUL_BINOP     \*|\/
ID            [a-zA-Z][a-zA-Z0-9]*
NUM           0|[1-9][0-9]*
STRING        \"([^\n\r\"\\]|\\[rnt"\\])+\"
COMMENT       \/\/[^\r\n]*[\r|\n|\r\n]?
IGNORE        [ \t\n\r]


%%


{VOID}          {return VOID;}
{INT}           {return INT;}
{BYTE}          {return BYTE;}
{B}             {return B;}
{BOOL}          {return BOOL;}
{AND}           {return AND;}
{OR}            {return OR;}
{NOT}           {return NOT;}
{TRUE}          {return TRUE;}
{FALSE}         {return FALSE;}
{RETURN}        {return RETURN;}
{IF}            {return IF;}
{ELSE}          {return ELSE;}
{WHILE}         {return WHILE;}
{BREAK}         {return BREAK;}
{CONTINUE}      {return CONTINUE;}
{SC}            {return SC;}
{COMMA}         {return COMMA;}
{LPAREN}        {return LPAREN;}
{RPAREN}        {return RPAREN;}
{LBRACE}        {return LBRACE;}
{RBRACE}        {return RBRACE;}
{ASSIGN}        {return ASSIGN;}
{RELATIONAL_RELOP}  {
                yylval=new Expression();
                yylval->op=(yytext);
                return RELATIONAL_RELOP;
                }
{EQUALITY_RELOP}    {
                yylval=new Expression();
                yylval->op=(yytext);
                return EQUALITY_RELOP;
            }
{ADD_BINOP}     {   
            yylval=new Expression();
            yylval->op=(yytext);
            return ADD_BINOP;
        }
{MUL_BINOP}     {
            yylval=new Expression();
            yylval->op=(yytext);
            return MUL_BINOP;
        }
{ID}            {
            yylval=new Expression();
            yylval->id_name=(yytext);;
            return ID;
        }
{NUM}           {
                    yylval=new Expression();
                    yylval->number= atoi(yytext);
                    return NUM;
                }
{STRING}        {
                    yylval=new Expression();
                    yylval->str=(yytext);
                    return STRING;
                }
{COMMENT}       ;
{IGNORE}        ;
.               {output::errorLex(yylineno); exit(1);}

%%