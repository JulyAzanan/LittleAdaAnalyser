open Ast
open Check_affect

let lexbuf = Lexing.from_channel stdin

let _ =

  let file = (Parser.s (Lex.decoupe) lexbuf)
  in check_affect file