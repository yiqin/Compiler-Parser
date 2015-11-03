/* main.cc */

#include "heading.h"

// prototype of bison-generated parser function
int yyparse();

int main(int argc, char **argv)
{
  if ((argc > 1) && (freopen(argv[1], "r", stdin) == NULL))
  {
    cerr << argv[0] << ": File " << argv[1] << " cannot be opened.\n";
    exit( 1 );
  }
  
  yyparse();

  return 0;
}



class Symbol_Table
{
	
public:
	std::map<std::string, int> m;
	void add (std::string, int);
	int get_value (std::string);
	bool is_variable_defined (std::string);

};

void Symbol_Table::add (string key, int value) {
	m[key] = value;
}

int Symbol_Table::get_value(string key) {
	return m[key];
}

bool Symbol_Table::is_variable_defined (string key) {
	if (m.find(key) != m.end()) {
		return true;
	} else {
		return false;
	}
}

