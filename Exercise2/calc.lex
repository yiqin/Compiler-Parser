%option noyywrap

%{
#include "heading.h"
#include "tok.h"
int yyerror(char *s);
%}


%%

"int" {
	yylval.type_val = Type::INT; return TYPE_INT;
}

"string" {
	yylval.type_val = Type::STRING; return TYPE_STRING;
}

[A-Za-z_][A-Za-z0-9_]* { 
	yylval.string_val = new std::string(yytext); return IDENT; 
}

";"		{ yylval.string_val = new std::string(yytext); return SEMICOLON; }
","     { yylval.string_val = new std::string(yytext); return COMMA; }
"("		{ yylval.string_val = new std::string(yytext); return LEFT_PARENTHESIS; }
")"		{ yylval.string_val = new std::string(yytext); return RIGHT_PARENTHESIS; }

[ \t]*		{}
[\n]		{ yylineno++;	}

.		{ std::cerr << "SCANNER "; yyerror(""); exit(1);	}

