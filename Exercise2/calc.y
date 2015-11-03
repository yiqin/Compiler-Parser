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

// S -> D | S D
s_expression:
		| d_expression	{ 
      }
    | s_expression d_expression { }
		;

// D -> T ident ( L ) ; | T ident ( ) ;
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

        ostringstream arguments_type_list_str;
        for (auto& argument : *$4) {
          arguments_type_list_str << argument->get_type_str() << ", ";
        }
        // Question 2:
        symbol_table.check_coherency_declaration(*$2, arguments_type_list_str.str());
      }

    | type_expression IDENT LEFT_PARENTHESIS RIGHT_PARENTHESIS SEMICOLON {

        cout << "Function: " << *$2 << endl;
        cout << "Type: " << ($1== Type::INT ? "int" : "string") << endl;
        cout << "No arguments" << endl;
        // Question 2:
        symbol_table.check_coherency_declaration(*$2, "");
    }
    ;

// L -> P | L , P
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

// P -> T ident
p_expression:
    | type_expression IDENT {
        Argument *new_argument = new Argument();
        new_argument->set_name(*$2);
        new_argument->set_type($1);

        $$ = new_argument;  
      }
    ;

// T -> int | string
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


