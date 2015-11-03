#include "symbol_table.h"

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
