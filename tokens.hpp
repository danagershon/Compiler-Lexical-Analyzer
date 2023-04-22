#ifndef TOKENS_HPP_
#define TOKENS_HPP_
#include <cstdlib>

extern char* STR_BUF;

  enum tokentype
  {
    VOID = 1,
    INT = 2,
    BYTE = 3,
    B = 4,
    BOOL = 5,
    AND = 6,
    OR = 7,
    NOT = 8,
    TRUE = 9,
    FALSE = 10,
    RETURN = 11,
    IF = 12,
    ELSE = 13,
    WHILE = 14,
    BREAK = 15,
    CONTINUE = 16, 
    SC = 17,
    COMMA = 18,
    LPAREN = 19,
    RPAREN = 20,
    LBRACE = 21,
    RBRACE = 22,
    ASSIGN = 23,
    RELOP = 24,
    BINOP = 25,
    COMMENT = 26,
    ID = 27,
    NUM = 28,
    STRING = 29,
	OVERRIDE = 30,
	COMMENT_CR_EOF = 31
  };

  enum error
  {
      UNCLOSED_STRING = -1,
      UNDEFINED_ESC_SEQ = -2,
      UNMATCHED_TOKEN = -3,
      UNDEFINED_ESC_SEQ_X = -4
  };

  extern int yylineno;
  extern char* yytext;
  extern unsigned long yyleng; // instead of int
  extern int yylex();
#endif /* TOKENS_HPP_ */
