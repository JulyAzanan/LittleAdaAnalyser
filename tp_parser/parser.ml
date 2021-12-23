type token =
  | EOL
  | PLUS
  | FOIS
  | RPAR
  | LPAR
  | LET
  | EQ
  | IN
  | Cte of (int)
  | Id of (string)

open Parsing;;
let _ = parse_error;;
# 2 "parser.mly"
    open Ast;;
# 18 "parser.ml"
let yytransl_const = [|
  257 (* EOL *);
  258 (* PLUS *);
  259 (* FOIS *);
  260 (* RPAR *);
  261 (* LPAR *);
  262 (* LET *);
  263 (* EQ *);
  264 (* IN *);
    0|]

let yytransl_block = [|
  265 (* Cte *);
  266 (* Id *);
    0|]

let yylhs = "\255\255\
\001\000\002\000\002\000\002\000\002\000\002\000\002\000\000\000"

let yylen = "\002\000\
\002\000\003\000\003\000\006\000\003\000\001\000\001\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\000\000\000\000\006\000\007\000\008\000\000\000\
\000\000\000\000\001\000\000\000\000\000\005\000\000\000\000\000\
\003\000\000\000\000\000\004\000"

let yydgoto = "\002\000\
\007\000\008\000"

let yysindex = "\002\000\
\008\255\000\000\008\255\253\254\000\000\000\000\000\000\018\255\
\020\255\019\255\000\000\008\255\008\255\000\000\008\255\012\255\
\000\000\003\255\008\255\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\255\
\000\000\000\000\000\000\000\000"

let yygindex = "\000\000\
\000\000\253\255"

let yytablesize = 26
let yytable = "\009\000\
\002\000\002\000\001\000\002\000\012\000\013\000\010\000\002\000\
\016\000\017\000\019\000\018\000\003\000\004\000\013\000\020\000\
\005\000\006\000\011\000\012\000\013\000\012\000\013\000\014\000\
\000\000\015\000"

let yycheck = "\003\000\
\001\001\002\001\001\000\004\001\002\001\003\001\010\001\008\001\
\012\000\013\000\008\001\015\000\005\001\006\001\003\001\019\000\
\009\001\010\001\001\001\002\001\003\001\002\001\003\001\004\001\
\255\255\007\001"

let yynames_const = "\
  EOL\000\
  PLUS\000\
  FOIS\000\
  RPAR\000\
  LPAR\000\
  LET\000\
  EQ\000\
  IN\000\
  "

let yynames_block = "\
  Cte\000\
  Id\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'e) in
    Obj.repr(
# 14 "parser.mly"
          (_1)
# 98 "parser.ml"
               : Ast.ast))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'e) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'e) in
    Obj.repr(
# 17 "parser.mly"
             (Plus(_1, _3))
# 106 "parser.ml"
               : 'e))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'e) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'e) in
    Obj.repr(
# 18 "parser.mly"
              (Fois(_1, _3))
# 114 "parser.ml"
               : 'e))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 4 : string) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'e) in
    let _6 = (Parsing.peek_val __caml_parser_env 0 : 'e) in
    Obj.repr(
# 19 "parser.mly"
                      (Let(Id(_2), _4, _6))
# 123 "parser.ml"
               : 'e))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'e) in
    Obj.repr(
# 20 "parser.mly"
                 (_2)
# 130 "parser.ml"
               : 'e))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 21 "parser.mly"
         (Cte(_1))
# 137 "parser.ml"
               : 'e))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 22 "parser.mly"
        (Id(_1))
# 144 "parser.ml"
               : 'e))
(* Entry s *)
; (fun __caml_parser_env -> raise (Parsing.YYexit (Parsing.peek_val __caml_parser_env 0)))
|]
let yytables =
  { Parsing.actions=yyact;
    Parsing.transl_const=yytransl_const;
    Parsing.transl_block=yytransl_block;
    Parsing.lhs=yylhs;
    Parsing.len=yylen;
    Parsing.defred=yydefred;
    Parsing.dgoto=yydgoto;
    Parsing.sindex=yysindex;
    Parsing.rindex=yyrindex;
    Parsing.gindex=yygindex;
    Parsing.tablesize=yytablesize;
    Parsing.table=yytable;
    Parsing.check=yycheck;
    Parsing.error_function=parse_error;
    Parsing.names_const=yynames_const;
    Parsing.names_block=yynames_block }
let s (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 1 lexfun lexbuf : Ast.ast)
