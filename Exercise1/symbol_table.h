#include <string>
#include <map>

class Symbol_Table
{
	
public:
	std::map<std::string, int> m;
	void add (std::string, int);
	int get_value (std::string);
	bool is_variable_defined (std::string);

};