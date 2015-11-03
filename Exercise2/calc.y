%{
#include "heading.h"
int yyerror(char *s);
int yylex(void);
Symbol_Table symbol_table;

%}

%union{
  int		int_val;
  string*	string_val;
  Type type_val;
  Argument* argument;
  vector<Argument*>* argument_list;
}


%start	s_expression 

%token	<int_val>	INTEGER_LITERAL
%token <string_val> IDENT

%type <argument_list> l_expression
%type <argument> p_expression
%type <type_val> type_expression


%left	TYPE_INT
%left TYPE_STRING


%left SEMICOLON
%left COMMA
%left LEFT_PARENTHESIS
%left RIGHT_PARENTHESIS


%%

s_expression:
		| d_expression	{ 
      }
    | s_expression d_expression { }
		;


d_expression:
      type_expression IDENT LEFT_PARENTHESIS l_expression RIGHT_PARENTHESIS SEMICOLON {
        
        cout << "Function: " << *$2 << endl;
        cout << "Type: " << ($1== Type::INT ? "int" : "string") << endl;

        ostringstream oss;
        oss << "Arguments: ";
        for (auto& argument : *$4) {
          oss << argument->get_name() << "(" << argument->get_type_str() << ")" << ", ";
        }
        cout << oss.str() << endl;
      }
    | type_expression IDENT LEFT_PARENTHESIS RIGHT_PARENTHESIS SEMICOLON {
        cout << "Function: " << *$2 << endl;
        cout << "Type: " << ($1== Type::INT ? "int" : "string") << endl;
        cout << "No arguments" << endl;
    }
    ;


l_expression:
      l_expression COMMA p_expression {
        $$ = $1;
        $$->push_back($3);
      }
    | p_expression {
        vector<Argument*> *tmp = new vector<Argument*>();
        $$ = tmp;
        $$->push_back($1);
      }
    ;


p_expression:
    | type_expression IDENT {
        Argument *new_argument = new Argument();
        new_argument->set_name(*$2);
        new_argument->set_type($1);

        $$ = new_argument;  
      }
    ;


type_expression:
      TYPE_INT { 
        // cout << "type int" << endl;
        $$ = Type::INT;
      }
    | TYPE_STRING {
        // cout << "type string" << endl;
        $$ = Type::STRING;
      }
    ;

%%

int yyerror(string s)
{
  extern int yylineno;	// defined and maintained in lex.c
  extern char *yytext;	// defined and maintained in lex.c
  
  cerr << "ERROR: " << s << " at symbol \"" << yytext;
  cerr << "\" on line " << yylineno << endl;
  exit(1);
}

int yyerror(char *s)
{
  return yyerror(string(s));
}


