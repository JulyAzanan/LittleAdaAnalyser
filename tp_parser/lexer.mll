{
    open Parser;;
}
rule decoupe = parse
    | '+' {PLUS}
    | '*' {FOIS}
    | ' ''='' ' {EQ}
    | '(' {LPAR}
    | ')' {RPAR}
    | '\n' {EOL}
    (* | (' '|'\t')+ {} *)
    | ['0'-'9']+ as i {Cte(int_of_string i)}
    | 'l''e''t'' ' {LET}
    | ' ''i''n'' ' {IN}
    | ['a'-'z''A'-'Z''_']['a'-'z''A'-'Z''0'-'9''_']* as id {Id(id)}
{

}
