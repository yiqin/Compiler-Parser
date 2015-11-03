#ifndef SYMBOL_TABLE_H
#define SYMBOL_TABLE_H

#include <string>
#include <map>
#include <iostream>

enum class Type {
    INT,
    STRING,
};

class Argument
{
public:
	const std::string get_name() {
		return name;
	}
	const void set_name(std::string value) {
		name = value;
	}
	const Type get_type() {
		return type;
	}
	const void set_type(Type value) {
		type = value;
	}
	const std::string get_type_str() {
		if (type == Type::INT) {
			return "int";
		} else {
			return "string";
		}
	}
	std::string name;
	Type type;
};

class Symbol_Table
{
public:
	const void add (std::string key, std::string value) {
		m[key] = value;
	};
	const std::string get_value (std::string key) {
		return m[key];
	};
	const bool is_variable_defined (std::string key) {
		if (m.find(key) != m.end()) {
			return true;
		} else {
			return false;
		}
	};
	const void check_coherency_declaration(std::string function_name, std::string argument_list_str) {
		if (is_variable_defined(function_name)) {
			std::string previous_argument_list_str = get_value(function_name);
			if (previous_argument_list_str.compare(argument_list_str) != 0) {
				std::cout << "ERROR: " << function_name << " has the same name and different arguements" << endl;
			}
		} else {
			add(function_name, argument_list_str);
		}
	}
protected:
	std::map<std::string, std::string> m;
};

#endif