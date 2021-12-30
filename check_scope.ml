open Ast

module IdSet = Set.Make(String)

let join = String.concat "."

let add e set =
  if IdSet.mem e set
  then print_string ("Ton oncle redéfinition de " ^ e ^ "\n");
  IdSet.add e set

let add_list l set = List.fold_left
    (fun acc id -> add id acc) set l
let inspect s set =
  if not (IdSet.mem s set)
  then failwith ("ta soeur le scope bordel : " ^ s)

let inspect_list l set =
  List.iter (fun e -> inspect e set) l

let step_into scope set =
  if scope <> ""
  then let newSet = IdSet.map (fun id -> scope ^ "." ^ id) set
    in IdSet.union newSet set
  else set
let change_scope var typ func proc lab scope new_scope =
  (
    step_into scope var,
    step_into scope typ,
    step_into scope func,
    step_into scope proc,
    lab,
    if scope <> "" then scope ^ "." ^ new_scope else new_scope
  )

let check_param_scope (var, typ) (vars, _, t) =
  inspect (join t) typ;
  (add_list vars var, typ)

let rec check_expr_scope var func e = match e with
  | Id(s) -> inspect s var
  | QualId(s) -> inspect (join s) var
  | Negate(e)
  | Abs(e)
  | Not(e)
  | Parent(e) -> check_expr_scope var func e
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
    check_expr_scope var func e1;
    check_expr_scope var func e2
  | Fun(id, e_list) ->
    inspect (join id) func;
    List.iter (check_expr_scope var func) e_list
  | _ -> ()

let check_choice_scope var func c = match c with
  | Expression(e) -> check_expr_scope var func e
  | Seq(e1, e2) -> check_expr_scope var func e1;
    check_expr_scope var func e2
  | Others -> ()

let check_type_scope var func typ t = match t with
  | (id, None) -> inspect id typ
  | (id, Some(e1, e2)) ->
    check_expr_scope var func e1;
    check_expr_scope var func e2;
    inspect id typ

let rec check_instr_scope (var, typ, func, proc, lab, scope) (labels, i) =
  List.iter (fun l -> inspect l lab) labels;
  let lab = add_list labels lab
  in match i with
  | Ass(id, e) ->
    check_expr_scope var func e;
    inspect (join id) var;
    (var, typ, func, proc, lab, scope)
  | Proc(id, e_list) ->
    List.iter (check_expr_scope var func) e_list;
    let var = add (join id) var
    in (var, typ, func, proc, lab, scope)
  | Loop(_, i_list) ->
    List.fold_left check_instr_scope (var, typ, func, proc, lab, scope) i_list
  | While(_, e, i_list) -> 
    check_expr_scope var func e; 
    List.fold_left check_instr_scope (var, typ, func, proc, lab, scope) i_list
  | For(_, id, _, iter, i_list) -> 
    let var = add id var
    in let _ = (
        match iter with
        | Seq(e1, e2) ->
          check_expr_scope var func e1;
          check_expr_scope var func e2;
        | Type(t) -> check_type_scope var func typ t
      )
    in List.fold_left check_instr_scope (var, typ, func, proc, lab, scope) i_list
  | If(e, i1_list, e_i_list, i2_list) ->
    let sets = List.fold_left check_instr_scope (var, typ, func, proc, lab, scope) i1_list
    in let sets = List.fold_left (
        fun acc (e, i_list) ->
          check_expr_scope var func e;
          List.fold_left check_instr_scope acc i_list
      ) sets e_i_list
    in let sets = List.fold_left check_instr_scope sets i2_list
    in sets
  | Case(e, c_i_list) ->
    check_expr_scope var func e;
    List.fold_left (
      fun acc (c_list, i_list) ->
        List.iter (check_choice_scope var func) c_list;
        check_expr_scope var func e;
        List.fold_left check_instr_scope acc i_list
    ) (var, typ, func, proc, lab, scope) c_i_list
  | Exit(_, Some(e)) ->
    check_expr_scope var func e;
    (var, typ, func, proc, lab, scope)
  | ProcFun(e) ->
    check_expr_scope var func e;
    (var, typ, func, proc, lab, scope)
  | Goto(s) -> inspect s lab;
    (var, typ, func, proc, lab, scope) 
  | _ -> (var, typ, func, proc, lab, scope) 

let rec check_proc_scope (var, typ, func, proc, lab, scope) id params defs instrs = 
  let (var', _) =
    List.fold_left check_param_scope (var, typ) params
  in let (_, typ', func', proc', _, _) =
       List.fold_left check_decl_scope (var', typ, func, proc, lab, "") defs
  in let _ = List.fold_left check_instr_scope
         (change_scope var' typ' func' proc' lab scope id) instrs
  in (var, typ, func, proc, lab, scope)

and check_decl_scope (var, typ, func, proc, lab, scope) d = match d with
  | Obj(id, _, t, e) ->
    let var = add (join id) var
    in let _ = (
        match t with
        | Some(t) -> check_type_scope var func typ t
        | _ -> ()
      ) in let _ = (
        match e with
        | Some(e) -> check_expr_scope var func e
        | _ -> ()
      ) in (var, typ, func, proc, lab, scope)
  | Type(t) -> 
    let typ = (
      match t with
      | (id, None) -> add id typ
      | (id, Some(e1, e2)) ->
        check_expr_scope var func e1;
        check_expr_scope var func e2;
        add id typ
    ) in (var, typ, func, proc, lab, scope)
  | SubType(id, t) ->
    check_type_scope var func typ t;
    let typ = add id typ
    in (var, typ, func, proc, lab, scope)
  | Renames(ids, t, id) ->
    inspect (join id) var;
    check_type_scope var func typ t;
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
    (IdSet.add "bool"
       (IdSet.add "float" IdSet.empty))

let globalProcs =
  IdSet.add "Put"
    (IdSet.add "NewLine" IdSet.empty)

let check_scope a = ignore(check_file_scope globalVars globalTypes IdSet.empty globalProcs IdSet.empty a)
