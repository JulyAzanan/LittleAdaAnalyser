open Ast

module VarSet = Set.Make(String)

let add = List.fold_left
    (fun acc id -> VarSet.add id acc)

let join = String.concat "."

let get_param set p = match p with
  | vars, None, _
  | vars, Some(In), _ -> add set vars
  | _ -> set

let rec check_instr_affect set (_, i) = match i with
  | Ass(id, _) ->
    let id' = join id
    in if VarSet.mem id' set
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
    if VarSet.mem (join id) set
    then add set vars
    else set
  | DefProc(_, params, defs, instrs, _)
  | DefFun(_, params, _, defs, instrs, _) ->
    let set' = List.fold_left get_param set params
    in let set'' = List.fold_left get_declaration set' defs
    in List.iter (check_instr_affect set'') instrs; set''
  | _ -> set

let check_file_affect set f = match f with
  | TopDefProc(_, params, defs, instrs, _)
  | TopDefFun(_, params, _, defs, instrs, _) ->
    let set' = List.fold_left get_param set params
    in let set'' = List.fold_left get_declaration set' defs
    in List.iter (check_instr_affect set'') instrs; set''

let check_affect a = ignore(check_file_affect VarSet.empty a)