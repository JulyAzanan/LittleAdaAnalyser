type token =
  | EOL
  | PLUS
  | FOIS
  | RPAR
  | LPAR
  | LET
  | EQ
  | IN
  | Cte of (int)
  | Id of (string)

val s :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Ast.ast
