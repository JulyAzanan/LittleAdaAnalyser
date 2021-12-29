open Ast
open Print_consts

let lexbuf = Lexing.from_channel stdin

let _ =

  let file = (Parser.s (Lex.decoupe) lexbuf)
  in print_consts file