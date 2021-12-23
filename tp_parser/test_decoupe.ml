let lexbuf = Lexing.from_channel stdin

let _ =
  while true do
    Lexer.decoupe lexbuf
  done
