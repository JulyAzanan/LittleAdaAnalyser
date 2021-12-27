type token =
  | EOL
  | EXP
  | DOT
  | SHARP
  | QUOTE
  | COMMENT
  | Int of (int)
  | Sign of (bool)
  | Base of (int)
  | Hex of (string)
  | String of (string)

val s :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Ast.expression
