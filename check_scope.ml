open Ast

module IdSet = Set.Make(String)

let join = String.concat "."

(* let get_param set p = match p with
   | vars, None, _
   | vars, Some(In), _ -> add set vars
   | _ -> set

   let rec check_instr_affect set (_, i) = match i with
   | Ass(id, _) ->
    let id' = join id
    in if IdSet.mem id' set
    then failwith ("Ton père la constante " ^ id')
    else ()
   | Loop(_, i_list)
   | While(_, _, i_list)
   | For(_, _, _, _, i_list) ->
    List.iter (check_instr_affect set) i_list
   | If(_, i1_list, e_i_list, i2_list) ->
    List.iter (check_instr_affect set) i1_list;
    List.iter (
      fun (_, i_list) -> List.iter (check_instr_affect set) i_list
    ) e_i_list;
    List.iter (check_instr_affect set) i2_list
   | Case(_, c_list) ->
    List.iter (
      fun (_, i_list) -> List.iter (check_instr_affect set) i_list
    ) c_list
   | _ -> ()

   let rec get_declaration set d = match d with
   | Obj(vars, true, _, _) -> add set vars
   | Renames(vars, _, id) ->
    if IdSet.mem (join id) set
    then add set vars
    else set
   | DefProc(_, params, defs, instrs, _)
   | DefFun(_, params, _, defs, instrs, _) ->
    let set' = List.fold_left get_param set params
    in let set'' = List.fold_left get_declaration set' defs
    in List.iter (check_instr_affect set'') instrs; set''
   | _ -> set;; *)

let add e set =
  if IdSet.mem e set
  then print_string ("Ton oncle redéfinition de " ^ e ^ "\n");
  IdSet.add e set

let add_list l set = List.fold_left
    (fun acc id -> add id acc) set l
let inspect e set =
  if not (IdSet.mem e set)
  then failwith ("ta soeur le scope bordel : " ^ e)

let inspect_list l set =
  List.iter (fun e -> inspect e set) l

let step_into scope set =
  if scope <> ""
  then IdSet.map (fun id -> scope ^ "." ^ id) set
  else set
let change_scope var typ func proc scope new_scope =
  (
    step_into scope var,
    step_into scope typ,
    step_into scope func,
    step_into scope proc,
    if scope <> "" then scope ^ "." ^ new_scope else new_scope
  )

let check_param_scope (var, typ) (vars, _, t) =
  inspect (join t) typ;
  (add_list vars var, typ)

(* TODO *)
let check_expr_scope var func e = ();;

(* TODO *)
let rec check_instr_scope (var, typ, func, proc, scope) i =
  (var, typ, func, proc, scope)
let check_type_scope var func typ t = match t with
  | (id, None) -> inspect id typ
  | (id, Some(e1, e2)) ->
    check_expr_scope var func e1;
    check_expr_scope var func e2;
    inspect id typ

let rec check_decl_scope (var, typ, func, proc, scope) d = match d with
  | Obj(id, _, t, e) ->
    let var = add (join id) var
    in let _ = (
        match t with
        | Some(t) -> check_type_scope var func typ t
        | _ -> ()
      ) in check_expr_scope var func e;
    (var, typ, func, proc, scope)
  | Type(t) -> 
    let typ = (
      match t with
      | (id, None) -> add id typ
      | (id, Some(e1, e2)) ->
        check_expr_scope var func e1;
        check_expr_scope var func e2;
        add id typ
    ) in (var, typ, func, proc, scope)
  | SubType(id, t) ->
    check_type_scope var func typ t;
    let typ = add id typ
    in (var, typ, func, proc, scope)
  | Renames(ids, t, id) ->
    inspect (join id) var;
    check_type_scope var func typ t;
    let var = add_list ids var
    in (var, typ, func, proc, scope)
  | Proc(id, params) ->
    let (var, typ) = List.fold_left check_param_scope (var, typ) params
    in (var, typ, func, proc, scope)
  | Fun(id, params, t) ->
    inspect (join t) typ;
    let (var, typ) = List.fold_left check_param_scope (var, typ) params
    in (var, typ, func, proc, scope)
  | DefProc(id, params, defs, instrs, _) ->
    let proc = add id proc
    in let (var, typ) =
         List.fold_left check_param_scope (var, typ) params
    in let (var, typ, func, proc, _) =
         List.fold_left check_decl_scope (var, typ, func, proc, "") defs
    in let _ = List.fold_left check_instr_scope
           (change_scope var typ func proc scope id) instrs
    in (var, typ, func, proc, scope)
  | DefFun(id, params, t, defs, instrs, _) ->
    inspect (join t) typ;
    let func = add id func
    in let (var, typ) =
         List.fold_left check_param_scope (var, typ) params
    in let (var, typ, func, proc, _) =
         List.fold_left check_decl_scope (var, typ, func, proc, "") defs
    in let _ = List.fold_left check_instr_scope
           (change_scope var typ func proc scope id) instrs
    in (var, typ, func, proc, scope)

let check_file_scope var typ func proc f = match f with
  | TopDefProc(id, params, defs, instrs, _) ->
    let proc = add id proc
    in let (var, typ) =
         List.fold_left check_param_scope (var, typ) params
    in let (var, typ, func, proc, _) =
         List.fold_left check_decl_scope (var, typ, func, proc, "") defs
    in List.fold_left check_instr_scope
      (change_scope var typ func proc "" id) instrs

  | TopDefFun(id, params, t, defs, instrs, _) ->
    inspect (join t) typ;
    let func = add id func
    in let (var, typ) =
         List.fold_left check_param_scope (var, typ) params
    in let (var, typ, func, proc, _) =
         List.fold_left check_decl_scope (var, typ, func, proc, "") defs
    in List.fold_left check_instr_scope
      (change_scope var typ func proc "" id) instrs

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

let check_scope a = check_file_scope globalVars globalTypes IdSet.empty globalProcs a
