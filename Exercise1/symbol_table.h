class Symbol_Table
{
	
public:
	map<string, int> m;
	void add (string, int);
	int get_value (string);
	bool is_variable_defined (string);

};