open Ast

exception OutOfRadix of char
exception OutOfBase of int * int

(**
@requires \nothing
@ensures convert a bool to a sign (true = +1 and false = -1)
*)
let sign s = if s then 1. else -1.

(**
@requires \nothing
@ensures convert a char (0-9 or a-f) to the corresponding int
@raises OutOfRadix 
*)
let parse_char c = match c with
  | '0' -> 0
  | '1' -> 1
  | '2' -> 2
  | '3' -> 3
  | '4' -> 4
  | '5' -> 5
  | '6' -> 6
  | '7' -> 7
  | '8' -> 8
  | '9' -> 9
  | 'a' | 'A' -> 10
  | 'b' | 'B' -> 11
  | 'c' | 'C' -> 12
  | 'd' | 'D' -> 13
  | 'e' | 'E' -> 14
  | 'f' | 'F' -> 15
  | _ -> raise (OutOfRadix c)

(**
@requires \nothing
@ensures parse a string representing an int written in base base to the corresponding int
@raises OutOfBase 
*)
let parse_int s base =
  Seq.fold_left (
    fun acc c -> match c with
      | '_' -> acc
      | n ->
        let m = parse_char n
        in if m > base
        then raise (OutOfBase (base, m))
        else acc * base +  m
  ) 0 (String.to_seq s)

(**
@requires \nothing 
@ensures convert a const Float(int, int) to a float
*)
let const_float_to_float i d =
  let dd = ceil (log10 (float_of_int d))
  in float_of_int i +. (float_of_int d /. (10. ** dd))

(**
@requires \nothing 
@ensures convert a const IntExp(int, bool, int) to a float in the corresponding base
*)
let const_intexp_to_float i sgn e b = 
  float_of_int i *. (b ** ((sign sgn) *. float_of_int e))

(**
@requires \nothing 
@ensures convert a const FloatExp(int, int, bool, int) to a float in the corresponding base
*)
let const_floatexp_to_float i d sgn e b =
  let dd = ceil (log10 (float_of_int d))
  in let x = float_of_int i +. (float_of_int d /. (10. ** dd)) in
  x *. (b ** ((sign sgn) *. float_of_int e))

(**
@requires \nothing 
@ensures DFS of a tree on the root to reach the constants
*)
let rec print_consts a = match a with
  | TopDefProc(_, _, defs, instrs, _) | TopDefFun(_, _, _, defs, instrs, _) ->
    List.iter print_def_consts defs;
    List.iter print_instr_consts instrs

(**
@requires \nothing 
@ensures DFS of tree on the declarations to reach the constants
*)
and print_def_consts d = match d with
  | Obj(_, _, Some(t), None) -> 
    print_type_consts t;
  | Obj(_, _, None, Some(e)) -> 
    print_expr_consts e
  | Obj(_, _, Some(t), Some(e)) -> 
    print_type_consts t;
    print_expr_consts e
  | Type(t) ->
    print_type_consts t;
  | SubType(_, t) -> print_def_consts (Type(t))
  | Renames(_, t, _) -> print_def_consts (Type(t))
  | DefProc(_, _, d, i, _) | DefFun(_, _, _, d, i, _) ->
    let _ = List.iter print_def_consts d in
    List.iter print_instr_consts i
  | _ -> ()

(**
@requires \nothing 
@ensures DFS of a tree on the instructions to reach the constants
*)
and print_instr_consts (_, i) =  match i with
  | Ass(_, e) -> print_expr_consts e
  | Proc(_, e_list) -> List.iter print_expr_consts e_list
  | Loop(_, i_list) -> List.iter print_instr_consts i_list
  | While(_, e, i_list) ->
    print_expr_consts e;
    List.iter print_instr_consts i_list
  | For(_, _, _, it, i_list) ->
    print_iter_consts it;
    List.iter print_instr_consts i_list
  | If(e, i1_list, e_i_list, i2_list) ->
    print_expr_consts e;
    List.iter print_instr_consts i1_list;
    List.iter (
      fun (e, i_list) ->
        print_expr_consts e;
        List.iter print_instr_consts i_list
    ) e_i_list;
    List.iter print_instr_consts i2_list;
  | Case(e, c_i_list) ->
    print_expr_consts e;
    List.iter (
      fun (c_list, i_list) ->
        List.iter print_choice_consts c_list;
        List.iter print_instr_consts i_list
    ) c_i_list
  | Exit(_, Some(e)) -> print_expr_consts e
  | ProcFun(e) -> print_expr_consts e
  | _ -> ()

(**
@requires \nothing 
@ensures DFS of a tree on the iterators to reach the constants
*)
and print_iter_consts it = match it with
  | Seq(e1, e2) ->
    print_expr_consts e1;
    print_expr_consts e2;
  | Type(t) -> print_type_consts t

(**
@requires \nothing 
@ensures DFS of a tree on the types to reach the constants
*)
and print_type_consts (_, ee) = match ee with
  | Some(e1, e2) -> 
    print_expr_consts e1;
    print_expr_consts e2;
  | _ -> ()

(**
@requires \nothing 
@ensures DFS of a tree on the choices to reach the constants
*)
and print_choice_consts c = match c with
  |Expression(e) -> print_expr_consts e
  |  Seq(e1, e2) ->
    print_expr_consts e1;
    print_expr_consts e2;
  | Others -> ()

(**
@requires \nothing 
@ensures DFS of a tree on the expressions to reach the constants
*)
and print_expr_consts e = match e with
  | String(s) ->
    print_string s;
    print_newline ();
  | Const(c) -> print_const c
  | BaseConst(c) -> print_base_const c
  | Negate(e)
  | Abs(e)
  | Not(e)
  | Parent(e) -> print_expr_consts e
  | Plus(e1, e2)
  | Minus(e1, e2)
  | Mult(e1, e2)
  | Div(e1, e2)
  | Pow(e1, e2)
  | Equal(e1, e2)
  | NEqual(e1, e2)
  | LessT(e1, e2)
  | GreaterT(e1, e2)
  | Less(e1, e2)
  | Greater(e1, e2)
  | Mod(e1, e2)
  | Rem(e1, e2)
  | And(e1, e2)
  | Or(e1, e2)
  | Xor(e1, e2)
  | AndThen(e1, e2)
  | OrElse(e1, e2) ->
    print_expr_consts e1;
    print_expr_consts e2
  | Fun(_, e_list) -> List.iter print_expr_consts e_list
  | _ -> ()

(**
@requires \nothing 
@ensures prints the numeric constants after converting them
*)
and print_const c = 
  begin
    match c with
    | Int(i) -> print_int i
    | Float(i,d) ->
      let x = const_float_to_float i d in print_float x
    | IntExp(i, sgn, e) ->
      let x = const_intexp_to_float i sgn e 10. in print_float x 
    | FloatExp(i, d, sgn, e) ->
      let y = const_floatexp_to_float i d sgn e 10. in print_float y
  end;  
  print_newline ()

(**
@requires \nothing 
@ensures print the numeric constants in base after converting them
*)
and print_base_const c =
  begin
    match c with
    | Int(b, i) ->
      let x = parse_int i b in print_int x
    | Float(b, i, d) ->
      let i' = parse_int i b 
      in let d' = parse_int d b 
      in let x = const_float_to_float i' d'
      in print_float x
    | IntExp(b, i, sgn, e) ->
      let i' = parse_int i b 
      in let x = const_intexp_to_float i' sgn e (float_of_int b)
      in print_float x
    | FloatExp(b, i, d, sgn, e) ->
      let i' = parse_int i b 
      in let d' = parse_int d b 
      in let y = const_floatexp_to_float i' d' sgn e (float_of_int b)
      in print_float y
  end;
  print_newline ()

