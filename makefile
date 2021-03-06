all:
	ocamlc -c ast.ml
	ocamllex lex.mll
	ocamlyacc parser.mly
	ocamlc -c ast.cmo parser.mli parser.ml
	ocamlc -c lex.ml
	ocamlc -o test ast.cmo parser.cmo lex.cmo test_parser.ml
	ocamlc -c print_consts.ml
	ocamlc -o test_print_consts ast.cmo parser.cmo lex.cmo print_consts.cmo test_print_consts.ml
	ocamlc -c check_affect.ml
	ocamlc -o test_check_affect ast.cmo parser.cmo lex.cmo check_affect.cmo test_check_affect.ml
	ocamlc -c check_scope.ml
	ocamlc -o test_check_scope ast.cmo parser.cmo lex.cmo check_scope.cmo test_check_scope.ml
	ocamlc -o main ast.cmo parser.cmo lex.cmo print_consts.cmo check_affect.cmo check_scope.cmo main.ml

test_ok:
	for file in ./projet_little_Ada/OK/*; do echo "$$file"; cat "$$file" | ./test; done

test_ko:
	for file in ./projet_little_Ada/KO/*; do echo "$$file"; cat "$$file" | ./test; done

test_affect:
	for file in ./projet_little_Ada/KO/AffMode.ada ./projet_little_Ada/KO/AffIn.ada ./projet_little_Ada/KO/AffConst.ada ./projet_little_Ada/OK/*; do echo "$$file"; cat "$$file" | ./test_check_affect; done

test_scope:
	for file in ./projet_little_Ada/KO/ScopeError.ada ./projet_little_Ada/KO/ScopeError2.ada ./projet_little_Ada/KO/ScopeError3.ada ./projet_little_Ada/KO/ScopeError4.ada ./projet_little_Ada/KO/ScopeGoto.ada ./projet_little_Ada/KO/ScopeFunc.ada ./projet_little_Ada/KO/ScopeProc.ada ./projet_little_Ada/KO/UnknownVariable.ada ./projet_little_Ada/OK/*; do echo "$$file"; cat "$$file" | ./test_check_scope; done

test:
	for file in ./projet_little_Ada/OK/* ./projet_little_Ada/KO/*; do echo "\n\e[1m\e[32mFile:\e[0m $$file"; cat "$$file" | ./main; done

clear:
	rm *.cmo *.cmi

.PHONY: test test_affect test_scope test_ko test_ok
