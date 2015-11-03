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
  vector<string*>* argument_list;
}

%start	s_expression 

%token	<int_val>	INTEGER_LITERAL
%token <string_val> IDENT

%type <argument_list> l_expression
%type <string_val> p_expression
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
          oss << *argument << ", ";
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
        cout << " ====== (int)" << endl;
      }
    | p_expression {
        vector<string*> *tmp = new vector<string*>();
        $$ = tmp;
        $$->push_back($1);
        cout << " ====== (int)" << endl;
      }
    ;

p_expression:
    | type_expression IDENT {
        // $$ = $2;
        // string* type_str;
        if ($1 == Type::INT) {
          // *type_str = *$2 + " (int)";
          cout << *$2 << " (int)" << endl;
        } else {
          // *type_str = *$2 + " (string)";
          cout << *$2 << " (string)" << endl;
        }
        // std::string buf($2);
        // buf.append(two);
        $$ = $2;  
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


