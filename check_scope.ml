open Ast

module IdSet = Set.Make(String)

exception LabelRedefinition of string
exception UndefinedIdentifier of string

(**
  @requires \nothing
  @ensures the resulting string is a qualified id
  @raise [Invalid_argument] if the result is longer than [Sys.max_string_length]
*)
let join = String.concat "."

(**
  @requires \nothing
  @ensures the item is added to the set
*)
let add = IdSet.add 

(**
  @requires \nothing
  @ensures the items are added to the set
*)
let add_list l set = List.fold_left
    (fun acc id -> add id acc) set l

(**
  @requires \nothing
  @ensures the items are added to the set
  @raises [LabelRedefinition] if a label is redefined
*)
let add_list_inspect l set = List.fold_left (
    fun acc id ->
      if IdSet.mem id set
      then raise (LabelRedefinition id)
      else add id acc
  ) set l

(**
  @requires \nothing
  @ensures the item is not in the set
  @raises [UndefinedIdentifier] if the item is in the set
*)
let inspect s set =
  if not (IdSet.mem s set)
  then raise (UndefinedIdentifier s)

(**
  @requires \nothing
  @ensures the items are not in the set
  @raises [UndefinedIdentifier] if at least one item is redefined
*)
let inspect_list l set =
  List.iter (fun e -> inspect e set) l

(**
  @requires \nothing
  @ensures the set is updated with the new scope
*)
let step_into scope set =
  if scope <> ""
  then let newSet = IdSet.map (fun id -> scope ^ "." ^ id) set
    in IdSet.union newSet set
  else set

(**
  @requires \nothing
  @ensures the new scope is applied to all sets
*)
let change_scope var typ func proc lab scope new_scope =
  (
    step_into scope var,
    step_into scope typ,
    step_into scope func,
    step_into scope proc,
    lab,
    if scope <> "" then scope ^ "." ^ new_scope else new_scope
  )

(**
  @requires \nothing
  @ensures the sets are processed
*)
let check_param_scope (var, typ) (vars, _, t) =
  inspect (join t) typ;
  (add_list vars var, typ)

(**
  @requires \nothing
  @ensures the sets are processed
*)
let rec check_expr_scope var typ func e = match e with
  | Id(s) -> inspect s var
  | QualId(s) -> inspect (join s) var
  | Negate(e)
  | Abs(e)
  | Not(e)
  | Parent(e) -> check_expr_scope var typ func e
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
    check_expr_scope var typ func e1;
    check_expr_scope var typ func e2
  | Fun(id, e_list) ->
    let id' = (join id)
    in (try inspect id' func with _ -> inspect id' typ);
    List.iter (check_expr_scope var typ func) e_list
  | _ -> ()

(**
  @requires \nothing
  @ensures the sets are processed
*)
let check_choice_scope var typ func c = match c with
  | Expression(e) -> check_expr_scope var typ func e
  | Seq(e1, e2) -> check_expr_scope var typ func e1;
    check_expr_scope var typ func e2
  | Others -> ()

(**
  @requires \nothing
  @ensures the sets are processed
*)
let check_type_scope var typ func t = match t with
  | (id, None) -> inspect id typ
  | (id, Some(e1, e2)) ->
    check_expr_scope var typ func e1;
    check_expr_scope var typ func e2;
    inspect id typ

(**
  @requires \nothing
  @ensures the sets are processed
*)
let rec get_label lab (labels, _) =
  add_list_inspect labels lab

(**
  @requires \nothing
  @ensures the sets are processed and the labels too
*)
let rec check_i_list_scope (var, typ, func, proc, lab, scope) i_list =
  let lab = List.fold_left get_label lab i_list
  in List.fold_left check_instr_scope (var, typ, func, proc, lab, scope) i_list

(**
  @requires \nothing
  @ensures the sets are processed
*)
and check_instr_scope (var, typ, func, proc, lab, scope) (labels, i) =
  match i with
  | Ass(id, e) ->
    check_expr_scope var typ func e;
    inspect (join id) var;
    (var, typ, func, proc, lab, scope)
  | Proc(id, e_list) ->
    inspect (join id) proc;
    (var, typ, func, proc, lab, scope)
  | Loop(_, i_list) ->
    check_i_list_scope (var, typ, func, proc, lab, scope) i_list
  | While(_, e, i_list) -> 
    check_expr_scope var typ func e; 
    check_i_list_scope (var, typ, func, proc, lab, scope) i_list
  | For(_, id, _, iter, i_list) -> 
    let var = add id var
    in let _ = (
        match iter with
        | Seq(e1, e2) ->
          check_expr_scope var typ func e1;
          check_expr_scope var typ func e2;
        | Type(t) -> check_type_scope var typ func t
      )
    in check_i_list_scope (var, typ, func, proc, lab, scope) i_list
  | If(e, i1_list, e_i_list, i2_list) ->
    let sets = check_i_list_scope (var, typ, func, proc, lab, scope) i1_list
    in let sets = List.fold_left (
        fun acc (e, i_list) ->
          check_expr_scope var typ func e;
          check_i_list_scope acc i_list
      ) sets e_i_list
    in let sets = check_i_list_scope sets i2_list
    in sets
  | Case(e, c_i_list) ->
    check_expr_scope var typ func e;
    List.fold_left (
      fun acc (c_list, i_list) ->
        List.iter (check_choice_scope var typ func) c_list;
        check_expr_scope var typ func e;
        check_i_list_scope acc i_list
    ) (var, typ, func, proc, lab, scope) c_i_list
  | Exit(_, Some(e)) ->
    check_expr_scope var typ func e;
    (var, typ, func, proc, lab, scope)
  | ProcFun(e) ->
    check_expr_scope var typ func e;
    (var, typ, func, proc, lab, scope)
  | Goto(s) -> inspect s lab;
    (var, typ, func, proc, lab, scope) 
  | _ -> (var, typ, func, proc, lab, scope) 

(**
  @requires \nothing
  @ensures the sets are processed
*)
let rec check_proc_scope (var, typ, func, proc, lab, scope) id params defs instrs = 
  let (var', _) =
    List.fold_left check_param_scope (var, typ) params
  in let (var', typ', func', proc', _, scope') =
       List.fold_left check_decl_scope (change_scope var' typ func proc lab scope id) defs
  in let _ = check_i_list_scope
         (var', typ', func', proc', lab, scope') instrs
  in (var, typ, func, proc, lab, scope)

(**
  @requires \nothing
  @ensures the sets are processed
*)
and check_decl_scope (var, typ, func, proc, lab, scope) d = match d with
  | Obj(id, _, t, e) ->
    let var = add_list id var
    in let _ = (
        match t with
        | Some(t) -> check_type_scope var typ func t
        | _ -> ()
      ) in let _ = (
        match e with
        | Some(e) -> check_expr_scope var typ func e
        | _ -> ()
      ) in (var, typ, func, proc, lab, scope)
  | Type(t) -> 
    let typ = (
      match t with
      | (id, None) -> add id typ
      | (id, Some(e1, e2)) ->
        check_expr_scope var typ func e1;
        check_expr_scope var typ func e2;
        add id typ
    ) in (var, typ, func, proc, lab, scope)
  | SubType(id, t) ->
    check_type_scope var typ func t;
    let typ = add id typ
    in (var, typ, func, proc, lab, scope)
  | Renames(ids, t, id) ->
    inspect (join id) var;
    check_type_scope var typ func t;
    let var = add_list ids var
    in (var, typ, func, proc, lab, scope)
  | Proc(id, params) ->
    let proc = add id proc
    in let (var, typ) = List.fold_left check_param_scope (var, typ) params
    in (var, typ, func, proc, lab, scope)
  | Fun(id, params, t) ->
    inspect (join t) typ;
    let func = add id func
    in let (var, typ) = List.fold_left check_param_scope (var, typ) params
    in (var, typ, func, proc, lab, scope)
  | DefProc(id, params, defs, instrs, _) ->
    let proc = add id proc
    in check_proc_scope (var, typ, func, proc, lab, scope)
      id params defs instrs
  | DefFun(id, params, t, defs, instrs, _) ->
    inspect (join t) typ;
    let func = add id func
    in check_proc_scope (var, typ, func, proc, lab, scope)
      id params defs instrs

(**
  @requires \nothing
  @ensures the sets are processed
*)
let check_file_scope var typ func proc lab f = match f with
  | TopDefProc(id, params, defs, instrs, _) ->
    let proc = add id proc
    in check_proc_scope (var, typ, func, proc, lab, "")
      id params defs instrs
  | TopDefFun(id, params, t, defs, instrs, _) ->
    inspect (join t) typ;
    let func = add id func
    in check_proc_scope (var, typ, func, proc, lab, "")
      id params defs instrs

let globalVars =
  IdSet.add "true"
    (IdSet.add "false" IdSet.empty)

let globalTypes =
  IdSet.add "integer"
    (IdSet.add "boolean"
       (IdSet.add "float" IdSet.empty))

let globalProcs =
  IdSet.add "put"
    (IdSet.add "newline" 
       (IdSet.add "putline" IdSet.empty)) (* erreur du sujet *)

(**
  @requires \nothing
  @ensures the AST is checked against scope errors
*)
let check_scope a = ignore(check_file_scope globalVars globalTypes IdSet.empty globalProcs IdSet.empty a)
