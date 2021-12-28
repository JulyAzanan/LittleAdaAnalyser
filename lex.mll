{
    open Parser;;

    (*Fonction de conversion de string -> int*)
    let parse_int s = 0;;
    let parse_sign s = true;;
    let normalize = String.lowercase_ascii;;
}
let whitespace = [' ''\t']+
let int = ['0'-'9']('_'?['0'-'9'])*
let base = ['2'-'9']|'1''_'?['0'-'6']
let hex = ['0'-'9''a'-'f''A'-'F']
let sign = ['+''-']?
let id = ['a'-'z''A'-'Z']('_'?['a'-'z''A'-'Z''0'-'9'])*
rule decoupe = parse
    | whitespace {decoupe lexbuf}
    | "--"[^'\n']*'\n' {decoupe lexbuf}
    | '\n' {EOL}
    | "abs" {ABS}
    | "not" {NOT}
    | '-' {MINUS}
    | '+' {PLUS}
    | '*' {MULT}
    | '/' {DIV}
    | "**" {POW}
    | '=' {EQUAL}
    | "/=" {N_EQUAL}
    | "<=" {LESS_T}
    | ">=" {GREATER_T}
    | '>' {LESS}
    | '<' {GREATER}
    | "mod" {MOD}
    | "rem" {REM}
    | "and" {AND}
    | "or" {OR}
    | "xor" {XOR}
    | "and"whitespace"then" {AND_THEN}
    | "or"whitespace"else" {OR_ELSE}
    | '(' {L_PAR}
    | ')' {R_PAR}
    | ',' {COMMA}
    | ';' {SEMICOLON}
    | ':' {COLON}
    | "<<" {L_ID}
    | ">>" {R_ID}
    | ":=" {ASS}
    | "null" {NULL}
    | "loop" {LOOP}
    | "end"whitespace"loop" {END_LOOP} (* factoriser end ? *)
    | "while" {WHILE}
    | "for" {FOR}
    | "in" {IN}
    | ".." {SEQUENCE}
    | "reverse" {REVERSE}
    | "if" {IF}
    | "then" {THEN}
    | "else" {ELSE}
    | "elsif" {ELSIF}
    | "end"whitespace"if" {END_IF}
    | "case" {CASE}
    | "is" {IS}
    | "when" {WHEN}
    | "=>" {ARROW}
    | "others" {OTHERS}
    | "end"whitespace"case" {END_CASE}
    | "|" {PIPE}
    | "goto" {GOTO}
    | "exit" {EXIT}
    | "return" {RETURN}
    | "range" {RANGE}
    | "constant" {CONSTANT}
    | "type" {TYPE}
    | "is"whitespace"range" {IS_RANGE}
    | "subtype" {SUBTYPE}
    | "renames" {RENAMES}
    | "procedure" {PROCEDURE}
    | "in" {IN}
    | "out" {OUT}
    | "in"whitespace"out" {IN_OUT}
    | "function" {FUNCTION}
    | "begin" {BEGIN}
    | "end" {END}
    | int as n {Int(parse_int n)}
    | (int as n)'.'(int as d) {Float(parse_int n, parse_int d)}
    | (int as n)['e''E'](sign as s)(int as e) {IntExp(parse_int n, parse_sign s, parse_int e)}
    | (int as n)'.'(int as d)['e''E'](sign as s)(int as e) {FloatExp(parse_int n, parse_int d, parse_sign s, parse_int e)}
    | (base as b)'#'(hex('_'?hex)* as h)'#'  {BaseInt(parse_int b, h)}
    | (base as b)'#'(hex('_'?hex)* as h)'.'(hex('_'?hex)* as d)'#' {BaseFloat(parse_int b, h, d)}
    | (base as b)'#'(hex('_'?hex)* as h)'#'['e''E'](sign as s)(int as e) {BaseIntExp(parse_int b, h, parse_sign s, parse_int e)}
    | (base as b)'#'(hex('_'?hex)* as h)'.'(hex('_'?hex)* as d)'#'['e''E'](sign as s)(int as e) {BaseFloatExp(parse_int b, h, d, parse_sign s, parse_int e)}
    | id as s {Id(normalize s)}
    | (id as s)'.' {QualId(normalize s)}
    | '"'([^'"''\n']* as s)'"' {String(s)}
{

}