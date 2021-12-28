open Ast;;

let lexbuf = Lexing.from_channel stdin

let _ =
  
    try (let a = Parser.s (Lex.decoupe) lexbuf in
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
    print_newline ())
    with exn ->
      begin
        let curr = lexbuf.Lexing.lex_curr_p in
        let line = curr.Lexing.pos_lnum in
        let cnum = curr.Lexing.pos_cnum - curr.Lexing.pos_bol in
        let tok = Lexing.lexeme lexbuf in
        Format.printf "line: %i\nnum: %i\ntoken: %s\n" line (cnum+1) tok
      end
  