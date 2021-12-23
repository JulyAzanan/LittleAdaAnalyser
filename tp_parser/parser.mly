%{
    open Ast;;
%}
%token EOL PLUS FOIS RPAR LPAR LET EQ IN
%token <int> Cte
%token <string> Id
%left PLUS
%left FOIS
%left IN
%start s
%type<Ast.ast> s
%%
s:
    e EOL {$1}
;
e:
    e PLUS e {Plus($1, $3)}
    |e FOIS e {Fois($1, $3)}
    |LET Id EQ e IN e {Let(Id($2), $4, $6)}
    |LPAR e RPAR {$2}
    |Cte {Cte($1)}
    |Id {Id($1)}
;
