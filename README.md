# Compiler-Parser

### Exercise 1
Write	a	simple	interface	(API),	for	a	symbol	table	adapted	to	this	calculator.
Example:	is_variable_defined:	return	true	if	the	variable	has	been	initialized.

Grammer:
```
S -> I ; S | ε
I -> ident := E | E | ε
E -> E + T | E - T | T
T -> T * F | T / F | F
F -> ident | const | ( E )
```


### Exercise 2
Write	a	parser	analyzing	the	function	declaration	and	displaying:

Function:	foo <br />
Type:	int <br />
Arguments:	a	(int),	b	(string) <br />

In	the	case	of	a	second	declaration	of	the	same	function,	we	want	to check	the	coherency	of	the	declaration	and	display	error	messages	if	the	function has the	same	name	and	different	arguments.

Grammer:
```
S -> D | S D
D -> T ident ( L  ) ; | T ident ( ) ;
L -> P | L, P
P -> T ident
T -> int | string
```
