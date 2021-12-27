all:
	ocamlc -c ast.ml
	ocamllex lex.mll
	ocamlyacc parser.mly
	ocamlc -c parser.mli parser.ml
	ocamlc -c lex.ml
	ocamlc -o test parser.cmo lex.cmo test_parser.ml