{
    open Parser;;

    (*Fonction de conversion de string -> int*)
    let parse_int s = 0;;
    let parse_sign s = true;;
    let normalize = String.lowercase_ascii;;
}
rule decoupe = parse
    | [' ''\t'] {decoupe lexbuf}
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
    | "and"[' ''\t']+"then" {AND_THEN}
    | "or"[' ''\t']+"else" {OR_ELSE}
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
    | "end"[' ''\t']+"loop" {END_LOOP}
    | ['0'-'9']('_'?['0'-'9'])* as n {Int(parse_int n)}
    | (['0'-'9']('_'?['0'-'9'])* as n)'.'(['0'-'9']('_'?['0'-'9'])* as d) {Float(parse_int n, parse_int d)}
    | (['0'-'9']('_'?['0'-'9'])* as n)['e''E'](['+''-']? as s)(['0'-'9']('_'?['0'-'9'])* as e) {IntExp(parse_int n, parse_sign s, parse_int e)}
    | (['0'-'9']('_'?['0'-'9'])* as n)'.'(['0'-'9']('_'?['0'-'9'])* as d)['e''E'](['+''-']? as s)(['0'-'9']('_'?['0'-'9'])* as e) {FloatExp(parse_int n, parse_int d, parse_sign s, parse_int e)}
    | (['2'-'9']|'1''_'?['0'-'6'] as b)'#'(['0'-'9''a'-'f''A'-'F']('_'?['0'-'9''a'-'f''A'-'F'])* as h)'#'  {BaseInt(parse_int b, h)}
    | (['2'-'9']|'1''_'?['0'-'6'] as b)'#'(['0'-'9''a'-'f''A'-'F']('_'?['0'-'9''a'-'f''A'-'F'])* as h)'.'(['0'-'9''a'-'f''A'-'F']('_'?['0'-'9''a'-'f''A'-'F'])* as d)'#' {BaseFloat(parse_int b, h, d)}
    | (['2'-'9']|'1''_'?['0'-'6'] as b)'#'(['0'-'9''a'-'f''A'-'F']('_'?['0'-'9''a'-'f''A'-'F'])* as h)'#'['e''E'](['+''-']? as s)(['0'-'9']('_'?['0'-'9'])* as e) {BaseIntExp(parse_int b, h, parse_sign s, parse_int e)}
    | (['2'-'9']|'1''_'?['0'-'6'] as b)'#'(['0'-'9''a'-'f''A'-'F']('_'?['0'-'9''a'-'f''A'-'F'])* as h)'.'(['0'-'9''a'-'f''A'-'F']('_'?['0'-'9''a'-'f''A'-'F'])* as d)'#'['e''E'](['+''-']? as s)(['0'-'9']('_'?['0'-'9'])* as e) {BaseFloatExp(parse_int b, h, d, parse_sign s, parse_int e)}
    | ['a'-'z''A'-'Z']('_'?['a'-'z''A'-'Z''0'-'9'])* as s {Id(normalize s)}
    | (['a'-'z''A'-'Z']('_'?['a'-'z''A'-'Z''0'-'9'])* as s)'.' {QualId(normalize s)}
    | '"'([^'"''\n']* as s)'"' {String(s)}
{

}