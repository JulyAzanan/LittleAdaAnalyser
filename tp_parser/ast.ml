type ast =
  | Plus of ast * ast
  | Fois of ast * ast
  | Let of ast * ast * ast
  | Cte of int
  | Id of string

     
let print_sep l =
  List.iter print_string l

let rec print_sep_spec = function
  | [] -> ()
  | [x] -> print_string "|-"
  | x :: q -> print_string x; print_sep_spec q
    
let rec aff_aux l a =
  print_sep_spec l;
  match a with
  | Plus(a1, a2) ->
     print_string "Plus\n";
    print_sep (l @ ["|\n"]);
    aff_aux (l @ ["| "]) a1;
    print_sep (l @ ["|\n"]);
    aff_aux (l @ ["  "]) a2
  | Fois(a1, a2) ->
     print_string "Fois\n";
    print_sep (l @ ["|\n"]);
    aff_aux (l @ ["| "]) a1;
    print_sep (l @ ["|\n"]);
    aff_aux (l @ ["  "]) a2
  | Let(Id(s), a2, a3) -> 
    print_string (s^"\n");
    print_sep (l @ ["|\n"]);
    aff_aux (l @ ["| "]) a2;
    print_sep (l @ ["|\n"]);
    aff_aux (l @ ["  "]) a3;
  | Let(a1, a2, a3) -> assert false
  | Cte i -> Printf.printf "Cte(%i)\n" i
  | Id s -> Printf.printf "Id(%s)\n" s

let affiche = aff_aux []
  
