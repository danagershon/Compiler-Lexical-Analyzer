#include "tokens.hpp"
#include <iostream>

void printToken(const std::string &token_name, const char* token_text = yytext,int lineno = yylineno);

void printToken(const std::string &token_name, const char* token_text = yytext,int lineno = yylineno){
    std::cout << lineno << " " << token_name << " " << token_text << "\n";
}

char* STR_BUF = NULL;

int main()
{
    int token;
	while ((token = yylex())) {
	    switch(token) {
	        case VOID:
                printToken("VOID");
                break;
	        case INT:
                printToken("INT");
	            break;
	        case BYTE:
                printToken("BYTE");
	            break;
	        case B:{
                printToken("B","b");
                break;
	        }
	        case BOOL:
                printToken("BOOL");
	            break;
	        case AND:
                printToken("AND");
	            break;
	        case OR:
                printToken("OR");
	            break;
	        case NOT:
                printToken("NOT");
	            break;
	        case TRUE:
                printToken("TRUE");
	            break;
	        case FALSE:
                printToken("FALSE");
	            break;
	        case RETURN:
                printToken("RETURN");
	            break;
	        case IF:
                printToken("IF");
	            break;
	        case ELSE:
                printToken("ELSE");
	            break;
	        case WHILE:
                printToken("WHILE");
	            break;
	        case BREAK:
                printToken("BREAK");
	            break;
	        case CONTINUE:
                printToken("CONTINUE");
	            break;
	        case SC:
                printToken("SC");
	            break;
	        case COMMA:
                printToken("COMMA");
	            break;
	        case LPAREN:
                printToken("LPAREN");
	            break;
	        case RPAREN:
                printToken("RPAREN");
	            break;
	        case LBRACE:
                printToken("LBRACE");
	            break;
	        case RBRACE:
                printToken("RBRACE");
	            break;
	        case ASSIGN:
                printToken("ASSIGN");
	            break;
	        case RELOP:
                printToken("RELOP");
	            break;
	        case BINOP:
                printToken("BINOP");
	            break;
	        case COMMENT:
                printToken("COMMENT","//",yylineno-1);
	            break;
	        case COMMENT_CR_EOF:
                printToken("COMMENT","//");
	            break;
	        case ID:
                printToken("ID");
	            break;
	        case NUM:
                printToken("NUM");
	            break;
	        case STRING:
                printToken("STRING",STR_BUF);
                free(STR_BUF);
				STR_BUF = NULL;
	            break;
	        case OVERRIDE:
                printToken("OVERRIDE");
	            break;
	    	case UNCLOSED_STRING:
				std::cout << "Error unclosed string\n";
				exit(0);
	    	case UNDEFINED_ESC_SEQ_X:
				std::cout << "Error undefined escape sequence " << yytext+1 << '\n';
				exit(0);
	    	case UNDEFINED_ESC_SEQ:
				std::cout << "Error undefined escape sequence " << yytext << '\n';
				exit(0);
	    	case UNMATCHED_TOKEN:
				std::cout << "Error " << yytext << "\n";
                exit(0);
            default:
                break;
        }
	}

	return 0;
}
