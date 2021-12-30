{
    open Parser
    open String
    open Char
    open Seq

    (*Fonction de conversion de string -> int*)
    let parse_int s =
        Seq.fold_left (
            fun acc c -> match c with
                | '_' -> acc
                | n -> acc * 10 + (Char.code n - 48) 
        ) 0 (String.to_seq s)

    let parse_sign s =
        try String.get s 0 = '+' with Invalid_argument _ -> true

    let normalize s =
        let split = String.split_on_char '_' s
        in let s = String.concat "" split 
        in String.lowercase_ascii s
}
let whitespace = [' ''\t''\r''\n']+
let int = ['0'-'9']('_'?['0'-'9'])*
let base = ['2'-'9']|'1''_'?['0'-'6']
let hex = ['0'-'9''a'-'f''A'-'F']
let sign = ['+''-']?
let id = ['a'-'z''A'-'Z']('_'?['a'-'z''A'-'Z''0'-'9'])*
rule decoupe = parse
    | eof {EOF}
    | whitespace {decoupe lexbuf}
    | "--"[^'\n']*'\n' {decoupe lexbuf}
    (* | '\n'|"\r\n" {EOL} *)
    | "abs"|"ABS" {ABS}
    | "not"|"NOT" {NOT}
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
    | "mod"|"MOD" {MOD}
    | "rem"|"REM" {REM}
    | "and"|"AND" {AND}
    | "or"|"OR" {OR}
    | "xor"|"XOR" {XOR}
    | "and"whitespace"then"|"AND_THEN" {AND_THEN}
    | "or"whitespace"else"|"OR_ELSE" {OR_ELSE}
    | '(' {L_PAR}
    | ')' {R_PAR}
    | ',' {COMMA}
    | ';' {SEMICOLON}
    | ':' {COLON}
    | "<<" {L_ID}
    | ">>" {R_ID}
    | ":=" {ASS}
    | "null"|"NULL" {NULL}
    | "loop"|"LOOP" {LOOP}
    | "end"whitespace"loop"|"END"whitespace"LOOP" {END_LOOP} (* factoriser end ? *)
    | "while"|"WHILE" {WHILE}
    | "for"|"FOR" {FOR}
    | "in"|"IN" {IN}
    | ".." {SEQUENCE}
    | "reverse"|"REVERSE" {REVERSE}
    | "if"|"IF" {IF}
    | "then"|"THEN" {THEN}
    | "else"|"ELSE" {ELSE}
    | "elsif"|"ELSIF" {ELSIF}
    | "end"whitespace"if"|"END"whitespace"IF" {END_IF}
    | "case"|"CASE" {CASE}
    | "is"|"IS" {IS}
    | "when"|"WHEN" {WHEN}
    | "=>" {ARROW}
    | "others"|"OTHERS" {OTHERS}
    | "end"whitespace"case"|"END"whitespace"CASE" {END_CASE}
    | "|" {PIPE}
    | "goto"|"GOTO" {GOTO}
    | "exit"|"EXIT" {EXIT}
    | "return"|"RETURN" {RETURN}
    | "range"|"RANGE" {RANGE}
    | "constant"|"CONSTANT" {CONSTANT}
    | "type"|"TYPE" {TYPE}
    | "is"whitespace"range"|"IS"whitespace"RANGE" {IS_RANGE}
    | "subtype"|"SUBTYPE" {SUBTYPE}
    | "renames"|"RENAMES" {RENAMES}
    | "procedure"|"PROCEDURE" {PROCEDURE}
    | "in"|"IN" {IN}
    | "out"|"OUT" {OUT}
    | "in"whitespace"out"|"IN"whitespace"OUT" {IN_OUT}
    | "function"|"FUNCTION" {FUNCTION}
    | "begin"|"BEGIN" {BEGIN}
    | "end"|"END" {END} 
    | "." {DOT}
    | int as n {Int(parse_int n)}
    | (int as n)'.'(int as d) {Float(parse_int n, parse_int d)}
    | (int as n)['e''E'](sign as s)(int as e) {IntExp(parse_int n, parse_sign s, parse_int e)}
    | (int as n)'.'(int as d)['e''E'](sign as s)(int as e) {FloatExp(parse_int n, parse_int d, parse_sign s, parse_int e)}
    | (base as b)'#'(hex('_'?hex)* as h)'#'  {BaseInt(parse_int b, h)}
    | (base as b)'#'(hex('_'?hex)* as h)'.'(hex('_'?hex)* as d)'#' {BaseFloat(parse_int b, h, d)}
    | (base as b)'#'(hex('_'?hex)* as h)'#'['e''E'](sign as s)(int as e) {BaseIntExp(parse_int b, h, parse_sign s, parse_int e)}
    | (base as b)'#'(hex('_'?hex)* as h)'.'(hex('_'?hex)* as d)'#'['e''E'](sign as s)(int as e) {BaseFloatExp(parse_int b, h, d, parse_sign s, parse_int e)}
    | id as s {Id(normalize s)}
    | '"'([^'"''\n']* as s)'"' {String(s)}
{

}