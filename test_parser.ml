open Ast;;

let lexbuf = Lexing.from_channel stdin

let _ =
  while true do
    let a = Parser.s (Lex.decoupe) lexbuf in
    let _ = match a with 
      |String(s) -> print_string s
      |Const(Int(n)) -> print_int n
      |_ -> print_string "nique"
  in
    print_newline ()
  done