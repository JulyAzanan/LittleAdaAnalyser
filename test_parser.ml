open Ast;;

let lexbuf = Lexing.from_channel stdin

let _ =
  while true do
    let a = Parser.s (Lex.decoupe) lexbuf in
    let _ = match a with 
      (* | (_, Ass(_, b)) -> (
          match b with 
          |String(s) -> print_string s
          |Const(Int(n)) -> print_int n
          |Const(Float(n, d)) -> Format.printf "%i.%i@." n d
          |_ -> print_string "nique" 
        )
      |  *)_ ->  print_string "issou" 
    in
    print_newline ()
  done