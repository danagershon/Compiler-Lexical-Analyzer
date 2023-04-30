/* definition section */
%{
/* declarations section */
#include "tokens.hpp"
#define MAX_STR_LEN 1024
%}

%option yylineno
%option noyywrap

WHITESPACE    ([\t\n\r ])
ID            [a-zA-Z][0-9a-zA-Z]*
NUM           0|[1-9][0-9]*

%x IN_COMMENT
%x IN_STRING
%x IN_ESC

%%
                   char string_buf[MAX_STR_LEN];
                   char *str_buf_ptr;

void               {return VOID; }
int                {return INT; }
byte               {return BYTE; }
bool               {return BOOL; }
override           {return OVERRIDE; }
and                {return AND; }
or                 {return OR; }
not                {return NOT; }
true               {return TRUE; }
false              {return FALSE; }
return             {return RETURN; }
if                 {return IF; }
else               {return ELSE; }
while              {return WHILE; }
break              {return BREAK; }
continue           {return CONTINUE; }
b                  {return B; }
;                  {return SC; }
,                  {return COMMA; }
\(                 {return LPAREN; }
\)                 {return RPAREN; }
\{                 {return LBRACE; }
\}                 {return RBRACE; }
=                  {return ASSIGN; }
[<>]=?|[=!]=       {return RELOP; }
[\+\*\-/]          {return BINOP; }
{ID}               {return ID; }
{NUM}              {return NUM; }

"//"                 {BEGIN(IN_COMMENT); }

<IN_COMMENT>\n|\r\n  {BEGIN(INITIAL);
                      return COMMENT; }

<IN_COMMENT>\r       {BEGIN(INITIAL);
                      return COMMENT_CR_EOF;}
<IN_COMMENT><<EOF>>  {BEGIN(INITIAL);
                      return COMMENT_CR_EOF;}
<IN_COMMENT>.        {}

\"                 {/* string start */
                    BEGIN(IN_STRING);
                    str_buf_ptr = string_buf; }

<IN_STRING>\\?[\n\r]  { /* error unclosed string */
                        return UNCLOSED_STRING; }

<IN_STRING>\\\\    {*str_buf_ptr++ = '\\'; }
<IN_STRING>\\\"    {*str_buf_ptr++ = '"'; }
<IN_STRING>\\n     {*str_buf_ptr++ = '\n'; }
<IN_STRING>\\r     {*str_buf_ptr++ = '\r'; }
<IN_STRING>\\t     {*str_buf_ptr++ = '\t'; }
<IN_STRING>\\0     {*str_buf_ptr++ = '\0'; }

<IN_STRING>\\x[0-7][0-9a-fA-F] {int num;
                                sscanf(yytext+2,"%x",&num);
                                *str_buf_ptr++ = (char)num; }

<IN_STRING>\\x[^\n\r\"]{0,2}    { /* error undefined escape sequence */
                                  return UNDEFINED_ESC_SEQ_X;}

<IN_STRING>\\      {BEGIN(IN_ESC);}

<IN_ESC>[^\n\r]    {return UNDEFINED_ESC_SEQ;}

<IN_ESC>[\n\r]     {return UNCLOSED_STRING;}

<IN_ESC><<EOF>>    {return UNCLOSED_STRING;}

<IN_STRING>[^\\\n\"\r]+ {char* curr_ptr = yytext;
                         while(*curr_ptr)
                             *str_buf_ptr++ = *curr_ptr++;
                        }

<IN_STRING><<EOF>> { /* error unclosed string */
                     /* no enclosing quote found and reached EOF */
                     return UNCLOSED_STRING;}

<IN_STRING>\"      { /* string end */
                    BEGIN(INITIAL);
                    *str_buf_ptr = '\0'; /* terminate string */
                    STR_BUF = (char*)malloc(strlen(string_buf)+1);
                    strncpy(STR_BUF,string_buf,strlen(string_buf)+1);
                    return STRING; }

{WHITESPACE}       {}

<INITIAL,IN_STRING>. { /* error unmatched token */
                      return UNMATCHED_TOKEN; }

%%
