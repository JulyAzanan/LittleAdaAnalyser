%{
    open Ast;;

    (* TODO *)
%}
%token EOL MINUS PLUS ABS NOT MULT DIV POW EQUAL N_EQUAL LESS_T GREATER_T LESS GREATER MOD REM AND OR XOR AND_THEN OR_ELSE L_PAR R_PAR COMMA SEMICOLON COLON L_ID R_ID NULL ASS LOOP END_LOOP 
%token <int> Int
%token <int*int> Float
%token <int*bool*int> IntExp
%token <int*int*bool*int> FloatExp
%token <int*string> BaseInt
%token <int*string*string> BaseFloat
%token <int*string*bool*int> BaseIntExp
%token <int*string*string*bool*int> BaseFloatExp
%token <int> Base
%token <string> Hex
%token <string> String
%token <string> Id
%token <string> QualId
%left XOR AND OR AND_THEN OR_ELSE
%left EQUAL N_EQUAL LESS_T GREATER_T LESS GREATER
%left MINUS PLUS
%left MULT DIV MOD REM
%left POW NOT ABS
%left R_PAR
%right L_PAR
%start s
%type<Ast.expression> s
// %type<Ast.file> s
%%
s:
    e EOL {$1}
;
e:
    Int {Const(Int($1))}
    | Float {let (a,b) = $1 in Const(Float(a, b))}
    | IntExp {let (a, b, c) = $1 in Const(IntExp(a, b, c))}
    | FloatExp {let (a, b, c, d) = $1 in Const(FloatExp(a, b, c, d))}
    | BaseInt {let (a, b) = $1 in BaseConst(Int(a, b))}
    | BaseFloat {let (a, b, c) = $1 in BaseConst(Float(a, b, c))}
    | BaseIntExp {let (a, b, c, d) = $1 in BaseConst(IntExp(a, b, c, d))}
    | BaseFloatExp {let (a, b, c, d, e) = $1 in BaseConst(FloatExp(a, b, c, d, e))}
    | string {String($1)} 
    | qual_id {match $1 with 
        |[x] -> Id(x)
        |_ -> QualId($1)}
    | MINUS e {Negate($2)}
    | ABS e {Abs($2)}
    | NOT e {Not($2)}
    | e MINUS e {Minus($1, $3)}
    | e PLUS e {Plus($1, $3)}
    | e MULT e {Mult($1, $3)}
    | e DIV e {Div($1, $3)}
    | e POW e {Pow($1, $3)}
    | e EQUAL e {Equal($1, $3)}
    | e N_EQUAL e {NEqual($1, $3)}
    | e LESS_T e {LessT($1, $3)}
    | e GREATER_T e {GreaterT($1, $3)}
    | e LESS e {Less($1, $3)}
    | e GREATER e {Greater($1, $3)}
    | e MOD e {Mod($1, $3)}
    | e REM e {Rem($1, $3)}
    | e AND e {And($1, $3)}
    | e OR e {Or($1, $3)}
    | e XOR e {Xor($1, $3)}
    | e AND_THEN e {AndThen($1, $3)}
    | e OR_ELSE e {OrElse($1, $3)}
    | L_PAR e R_PAR {Parent($2)}
    | qual_id L_PAR e_sep R_PAR {Fun($1, $3)}
;
string:
    String string {$1 ^ "\"" ^ $2}
    | String {$1}
;
qual_id:
    QualId qual_id {$1::$2}
    | Id {[$1]}
;
e_sep:
    e COMMA e_sep {$1::$3}
    | e {[$1]}
;
i:
    L_ID Id R_ID i {let Instr(a, b) = $4 in Instr($2::a, b)}
    | i_ {Instr([],$1)}
;
i_:
    NULL SEMICOLON {Null}
    | qual_id ASS e SEMICOLON {Ass($1, $3)}
    | qual_id SEMICOLON {Proc($1, [])}
    | qual_id L_PAR e_sep R_PAR SEMICOLON {Proc($1, $3)}
    | Id COLON LOOP i_rec END_LOOP SEMICOLON {Loop($1, $4)}
    | Id COLON LOOP i_rec END_LOOP Id SEMICOLON {if $1 <> $6 then failwith "ID Loop pas pareil zbfuiyvzftezvy" else Loop($1, $4)}
;
i_rec: 
    i_ i_rec {$1::$2}
    | i_ {[$1]}