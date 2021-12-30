%{
    open Ast

    let check_distinct_ids i1 i2 e =
        if i1 <> i2
        then raise (DistinctIdentifiers (i2, i2))
        else e

    let explicit_op_pow e1 e2 e =
        match (e1, e2) with
            | Parent(_), _ | _, Parent(_)
            | Const(_), _ | BaseConst(_), _
            | Id(_), _ | QualId(_), _ -> e
            | _ -> raise (MixedOperators e)
    
    let explicit_op_compare e1 e2 e =
        match (e1, e2) with
            | Parent(_), _ | _, Parent(_)
            | Const(_), _ | BaseConst(_), _
            | Id(_), _ | QualId(_), _ 
            | Minus(_), _ | Plus(_), _
            | Mult(_), _ | Div(_), _
            | Mod(_), _ | Rem(_), _
            | Pow(_), _ | Not(_), _ | Abs(_), _ -> e
            | _ -> raise (MixedOperators e)
    
    let explicit_op_bool e1 e2 e =
        match (e1, e2) with
            | Parent(_), _ | _, Parent(_)
            | Const(_), _ | BaseConst(_), _
            | Id(_), _ | QualId(_), _ 
            | Minus(_), _ | Plus(_), _
            | Mult(_), _ | Div(_), _
            | Mod(_), _ | Rem(_), _
            | Pow(_), _ | Not(_), _ | Abs(_), _
            | Equal(_), _ | NEqual(_), _
            | LessT(_), _ | GreaterT(_), _
            | Less(_), _ | Greater(_), _ -> e
            | _ -> raise (MixedOperators e)

%}
%token MINUS PLUS ABS NOT MULT DIV POW EQUAL
%token N_EQUAL LESS_T GREATER_T LESS GREATER MOD
%token REM AND OR XOR AND_THEN OR_ELSE L_PAR R_PAR
%token COMMA SEMICOLON COLON L_ID R_ID NULL ASS
%token LOOP END_LOOP WHILE FOR IN SEQUENCE REVERSE
%token IF THEN ELSE ELSIF END_IF CASE IS WHEN
%token ARROW OTHERS END_CASE PIPE GOTO EXIT RETURN
%token RANGE CONSTANT TYPE IS_RANGE SUBTYPE RENAMES
%token PROCEDURE IN OUT IN_OUT FUNCTION BEGIN END
%token DOT EOF EOL
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
%type<Ast.file> s
%%
s: top_def EOF {$1}
;
e: Int {Const(Int($1))}
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
    | e POW e {explicit_op_pow $1 $3 (Pow($1, $3))}
    | e EQUAL e {match $1 with Equal(_) -> Equal($1, $3) | _ -> explicit_op_compare $1 $3 (Equal($1, $3))}
    | e N_EQUAL e {match $1 with NEqual(_) -> NEqual($1, $3) | _ -> explicit_op_compare $1 $3 (NEqual($1, $3))}
    | e LESS_T e {match $1 with LessT(_) -> LessT($1, $3) | _ -> explicit_op_compare $1 $3 (LessT($1, $3))}
    | e GREATER_T e {match $1 with GreaterT(_) -> GreaterT($1, $3) | _ -> explicit_op_compare $1 $3 (GreaterT($1, $3))}
    | e LESS e {match $1 with Less(_) -> Less($1, $3) | _ -> explicit_op_compare $1 $3 (Less($1, $3))}
    | e GREATER e {match $1 with Greater(_) -> Greater($1, $3) | _ -> explicit_op_compare $1 $3 (Greater($1, $3))}
    | e MOD e {Mod($1, $3)}
    | e REM e {Rem($1, $3)}
    | e AND e {match $1 with And(_) -> And($1, $3) | _ -> explicit_op_bool $1 $3 (And($1, $3))}
    | e OR e {match $1 with Or(_) -> Or($1, $3) | _ -> explicit_op_bool $1 $3 (Or($1, $3))}
    | e XOR e {match $1 with Xor(_) -> Xor($1, $3) | _ -> explicit_op_bool $1 $3 (Xor($1, $3))}
    | e AND_THEN e {match $1 with AndThen(_) -> AndThen($1, $3) | _ -> explicit_op_bool $1 $3 (AndThen($1, $3))}
    | e OR_ELSE e {match $1 with OrElse(_) -> OrElse($1, $3) | _ -> explicit_op_bool $1 $3 (OrElse($1, $3))}
    | L_PAR e R_PAR {Parent($2)}
    | qual_id L_PAR e_sep R_PAR {Fun($1, $3)}
;
string: String string {$1 ^ "\"" ^ $2}
    | String {$1}
;
qual_id: Id DOT qual_id {$1::$3}
    | Id {[$1]}
;
e_sep: e COMMA e_sep {$1::$3}
    | e {[$1]}
;
i: L_ID Id R_ID i {let (a, b) = $4 in ($2::a, b)}
    | i_ {([],$1)}
;
i_: NULL SEMICOLON {Null}
    | qual_id ASS e SEMICOLON {Ass($1, $3)}
    | qual_id SEMICOLON {Proc($1, [])}
    | qual_id L_PAR e_sep R_PAR SEMICOLON {Proc($1, $3)}
    | LOOP i_seq END_LOOP SEMICOLON {Loop(None, $2)}
    | Id COLON LOOP i_seq END_LOOP SEMICOLON {Loop(Some($1), $4)}
    | Id COLON LOOP i_seq END_LOOP Id SEMICOLON {if $1 <> $6 then raise (DistinctIdentifiers ($1, $6)) else Loop(Some($1), $4)}
    | WHILE e LOOP i_seq END_LOOP SEMICOLON {While(None, $2, $4)}
    | Id COLON WHILE e LOOP i_seq END_LOOP SEMICOLON {While(Some($1), $4, $6)}
    | Id COLON WHILE e LOOP i_seq END_LOOP Id SEMICOLON {if $1 <> $8 then raise (DistinctIdentifiers ($1, $8)) else While(Some($1), $4, $6)}
    | FOR Id IN e SEQUENCE e LOOP i_seq END_LOOP SEMICOLON {For(None, $2, false, Seq($4, $6), $8)}
    | Id COLON FOR Id IN e SEQUENCE e LOOP i_seq END_LOOP SEMICOLON {For(Some($1), $4, false, Seq($6, $8), $10)}
    | Id COLON FOR Id IN e SEQUENCE e LOOP i_seq END_LOOP Id SEMICOLON {if $1 <> $12 then raise (DistinctIdentifiers ($1, $12)) else For(Some($1), $4, false, Seq($6, $8), $10)}
    | FOR Id IN REVERSE e SEQUENCE e LOOP i_seq END_LOOP SEMICOLON {For(None, $2, true, Seq($5, $7), $9)}
    | Id COLON FOR Id IN REVERSE e SEQUENCE e LOOP i_seq END_LOOP SEMICOLON {For(Some($1), $4, true, Seq($7, $9), $11)}
    | Id COLON FOR Id IN REVERSE e SEQUENCE e LOOP i_seq END_LOOP Id SEMICOLON {if $1 <> $13 then raise (DistinctIdentifiers ($1, $13)) else For(Some($1), $4, true, Seq($7, $9), $11)}
    | FOR Id IN t LOOP i_seq END_LOOP SEMICOLON {For(None, $2, false, Type($4), $6)}
    | Id COLON FOR Id IN t LOOP i_seq END_LOOP SEMICOLON {For(Some($1), $4, false, Type($6), $8)}
    | Id COLON FOR Id IN t LOOP i_seq END_LOOP Id SEMICOLON {if $1 <> $10 then raise (DistinctIdentifiers ($1, $10)) else For(Some($1), $4, false, Type($6), $8)}
    | FOR Id IN REVERSE t LOOP i_seq END_LOOP SEMICOLON {For(None, $2, true, Type($5), $7)}
    | Id COLON FOR Id IN REVERSE t LOOP i_seq END_LOOP SEMICOLON {For(Some($1), $4, true, Type($7), $9)}
    | Id COLON FOR Id IN REVERSE t LOOP i_seq END_LOOP Id SEMICOLON {if $1 <> $11 then raise (DistinctIdentifiers ($1, $11)) else For(Some($1), $4, true, Type($7), $9)}
    | IF e THEN i_seq END_IF SEMICOLON {If($2, $4, [], [])}
    | IF e THEN i_seq ELSE i_seq END_IF SEMICOLON {If($2, $4, [], $6)}
    | IF e THEN i_seq else_if END_IF SEMICOLON {If($2, $4, $5, [])}
    | IF e THEN i_seq else_if ELSE i_seq END_IF SEMICOLON {If($2, $4, $5, $7)}
    | CASE e IS when_seq END_CASE SEMICOLON {Case($2, $4)}
    | GOTO Id SEMICOLON {Goto($2)}
    | EXIT SEMICOLON {Exit(None, None)}
    | EXIT Id SEMICOLON {Exit(Some($2), None)}
    | EXIT WHEN e SEMICOLON {Exit(None, Some($3))}
    | EXIT Id WHEN e SEMICOLON {Exit(Some($2), Some($4))}
    | RETURN SEMICOLON {ProcReturn}
    | RETURN e SEMICOLON {ProcFun($2)}
;
i_seq: i i_seq {$1::$2}
    | i {[$1]}
;
else_if: ELSIF e THEN i_seq else_if {($2, $4)::$5}
    | ELSIF e THEN i_seq {[($2, $4)]}
;
when_seq: WHEN choix_seq ARROW i_seq when_seq {($2, $4)::$5}
    | WHEN choix_seq ARROW i_seq {[($2, $4)]}
;
choix_seq: choix PIPE choix_seq {$1::$3}
    | choix {[$1]}
;
choix: e {Expression($1)}
    | e SEQUENCE e {Seq($1, $3)}
    | OTHERS {Others}
;
t: Id {($1, None)}
    | Id RANGE e SEQUENCE e {($1, Some($3, $5))}
;
d: id_sep COLON SEMICOLON {Obj($1, false, None, None)}
    | id_sep COLON CONSTANT SEMICOLON {Obj($1, true, None, None)}
    | id_sep COLON t SEMICOLON {Obj($1, false, Some($3), None)}
    | id_sep COLON CONSTANT t SEMICOLON {Obj($1, true, Some($4), None)}
    | id_sep COLON t def SEMICOLON {Obj($1, false, Some($3), Some($4))}
    | id_sep COLON CONSTANT t def SEMICOLON {Obj($1, true, Some($4), Some($5))}
    | id_sep COLON def SEMICOLON {Obj($1, false, None, Some($3))}
    | id_sep COLON CONSTANT def SEMICOLON {Obj($1, true, None, Some($4))}
    | TYPE Id IS_RANGE e SEQUENCE e SEMICOLON {Type($2, Some($4, $6))}
    | SUBTYPE Id IS t SEMICOLON {SubType($2, $4)}
    | id_sep COLON t RENAMES qual_id SEMICOLON {Renames($1, $3, $5)}
    | PROCEDURE Id SEMICOLON {Proc($2, [])}
    | PROCEDURE Id L_PAR param_seq R_PAR SEMICOLON {Proc($2, $4)}
    | FUNCTION Id RETURN qual_id SEMICOLON {Fun($2, [], $4)}
    | FUNCTION Id L_PAR param_seq R_PAR RETURN qual_id SEMICOLON {Fun($2, $4, $7)}
    | PROCEDURE Id IS BEGIN i_seq END SEMICOLON {DefProc($2, [], [], $5, None)}
    | PROCEDURE Id L_PAR param_seq R_PAR IS BEGIN i_seq END SEMICOLON {DefProc($2, $4, [], $8, None)}
    | FUNCTION Id RETURN qual_id IS BEGIN i_seq END SEMICOLON {DefFun($2, [], $4, [], $7, None)}
    | FUNCTION Id L_PAR param_seq R_PAR RETURN qual_id IS BEGIN i_seq END SEMICOLON {DefFun($2, $4, $7, [], $10, None)}
    | PROCEDURE Id IS d_seq BEGIN i_seq END SEMICOLON {DefProc($2, [], $4, $6, None)}
    | PROCEDURE Id L_PAR param_seq R_PAR IS d_seq BEGIN i_seq END SEMICOLON {DefProc($2, $4, $7, $9, None)}
    | FUNCTION Id RETURN qual_id IS d_seq BEGIN i_seq END SEMICOLON {DefFun($2, [], $4, $6, $8, None)}
    | FUNCTION Id L_PAR param_seq R_PAR RETURN qual_id IS d_seq BEGIN i_seq END SEMICOLON {DefFun($2, $4, $7, $9, $11, None)}
    | PROCEDURE Id IS BEGIN i_seq END Id SEMICOLON {check_distinct_ids $2 $7 (DefProc($2, [], [], $5, Some($7)))}
    | PROCEDURE Id L_PAR param_seq R_PAR IS BEGIN i_seq END Id SEMICOLON {check_distinct_ids $2 $10 (DefProc($2, $4, [], $8, Some($10)))}
    | FUNCTION Id RETURN qual_id IS BEGIN i_seq END Id SEMICOLON {check_distinct_ids $2 $9 (DefFun($2, [], $4, [], $7, Some($9)))}
    | FUNCTION Id L_PAR param_seq R_PAR RETURN qual_id IS BEGIN i_seq END Id SEMICOLON {check_distinct_ids $2 $12 (DefFun($2, $4, $7, [], $10, Some($12)))}
    | PROCEDURE Id IS d_seq BEGIN i_seq END Id SEMICOLON {check_distinct_ids $2 $8 (DefProc($2, [], $4, $6, Some($8)))}
    | PROCEDURE Id L_PAR param_seq R_PAR IS d_seq BEGIN i_seq END Id SEMICOLON {check_distinct_ids $2 $11 (DefProc($2, $4, $7, $9, Some($11)))}
    | FUNCTION Id RETURN qual_id IS d_seq BEGIN i_seq END Id SEMICOLON {check_distinct_ids $2 $10 (DefFun($2, [], $4, $6, $8, Some($10)))}
    | FUNCTION Id L_PAR param_seq R_PAR RETURN qual_id IS d_seq BEGIN i_seq END Id SEMICOLON {check_distinct_ids $2 $13 (DefFun($2, $4, $7, $9, $11, Some($13)))}
;  
top_def: PROCEDURE Id IS BEGIN i_seq END SEMICOLON {TopDefProc($2, [], [], $5, None)}
    | PROCEDURE Id L_PAR param_seq R_PAR IS BEGIN i_seq END SEMICOLON {TopDefProc($2, $4, [], $8, None)}
    | FUNCTION Id RETURN qual_id IS BEGIN i_seq END SEMICOLON {TopDefFun($2, [], $4, [], $7, None)}
    | FUNCTION Id L_PAR param_seq R_PAR RETURN qual_id IS BEGIN i_seq END SEMICOLON {TopDefFun($2, $4, $7, [], $10, None)}
    | PROCEDURE Id IS d_seq BEGIN i_seq END SEMICOLON {TopDefProc($2, [], $4, $6, None)}
    | PROCEDURE Id L_PAR param_seq R_PAR IS d_seq BEGIN i_seq END SEMICOLON {TopDefProc($2, $4, $7, $9, None)}
    | FUNCTION Id RETURN qual_id IS d_seq BEGIN i_seq END SEMICOLON {TopDefFun($2, [], $4, $6, $8, None)}
    | FUNCTION Id L_PAR param_seq R_PAR RETURN qual_id IS d_seq BEGIN i_seq END SEMICOLON {TopDefFun($2, $4, $7, $9, $11, None)}
    | PROCEDURE Id IS BEGIN i_seq END Id SEMICOLON {check_distinct_ids $2 $7 (TopDefProc($2, [], [], $5, Some($7)))}
    | PROCEDURE Id L_PAR param_seq R_PAR IS BEGIN i_seq END Id SEMICOLON {check_distinct_ids $2 $10 (TopDefProc($2, $4, [], $8, Some($10)))}
    | FUNCTION Id RETURN qual_id IS BEGIN i_seq END Id SEMICOLON {check_distinct_ids $2 $9 (TopDefFun($2, [], $4, [], $7, Some($9)))}
    | FUNCTION Id L_PAR param_seq R_PAR RETURN qual_id IS BEGIN i_seq END Id SEMICOLON {check_distinct_ids $2 $12 (TopDefFun($2, $4, $7, [], $10, Some($12)))}
    | PROCEDURE Id IS d_seq BEGIN i_seq END Id SEMICOLON {check_distinct_ids $2 $8 (TopDefProc($2, [], $4, $6, Some($8)))}
    | PROCEDURE Id L_PAR param_seq R_PAR IS d_seq BEGIN i_seq END Id SEMICOLON {check_distinct_ids $2 $11 (TopDefProc($2, $4, $7, $9, Some($11)))}
    | FUNCTION Id RETURN qual_id IS d_seq BEGIN i_seq END Id SEMICOLON {check_distinct_ids $2 $10 (TopDefFun($2, [], $4, $6, $8, Some($10)))}
    | FUNCTION Id L_PAR param_seq R_PAR RETURN qual_id IS d_seq BEGIN i_seq END Id SEMICOLON {check_distinct_ids $2 $13 (TopDefFun($2, $4, $7, $9, $11, Some($13)))}
;
id_sep: Id COMMA id_sep {$1::$3}
    |Id {[$1]}
;
def: ASS e {$2}
;
param: id_sep COLON qual_id {($1, None, $3)}
    | id_sep COLON mode qual_id {($1, Some($3), $4)}
;
param_seq: param SEMICOLON param_seq {$1::$3}
    | param {[$1]}
;
mode: IN {In}
    | OUT {Out}
    | IN_OUT {InOut}
;
d_seq: d d_seq {$1::$2}
    | d {[$1]}