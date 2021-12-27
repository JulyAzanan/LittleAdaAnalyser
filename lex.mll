{
    open Parser;;

    (*Fonction de conversion de string -> int*)
    let parse_int s = 0;;
    let parse_sign s = true;;
    let normalize s = "";;
}
rule decoupe = parse
    | '\n' {EOL}
    | "{--}"[^'\n']*'\n' {COMMENT}
    | ['0'-'9'](['0'-'9']*|(['0'-'9''_']['0'-'9'])*)* as n {Int(parse_int n)}
    | ['e''E'] {EXP}
    | '.' {DOT}
    | ['+''-']? as s {Sign(parse_sign s)}
    | ['2'-'9']|'1''_'?['0'-'6'] as n {Base(parse_int n)}
    | '#' {SHARP}
    | ['0'-'9''a'-'f''A'-'F'](['0'-'9''a'-'f''A'-'F']*|(['0'-'9''a'-'f''A'-'F''_']['0'-'9''a'-'f''A'-'F'])*)* as s {Hex(s)}
    | '"' {QUOTE}
    | [^'"''\n']* as s {String(s)}
{

}