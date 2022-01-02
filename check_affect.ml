open Ast

module IdSet = Set.Make(String)

exception ConstantAffectation of string

(**
  @requires \nothing
  @ensures the items are added to the set
*)
let add = List.fold_left
    (fun acc id -> IdSet.add id acc)

(**
  @requires \nothing
  @ensures the resulting string is a qualified id
  @raise [Invalid_argument] if the result is longer than [Sys.max_string_length]
*)
let join = String.concat "."

(**
  @requires \nothing
  @ensures parameters with no keywords or the [In] keword are added to the set
*)
let get_param set p = match p with
  | vars, None, _
  | vars, Some(In), _ -> add set vars
  | _ -> set

(**
  @requires \nothing
  @ensures the instruction constants are processed
  @raises [ConstantAffectation] if a constant is reassigned
*)
let rec check_instr_affect set (_, i) = match i with
  | Ass(id, _) ->
    let id' = join id
    in if IdSet.mem id' set
    then raise (ConstantAffectation id')
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

(**
  @requires \nothing
  @ensures the declaration constants are processed
  @raises [ConstantAffectation] if a constant is reassigned
*)
let rec get_declaration set d = match d with
  | Obj(vars, true, _, _) -> add set vars
  | DefProc(_, params, defs, instrs, _)
  | DefFun(_, params, _, defs, instrs, _) ->
    let set = List.fold_left get_param set params
    in let set = List.fold_left get_declaration set defs
    in List.iter (check_instr_affect set) instrs; set
  | _ -> set

(**
  @requires \nothing
  @ensures the file constants are processed
  @raises [ConstantAffectation] if a constant is reassigned
*)
let check_file_affect set f = match f with
  | TopDefProc(_, params, defs, instrs, _)
  | TopDefFun(_, params, _, defs, instrs, _) ->
    let set = List.fold_left get_param set params
    in let set = List.fold_left get_declaration set defs
    in List.iter (check_instr_affect set) instrs

(**
  @requires \nothing
  @ensures the AST constants are processed
  @raises [ConstantAffectation] if a constant is reassigned
*)
let check_affect a = check_file_affect IdSet.empty a
