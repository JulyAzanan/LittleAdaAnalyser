type const = 
  | Int of int
  | Float of int * int (* nombre . nombre*)
  | IntExp of int * bool * int(*nombre e +- nombre rien = + = false*) 
  | FloatExp of int * int * bool * int (*nombre . nombre e +- nombre*)

type baseConst =
  | Int of int * string
  | Float of int * string * string
  | IntExp of int * string * bool * int
  | FloatExp of int * string * string * bool * int

type expression = 
  | Id of string
  | QualId of string list
  | Const of const
  | BaseConst of baseConst
  | String of string
  | Negate of expression
  | Abs of expression
  | Not of expression
  | Plus of expression * expression
  | Minus of expression * expression
  | Mult of expression * expression
  | Div of expression * expression
  | Exp of expression * expression
  | Equal of expression * expression
  | NEqual of expression * expression
  | LessT of expression * expression
  | GreaterT of expression * expression
  | Less of expression * expression
  | Greater of expression * expression
  | Mod of expression * expression
  | Rem of expression * expression
  | And of expression * expression
  | Or of expression * expression
  | Xor of expression * expression
  | AndThen of expression * expression
  | OrElse of expression * expression
  | Fun of expression list
  | Parent of expression

type type_ = string * (expression * expression) option

type mode =
  | In
  | Out
  | InOut

type iter = 
  | Seq of expression * expression
  | Type of type_

type choice =
  | Expression of expression
  | Seq of expression * expression
  | Others

type instruction_ = 
  | Null
  | Aff of string * expression
  | Proc of string * expression list
  | Loop of string * instruction_ list
  | While of string * expression * instruction_ list
  | For of string * string * bool * iter * instruction_ list 
  | If of expression * instruction_ list * (expression * instruction_ list) list * instruction_ list
  | Case of expression * (choice * instruction_ list) list
  | Goto of string * string
  | Exit of (string * expression) option
  | ProcReturn
  | ProcFun of expression

type instruction = instruction_ list

type declaration =
  | Obj of string list * bool * type_ option * expression option
  | Type of type_
  | SubType of string * type_
  | Rename of string list * type_ * string
  | Proc of string * (string list * mode option * string ) list
  | Fun of string * (string list * mode option * string ) list * string
  | DefProc of string * (string list * mode option * string ) list * declaration list * instruction list
  | DefFun of string * (string list * mode option * string ) list * string * declaration list * instruction list

type file = 
  | DefProc of string * (string list * mode option * string ) list * declaration list * instruction list
  | DefFun of string * (string list * mode option * string ) list * string * declaration list * instruction list
