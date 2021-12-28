all:
	ocamlc -c ast.ml
	ocamllex lex.mll
	ocamlyacc parser.mly
	ocamlc -c parser.mli parser.ml
	ocamlc -c lex.ml
	ocamlc -o test parser.cmo lex.cmo test_parser.ml

test_ok:
	for file in ./projet_little_Ada/OK/*; do echo "$$file"; cat "$$file" | ./test; done

test_ko:
	for file in ./projet_little_Ada/KO/*; do echo "$$file"; cat "$$file" | ./test; done