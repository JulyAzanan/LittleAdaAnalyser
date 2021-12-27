%{
    open Ast;;

    (* TODO *)
%}
%token EOL EXP DOT SHARP QUOTE COMMENT
%token <int> Int
%token <bool> Sign
%token <int> Base
%token <string> Hex
%token <string> String
%left 
%start s
%type<Ast.expression> s
// %type<Ast.file> s
%%
s:
    e EOL {$1}
;
e:
    Int {Const(Int($1))}
    | Int DOT Int {Const(Float($1, $3))}
    | Int EXP Sign Int {Const(IntExp($1, $3, $4))}
    | Int DOT Int EXP Sign Int {Const(FloatExp($1, $3, $5, $6))}
    | Base SHARP Hex SHARP {BaseConst(Int($1, $3))}
    | Base SHARP Hex DOT Hex SHARP {BaseConst(Float($1, $3, $5))}
    | Base SHARP Hex SHARP EXP Sign Int {BaseConst(IntExp($1, $3, $6, $7))}
    | Base SHARP Hex DOT Hex SHARP EXP Sign Int {BaseConst(FloatExp($1, $3, $5, $8, $9))}
    | q {String($1)}    
;
q:
    QUOTE String QUOTE q {$2 ^ "\"" ^ $4}
    | QUOTE String QUOTE {$2}
    