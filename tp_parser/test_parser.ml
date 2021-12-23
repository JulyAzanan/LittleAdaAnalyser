open Ast

let lexbuf = Lexing.from_channel stdin

let rec check_scope a = 
    let rec aux a id = match a with
      |Id(s) -> s = id
      |Cte(_) -> false
      |Plus(a1, a2) -> (aux a1 id) || (aux a2 id)
      |Fois(a1, a2) -> (aux a1 id) || (aux a2 id)
      |Let(_, a1, a2) -> (aux a1 id) || (aux a2 id)
      |_ -> false
in match a with
  |Id(_) -> true
  |Cte(_) -> true
  |Plus(a1, a2) -> check_scope a1 && check_scope a2
  |Fois(a1, a2) -> check_scope a1 && check_scope a2
  |Let(Id(s), a2, a3) -> (aux a3 s) && check_scope a2 && check_scope a3
  |_ -> false

let _ =
  while true do
    let a = Parser.s (Lexer.decoupe) lexbuf in
    if check_scope a then Ast.affiche a
    else begin
      Printf.printf "Mauvais scope\n";
      Ast.affiche a;
    end;
    print_newline ()
  done

