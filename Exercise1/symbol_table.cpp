#include "symbol_table.h"

void Symbol_Table::add (std::string key, int value) {
	m[key] = value;
}

int Symbol_Table::get_value(std::string key) {
	return m[key];
}

bool Symbol_Table::is_variable_defined (std::string key) {
	if (m.find(key) != m.end()) {
		return true;
	} else {
		return false;
	}
}
