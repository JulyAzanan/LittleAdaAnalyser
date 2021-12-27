type token =
  | EOL
  | EXP
  | DOT
  | SHARP
  | QUOTE
  | COMMENT
  | Int of (int)
  | Sign of (bool)
  | Base of (int)
  | Hex of (string)
  | String of (string)

open Parsing;;
let _ = parse_error;;
# 2 "parser.mly"
    open Ast;;

    (* TODO *)
# 21 "parser.ml"
let yytransl_const = [|
  257 (* EOL *);
  258 (* EXP *);
  259 (* DOT *);
  260 (* SHARP *);
  261 (* QUOTE *);
  262 (* COMMENT *);
    0|]

let yytransl_block = [|
  263 (* Int *);
  264 (* Sign *);
  265 (* Base *);
  266 (* Hex *);
  267 (* String *);
    0|]

let yylhs = "\255\255\
\001\000\002\000\002\000\002\000\002\000\002\000\002\000\002\000\
\002\000\002\000\003\000\003\000\000\000"

let yylen = "\002\000\
\002\000\001\000\003\000\004\000\006\000\004\000\006\000\007\000\
\009\000\001\000\004\000\003\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\000\000\000\000\000\000\013\000\000\000\010\000\
\000\000\000\000\000\000\000\000\001\000\000\000\000\000\000\000\
\000\000\011\000\004\000\000\000\000\000\000\000\000\000\000\000\
\000\000\005\000\000\000\000\000\000\000\008\000\000\000\009\000"

let yydgoto = "\002\000\
\006\000\007\000\008\000"

let yysindex = "\002\000\
\251\254\000\000\246\254\003\255\005\255\000\000\009\255\000\000\
\006\255\007\255\010\255\002\255\000\000\008\255\011\255\012\255\
\004\255\000\000\000\000\013\255\014\255\017\255\015\255\016\255\
\018\255\000\000\021\255\020\255\022\255\000\000\024\255\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\027\255\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\028\255\000\000\031\255\
\000\000\000\000\000\000\000\000\000\000\032\255\000\000\000\000\
\000\000\000\000\033\255\000\000\000\000\000\000\000\000\000\000"

let yygindex = "\000\000\
\000\000\000\000\011\000"

let yytablesize = 34
let yytable = "\003\000\
\009\000\004\000\001\000\005\000\010\000\011\000\021\000\022\000\
\012\000\013\000\014\000\017\000\003\000\020\000\015\000\000\000\
\016\000\019\000\025\000\027\000\023\000\026\000\029\000\024\000\
\018\000\028\000\030\000\002\000\012\000\031\000\032\000\003\000\
\006\000\007\000"

let yycheck = "\005\001\
\011\001\007\001\001\000\009\001\002\001\003\001\003\001\004\001\
\004\001\001\001\005\001\010\001\005\001\002\001\008\001\255\255\
\007\001\007\001\002\001\004\001\008\001\007\001\002\001\010\001\
\014\000\008\001\007\001\001\001\001\001\008\001\007\001\001\001\
\001\001\001\001"

let yynames_const = "\
  EOL\000\
  EXP\000\
  DOT\000\
  SHARP\000\
  QUOTE\000\
  COMMENT\000\
  "

let yynames_block = "\
  Int\000\
  Sign\000\
  Base\000\
  Hex\000\
  String\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'e) in
    Obj.repr(
# 18 "parser.mly"
          (_1)
# 110 "parser.ml"
               : Ast.expression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 21 "parser.mly"
        (Const(Int(_1)))
# 117 "parser.ml"
               : 'e))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : int) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 22 "parser.mly"
                  (Const(Float(_1, _3)))
# 125 "parser.ml"
               : 'e))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : int) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : bool) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 23 "parser.mly"
                       (Const(IntExp(_1, _3, _4)))
# 134 "parser.ml"
               : 'e))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 5 : int) in
    let _3 = (Parsing.peek_val __caml_parser_env 3 : int) in
    let _5 = (Parsing.peek_val __caml_parser_env 1 : bool) in
    let _6 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 24 "parser.mly"
                               (Const(FloatExp(_1, _3, _5, _6)))
# 144 "parser.ml"
               : 'e))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : int) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : string) in
    Obj.repr(
# 25 "parser.mly"
                           (BaseConst(Int(_1, _3)))
# 152 "parser.ml"
               : 'e))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 5 : int) in
    let _3 = (Parsing.peek_val __caml_parser_env 3 : string) in
    let _5 = (Parsing.peek_val __caml_parser_env 1 : string) in
    Obj.repr(
# 26 "parser.mly"
                                   (BaseConst(Float(_1, _3, _5)))
# 161 "parser.ml"
               : 'e))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 6 : int) in
    let _3 = (Parsing.peek_val __caml_parser_env 4 : string) in
    let _6 = (Parsing.peek_val __caml_parser_env 1 : bool) in
    let _7 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 27 "parser.mly"
                                        (BaseConst(IntExp(_1, _3, _6, _7)))
# 171 "parser.ml"
               : 'e))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 8 : int) in
    let _3 = (Parsing.peek_val __caml_parser_env 6 : string) in
    let _5 = (Parsing.peek_val __caml_parser_env 4 : string) in
    let _8 = (Parsing.peek_val __caml_parser_env 1 : bool) in
    let _9 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 28 "parser.mly"
                                                (BaseConst(FloatExp(_1, _3, _5, _8, _9)))
# 182 "parser.ml"
               : 'e))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'q) in
    Obj.repr(
# 29 "parser.mly"
        (String(_1))
# 189 "parser.ml"
               : 'e))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : string) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : 'q) in
    Obj.repr(
# 32 "parser.mly"
                         (_2 ^ "\"" ^ _4)
# 197 "parser.ml"
               : 'q))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : string) in
    Obj.repr(
# 33 "parser.mly"
                         (_2)
# 204 "parser.ml"
               : 'q))
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
   (Parsing.yyparse yytables 1 lexfun lexbuf : Ast.expression)
