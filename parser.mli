type token =
  | EOL
  | MINUS
  | PLUS
  | ABS
  | NOT
  | MULT
  | DIV
  | POW
  | EQUAL
  | N_EQUAL
  | LESS_T
  | GREATER_T
  | LESS
  | GREATER
  | MOD
  | REM
  | AND
  | OR
  | XOR
  | AND_THEN
  | OR_ELSE
  | L_PAR
  | R_PAR
  | COMMA
  | SEMICOLON
  | COLON
  | L_ID
  | R_ID
  | NULL
  | ASS
  | LOOP
  | END_LOOP
  | Int of (int)
  | Float of (int*int)
  | IntExp of (int*bool*int)
  | FloatExp of (int*int*bool*int)
  | BaseInt of (int*string)
  | BaseFloat of (int*string*string)
  | BaseIntExp of (int*string*bool*int)
  | BaseFloatExp of (int*string*string*bool*int)
  | Base of (int)
  | Hex of (string)
  | String of (string)
  | Id of (string)
  | QualId of (string)

val s :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Ast.expression