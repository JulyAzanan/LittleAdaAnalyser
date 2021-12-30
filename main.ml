open Ast
open Print_consts
open Check_affect
open Check_scope

let main =
  let lexbuf = Lexing.from_channel stdin
  in let file = (Parser.s (Lex.decoupe) lexbuf)
  in let _ = print_string "\n\x1b[1m\x1b[36mConstants\x1b[0m\n"
in let _ = print_consts file
in let _ = print_string "\n\x1b[1m\x1b[36mAffectations\x1b[0m\n"
in let _ = check_affect file
in let _ = print_string "\n\x1b[1m\x1b[36mScope\x1b[0m\n"
  in check_scope file
