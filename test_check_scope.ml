open Ast
open Check_scope

let lexbuf = Lexing.from_channel stdin

let _ =
  let file = (Parser.s (Lex.decoupe) lexbuf)
  in check_scope file
