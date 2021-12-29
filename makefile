all:
	ocamlc -c ast.ml
	ocamllex lex.mll
	ocamlyacc parser.mly
	ocamlc -c parser.mli parser.ml
	ocamlc -c lex.ml
	ocamlc -o test parser.cmo lex.cmo test_parser.ml
	ocamlc -c print_consts.ml
	ocamlc -o test_print_consts parser.cmo lex.cmo print_consts.cmo test_print_consts.ml

test_ok:
	for file in ./projet_little_Ada/OK/*; do echo "$$file"; cat "$$file" | ./test; done

test_ko:
	for file in ./projet_little_Ada/KO/*; do echo "$$file"; cat "$$file" | ./test; done
