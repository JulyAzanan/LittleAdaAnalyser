type token =
  | EOL
  | MINUS
  | PLUS
  | ABS
  | NOT
  | MULT
  | DIV
  | POW
  | EQUAL
  | N_EQUAL
  | LESS_T
  | GREATER_T
  | LESS
  | GREATER
  | MOD
  | REM
  | AND
  | OR
  | XOR
  | AND_THEN
  | OR_ELSE
  | L_PAR
  | R_PAR
  | COMMA
  | SEMICOLON
  | COLON
  | L_ID
  | R_ID
  | NULL
  | ASS
  | LOOP
  | END_LOOP
  | Int of (int)
  | Float of (int*int)
  | IntExp of (int*bool*int)
  | FloatExp of (int*int*bool*int)
  | BaseInt of (int*string)
  | BaseFloat of (int*string*string)
  | BaseIntExp of (int*string*bool*int)
  | BaseFloatExp of (int*string*string*bool*int)
  | Base of (int)
  | Hex of (string)
  | String of (string)
  | Id of (string)
  | QualId of (string)

open Parsing;;
let _ = parse_error;;
# 2 "parser.mly"
    open Ast;;

    (* TODO *)
# 55 "parser.ml"
let yytransl_const = [|
  257 (* EOL *);
  258 (* MINUS *);
  259 (* PLUS *);
  260 (* ABS *);
  261 (* NOT *);
  262 (* MULT *);
  263 (* DIV *);
  264 (* POW *);
  265 (* EQUAL *);
  266 (* N_EQUAL *);
  267 (* LESS_T *);
  268 (* GREATER_T *);
  269 (* LESS *);
  270 (* GREATER *);
  271 (* MOD *);
  272 (* REM *);
  273 (* AND *);
  274 (* OR *);
  275 (* XOR *);
  276 (* AND_THEN *);
  277 (* OR_ELSE *);
  278 (* L_PAR *);
  279 (* R_PAR *);
  280 (* COMMA *);
  281 (* SEMICOLON *);
  282 (* COLON *);
  283 (* L_ID *);
  284 (* R_ID *);
  285 (* NULL *);
  286 (* ASS *);
  287 (* LOOP *);
  288 (* END_LOOP *);
    0|]

let yytransl_block = [|
  289 (* Int *);
  290 (* Float *);
  291 (* IntExp *);
  292 (* FloatExp *);
  293 (* BaseInt *);
  294 (* BaseFloat *);
  295 (* BaseIntExp *);
  296 (* BaseFloatExp *);
  297 (* Base *);
  298 (* Hex *);
  299 (* String *);
  300 (* Id *);
  301 (* QualId *);
    0|]

let yylhs = "\255\255\
\001\000\002\000\002\000\002\000\002\000\002\000\002\000\002\000\
\002\000\002\000\002\000\002\000\002\000\002\000\002\000\002\000\
\002\000\002\000\002\000\002\000\002\000\002\000\002\000\002\000\
\002\000\002\000\002\000\002\000\002\000\002\000\002\000\002\000\
\002\000\002\000\003\000\003\000\004\000\004\000\005\000\005\000\
\006\000\006\000\007\000\007\000\007\000\007\000\007\000\007\000\
\008\000\008\000\000\000"

let yylen = "\002\000\
\002\000\001\000\001\000\001\000\001\000\001\000\001\000\001\000\
\001\000\001\000\001\000\002\000\002\000\002\000\003\000\003\000\
\003\000\003\000\003\000\003\000\003\000\003\000\003\000\003\000\
\003\000\003\000\003\000\003\000\003\000\003\000\003\000\003\000\
\003\000\004\000\002\000\001\000\002\000\001\000\003\000\001\000\
\004\000\001\000\002\000\004\000\002\000\005\000\006\000\007\000\
\002\000\001\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\002\000\003\000\
\004\000\005\000\006\000\007\000\008\000\009\000\000\000\038\000\
\000\000\051\000\000\000\010\000\000\000\000\000\013\000\014\000\
\000\000\035\000\037\000\001\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\033\000\
\000\000\000\000\000\000\000\000\019\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\034\000\039\000"

let yydgoto = "\002\000\
\018\000\067\000\020\000\021\000\068\000\000\000\000\000\000\000"

let yysindex = "\007\000\
\044\255\000\000\044\255\044\255\044\255\044\255\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\228\254\000\000\
\218\254\000\000\228\000\000\000\250\254\010\001\000\000\000\000\
\205\000\000\000\000\000\000\000\044\255\044\255\044\255\044\255\
\044\255\044\255\044\255\044\255\044\255\044\255\044\255\044\255\
\044\255\044\255\044\255\044\255\044\255\044\255\044\255\000\000\
\010\001\010\001\014\255\014\255\000\000\007\001\007\001\007\001\
\007\001\007\001\007\001\014\255\014\255\248\000\248\000\248\000\
\248\000\248\000\185\000\002\255\044\255\000\000\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\089\255\000\000\
\000\000\000\000\000\000\000\000\113\255\050\255\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\233\255\001\000\137\255\161\255\000\000\000\255\022\000\043\000\
\064\000\085\000\106\000\185\255\209\255\120\000\130\000\141\000\
\151\000\162\000\003\255\000\000\000\000\000\000\000\000"

let yygindex = "\000\000\
\000\000\255\255\012\000\030\000\237\255\000\000\000\000\000\000"

let yytablesize = 538
let yytable = "\019\000\
\020\000\022\000\023\000\024\000\025\000\016\000\017\000\001\000\
\020\000\020\000\020\000\020\000\020\000\020\000\015\000\047\000\
\020\000\020\000\020\000\020\000\020\000\033\000\020\000\020\000\
\070\000\040\000\026\000\049\000\050\000\051\000\052\000\053\000\
\054\000\055\000\056\000\057\000\058\000\059\000\060\000\061\000\
\062\000\063\000\064\000\065\000\066\000\003\000\027\000\004\000\
\005\000\071\000\012\000\012\000\012\000\000\000\000\000\000\000\
\000\000\000\000\012\000\012\000\012\000\012\000\012\000\012\000\
\000\000\006\000\012\000\012\000\012\000\012\000\012\000\000\000\
\012\000\012\000\000\000\000\000\007\000\008\000\009\000\010\000\
\011\000\012\000\013\000\014\000\000\000\000\000\015\000\016\000\
\017\000\036\000\036\000\036\000\000\000\000\000\036\000\036\000\
\036\000\036\000\036\000\036\000\036\000\036\000\036\000\036\000\
\036\000\036\000\036\000\036\000\036\000\036\000\000\000\036\000\
\036\000\011\000\011\000\011\000\000\000\000\000\011\000\011\000\
\011\000\011\000\011\000\011\000\011\000\011\000\011\000\011\000\
\011\000\011\000\011\000\011\000\011\000\011\000\000\000\011\000\
\011\000\017\000\017\000\017\000\000\000\000\000\017\000\017\000\
\000\000\017\000\017\000\017\000\017\000\017\000\017\000\017\000\
\017\000\017\000\017\000\017\000\017\000\017\000\000\000\017\000\
\017\000\018\000\018\000\018\000\000\000\000\000\018\000\018\000\
\000\000\018\000\018\000\018\000\018\000\018\000\018\000\018\000\
\018\000\018\000\018\000\018\000\018\000\018\000\000\000\018\000\
\018\000\026\000\026\000\026\000\000\000\000\000\026\000\026\000\
\000\000\026\000\026\000\026\000\026\000\026\000\026\000\026\000\
\026\000\026\000\026\000\026\000\026\000\026\000\000\000\026\000\
\026\000\027\000\027\000\027\000\000\000\000\000\027\000\027\000\
\000\000\027\000\027\000\027\000\027\000\027\000\027\000\027\000\
\027\000\027\000\027\000\027\000\027\000\027\000\000\000\027\000\
\027\000\015\000\015\000\015\000\000\000\000\000\000\000\000\000\
\000\000\015\000\015\000\015\000\015\000\015\000\015\000\000\000\
\000\000\015\000\015\000\015\000\015\000\015\000\000\000\015\000\
\015\000\016\000\016\000\016\000\000\000\000\000\000\000\000\000\
\000\000\016\000\016\000\016\000\016\000\016\000\016\000\000\000\
\000\000\016\000\016\000\016\000\016\000\016\000\021\000\016\000\
\016\000\000\000\000\000\000\000\000\000\000\000\021\000\021\000\
\021\000\021\000\021\000\021\000\000\000\000\000\021\000\021\000\
\021\000\021\000\021\000\022\000\021\000\021\000\000\000\000\000\
\000\000\000\000\000\000\022\000\022\000\022\000\022\000\022\000\
\022\000\000\000\000\000\022\000\022\000\022\000\022\000\022\000\
\023\000\022\000\022\000\000\000\000\000\000\000\000\000\000\000\
\023\000\023\000\023\000\023\000\023\000\023\000\000\000\000\000\
\023\000\023\000\023\000\023\000\023\000\024\000\023\000\023\000\
\000\000\000\000\000\000\000\000\000\000\024\000\024\000\024\000\
\024\000\024\000\024\000\000\000\000\000\024\000\024\000\024\000\
\024\000\024\000\025\000\024\000\024\000\000\000\000\000\000\000\
\000\000\000\000\025\000\025\000\025\000\025\000\025\000\025\000\
\028\000\000\000\025\000\025\000\025\000\025\000\025\000\000\000\
\025\000\025\000\029\000\000\000\000\000\000\000\000\000\000\000\
\028\000\028\000\028\000\028\000\028\000\030\000\028\000\028\000\
\000\000\000\000\029\000\029\000\029\000\029\000\029\000\031\000\
\029\000\029\000\000\000\000\000\000\000\030\000\030\000\030\000\
\030\000\030\000\032\000\030\000\030\000\000\000\000\000\031\000\
\031\000\031\000\031\000\031\000\000\000\031\000\031\000\000\000\
\000\000\000\000\032\000\032\000\032\000\032\000\032\000\000\000\
\032\000\032\000\029\000\030\000\000\000\000\000\031\000\032\000\
\033\000\034\000\035\000\036\000\037\000\038\000\039\000\040\000\
\041\000\042\000\043\000\044\000\045\000\046\000\029\000\030\000\
\069\000\000\000\031\000\032\000\033\000\034\000\035\000\036\000\
\037\000\038\000\039\000\040\000\041\000\042\000\043\000\044\000\
\045\000\046\000\000\000\048\000\028\000\029\000\030\000\000\000\
\000\000\031\000\032\000\033\000\034\000\035\000\036\000\037\000\
\038\000\039\000\040\000\041\000\042\000\043\000\044\000\045\000\
\046\000\029\000\030\000\000\000\000\000\031\000\032\000\033\000\
\034\000\035\000\036\000\037\000\038\000\039\000\040\000\041\000\
\029\000\030\000\000\000\000\000\031\000\032\000\033\000\031\000\
\032\000\033\000\000\000\000\000\000\000\040\000\041\000\000\000\
\040\000\041\000"

let yycheck = "\001\000\
\001\001\003\000\004\000\005\000\006\000\044\001\045\001\001\000\
\009\001\010\001\011\001\012\001\013\001\014\001\043\001\022\001\
\017\001\018\001\019\001\020\001\021\001\008\001\023\001\024\001\
\023\001\023\001\015\000\029\000\030\000\031\000\032\000\033\000\
\034\000\035\000\036\000\037\000\038\000\039\000\040\000\041\000\
\042\000\043\000\044\000\045\000\046\000\002\001\017\000\004\001\
\005\001\069\000\001\001\002\001\003\001\255\255\255\255\255\255\
\255\255\255\255\009\001\010\001\011\001\012\001\013\001\014\001\
\255\255\022\001\017\001\018\001\019\001\020\001\021\001\255\255\
\023\001\024\001\255\255\255\255\033\001\034\001\035\001\036\001\
\037\001\038\001\039\001\040\001\255\255\255\255\043\001\044\001\
\045\001\001\001\002\001\003\001\255\255\255\255\006\001\007\001\
\008\001\009\001\010\001\011\001\012\001\013\001\014\001\015\001\
\016\001\017\001\018\001\019\001\020\001\021\001\255\255\023\001\
\024\001\001\001\002\001\003\001\255\255\255\255\006\001\007\001\
\008\001\009\001\010\001\011\001\012\001\013\001\014\001\015\001\
\016\001\017\001\018\001\019\001\020\001\021\001\255\255\023\001\
\024\001\001\001\002\001\003\001\255\255\255\255\006\001\007\001\
\255\255\009\001\010\001\011\001\012\001\013\001\014\001\015\001\
\016\001\017\001\018\001\019\001\020\001\021\001\255\255\023\001\
\024\001\001\001\002\001\003\001\255\255\255\255\006\001\007\001\
\255\255\009\001\010\001\011\001\012\001\013\001\014\001\015\001\
\016\001\017\001\018\001\019\001\020\001\021\001\255\255\023\001\
\024\001\001\001\002\001\003\001\255\255\255\255\006\001\007\001\
\255\255\009\001\010\001\011\001\012\001\013\001\014\001\015\001\
\016\001\017\001\018\001\019\001\020\001\021\001\255\255\023\001\
\024\001\001\001\002\001\003\001\255\255\255\255\006\001\007\001\
\255\255\009\001\010\001\011\001\012\001\013\001\014\001\015\001\
\016\001\017\001\018\001\019\001\020\001\021\001\255\255\023\001\
\024\001\001\001\002\001\003\001\255\255\255\255\255\255\255\255\
\255\255\009\001\010\001\011\001\012\001\013\001\014\001\255\255\
\255\255\017\001\018\001\019\001\020\001\021\001\255\255\023\001\
\024\001\001\001\002\001\003\001\255\255\255\255\255\255\255\255\
\255\255\009\001\010\001\011\001\012\001\013\001\014\001\255\255\
\255\255\017\001\018\001\019\001\020\001\021\001\001\001\023\001\
\024\001\255\255\255\255\255\255\255\255\255\255\009\001\010\001\
\011\001\012\001\013\001\014\001\255\255\255\255\017\001\018\001\
\019\001\020\001\021\001\001\001\023\001\024\001\255\255\255\255\
\255\255\255\255\255\255\009\001\010\001\011\001\012\001\013\001\
\014\001\255\255\255\255\017\001\018\001\019\001\020\001\021\001\
\001\001\023\001\024\001\255\255\255\255\255\255\255\255\255\255\
\009\001\010\001\011\001\012\001\013\001\014\001\255\255\255\255\
\017\001\018\001\019\001\020\001\021\001\001\001\023\001\024\001\
\255\255\255\255\255\255\255\255\255\255\009\001\010\001\011\001\
\012\001\013\001\014\001\255\255\255\255\017\001\018\001\019\001\
\020\001\021\001\001\001\023\001\024\001\255\255\255\255\255\255\
\255\255\255\255\009\001\010\001\011\001\012\001\013\001\014\001\
\001\001\255\255\017\001\018\001\019\001\020\001\021\001\255\255\
\023\001\024\001\001\001\255\255\255\255\255\255\255\255\255\255\
\017\001\018\001\019\001\020\001\021\001\001\001\023\001\024\001\
\255\255\255\255\017\001\018\001\019\001\020\001\021\001\001\001\
\023\001\024\001\255\255\255\255\255\255\017\001\018\001\019\001\
\020\001\021\001\001\001\023\001\024\001\255\255\255\255\017\001\
\018\001\019\001\020\001\021\001\255\255\023\001\024\001\255\255\
\255\255\255\255\017\001\018\001\019\001\020\001\021\001\255\255\
\023\001\024\001\002\001\003\001\255\255\255\255\006\001\007\001\
\008\001\009\001\010\001\011\001\012\001\013\001\014\001\015\001\
\016\001\017\001\018\001\019\001\020\001\021\001\002\001\003\001\
\024\001\255\255\006\001\007\001\008\001\009\001\010\001\011\001\
\012\001\013\001\014\001\015\001\016\001\017\001\018\001\019\001\
\020\001\021\001\255\255\023\001\001\001\002\001\003\001\255\255\
\255\255\006\001\007\001\008\001\009\001\010\001\011\001\012\001\
\013\001\014\001\015\001\016\001\017\001\018\001\019\001\020\001\
\021\001\002\001\003\001\255\255\255\255\006\001\007\001\008\001\
\009\001\010\001\011\001\012\001\013\001\014\001\015\001\016\001\
\002\001\003\001\255\255\255\255\006\001\007\001\008\001\006\001\
\007\001\008\001\255\255\255\255\255\255\015\001\016\001\255\255\
\015\001\016\001"

let yynames_const = "\
  EOL\000\
  MINUS\000\
  PLUS\000\
  ABS\000\
  NOT\000\
  MULT\000\
  DIV\000\
  POW\000\
  EQUAL\000\
  N_EQUAL\000\
  LESS_T\000\
  GREATER_T\000\
  LESS\000\
  GREATER\000\
  MOD\000\
  REM\000\
  AND\000\
  OR\000\
  XOR\000\
  AND_THEN\000\
  OR_ELSE\000\
  L_PAR\000\
  R_PAR\000\
  COMMA\000\
  SEMICOLON\000\
  COLON\000\
  L_ID\000\
  R_ID\000\
  NULL\000\
  ASS\000\
  LOOP\000\
  END_LOOP\000\
  "

let yynames_block = "\
  Int\000\
  Float\000\
  IntExp\000\
  FloatExp\000\
  BaseInt\000\
  BaseFloat\000\
  BaseIntExp\000\
  BaseFloatExp\000\
  Base\000\
  Hex\000\
  String\000\
  Id\000\
  QualId\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'e) in
    Obj.repr(
# 32 "parser.mly"
          (_1)
# 363 "parser.ml"
               : Ast.expression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 35 "parser.mly"
        (Const(Int(_1)))
# 370 "parser.ml"
               : 'e))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : int*int) in
    Obj.repr(
# 36 "parser.mly"
            (let (a,b) = _1 in Const(Float(a, b)))
# 377 "parser.ml"
               : 'e))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : int*bool*int) in
    Obj.repr(
# 37 "parser.mly"
             (let (a, b, c) = _1 in Const(IntExp(a, b, c)))
# 384 "parser.ml"
               : 'e))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : int*int*bool*int) in
    Obj.repr(
# 38 "parser.mly"
               (let (a, b, c, d) = _1 in Const(FloatExp(a, b, c, d)))
# 391 "parser.ml"
               : 'e))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : int*string) in
    Obj.repr(
# 39 "parser.mly"
              (let (a, b) = _1 in BaseConst(Int(a, b)))
# 398 "parser.ml"
               : 'e))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : int*string*string) in
    Obj.repr(
# 40 "parser.mly"
                (let (a, b, c) = _1 in BaseConst(Float(a, b, c)))
# 405 "parser.ml"
               : 'e))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : int*string*bool*int) in
    Obj.repr(
# 41 "parser.mly"
                 (let (a, b, c, d) = _1 in BaseConst(IntExp(a, b, c, d)))
# 412 "parser.ml"
               : 'e))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : int*string*string*bool*int) in
    Obj.repr(
# 42 "parser.mly"
                   (let (a, b, c, d, e) = _1 in BaseConst(FloatExp(a, b, c, d, e)))
# 419 "parser.ml"
               : 'e))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'string) in
    Obj.repr(
# 43 "parser.mly"
             (String(_1))
# 426 "parser.ml"
               : 'e))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'qual_id) in
    Obj.repr(
# 44 "parser.mly"
              (match _1 with 
        |[x] -> Id(x)
        |_ -> QualId(_1))
# 435 "parser.ml"
               : 'e))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'e) in
    Obj.repr(
# 47 "parser.mly"
              (Negate(_2))
# 442 "parser.ml"
               : 'e))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'e) in
    Obj.repr(
# 48 "parser.mly"
            (Abs(_2))
# 449 "parser.ml"
               : 'e))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'e) in
    Obj.repr(
# 49 "parser.mly"
            (Not(_2))
# 456 "parser.ml"
               : 'e))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'e) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'e) in
    Obj.repr(
# 50 "parser.mly"
                (Minus(_1, _3))
# 464 "parser.ml"
               : 'e))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'e) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'e) in
    Obj.repr(
# 51 "parser.mly"
               (Plus(_1, _3))
# 472 "parser.ml"
               : 'e))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'e) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'e) in
    Obj.repr(
# 52 "parser.mly"
               (Mult(_1, _3))
# 480 "parser.ml"
               : 'e))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'e) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'e) in
    Obj.repr(
# 53 "parser.mly"
              (Div(_1, _3))
# 488 "parser.ml"
               : 'e))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'e) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'e) in
    Obj.repr(
# 54 "parser.mly"
              (Pow(_1, _3))
# 496 "parser.ml"
               : 'e))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'e) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'e) in
    Obj.repr(
# 55 "parser.mly"
                (Equal(_1, _3))
# 504 "parser.ml"
               : 'e))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'e) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'e) in
    Obj.repr(
# 56 "parser.mly"
                  (NEqual(_1, _3))
# 512 "parser.ml"
               : 'e))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'e) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'e) in
    Obj.repr(
# 57 "parser.mly"
                 (LessT(_1, _3))
# 520 "parser.ml"
               : 'e))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'e) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'e) in
    Obj.repr(
# 58 "parser.mly"
                    (GreaterT(_1, _3))
# 528 "parser.ml"
               : 'e))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'e) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'e) in
    Obj.repr(
# 59 "parser.mly"
               (Less(_1, _3))
# 536 "parser.ml"
               : 'e))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'e) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'e) in
    Obj.repr(
# 60 "parser.mly"
                  (Greater(_1, _3))
# 544 "parser.ml"
               : 'e))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'e) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'e) in
    Obj.repr(
# 61 "parser.mly"
              (Mod(_1, _3))
# 552 "parser.ml"
               : 'e))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'e) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'e) in
    Obj.repr(
# 62 "parser.mly"
              (Rem(_1, _3))
# 560 "parser.ml"
               : 'e))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'e) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'e) in
    Obj.repr(
# 63 "parser.mly"
              (And(_1, _3))
# 568 "parser.ml"
               : 'e))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'e) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'e) in
    Obj.repr(
# 64 "parser.mly"
             (Or(_1, _3))
# 576 "parser.ml"
               : 'e))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'e) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'e) in
    Obj.repr(
# 65 "parser.mly"
              (Xor(_1, _3))
# 584 "parser.ml"
               : 'e))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'e) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'e) in
    Obj.repr(
# 66 "parser.mly"
                   (AndThen(_1, _3))
# 592 "parser.ml"
               : 'e))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'e) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'e) in
    Obj.repr(
# 67 "parser.mly"
                  (OrElse(_1, _3))
# 600 "parser.ml"
               : 'e))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'e) in
    Obj.repr(
# 68 "parser.mly"
                    (Parent(_2))
# 607 "parser.ml"
               : 'e))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : 'qual_id) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'e_sep) in
    Obj.repr(
# 69 "parser.mly"
                                (Fun(_1, _3))
# 615 "parser.ml"
               : 'e))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : string) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'string) in
    Obj.repr(
# 72 "parser.mly"
                  (_1 ^ "\"" ^ _2)
# 623 "parser.ml"
               : 'string))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 73 "parser.mly"
             (_1)
# 630 "parser.ml"
               : 'string))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : string) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'qual_id) in
    Obj.repr(
# 76 "parser.mly"
                   (_1::_2)
# 638 "parser.ml"
               : 'qual_id))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 77 "parser.mly"
         ([_1])
# 645 "parser.ml"
               : 'qual_id))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'e) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'e_sep) in
    Obj.repr(
# 80 "parser.mly"
                  (_1::_3)
# 653 "parser.ml"
               : 'e_sep))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'e) in
    Obj.repr(
# 81 "parser.mly"
        ([_1])
# 660 "parser.ml"
               : 'e_sep))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : string) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : 'i) in
    Obj.repr(
# 84 "parser.mly"
                   (let Instr(a, b) = _4 in Instr(_2::a, b))
# 668 "parser.ml"
               : 'i))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'i_) in
    Obj.repr(
# 85 "parser.mly"
         (Instr([],_1))
# 675 "parser.ml"
               : 'i))
; (fun __caml_parser_env ->
    Obj.repr(
# 88 "parser.mly"
                   (Null)
# 681 "parser.ml"
               : 'i_))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : 'qual_id) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'e) in
    Obj.repr(
# 89 "parser.mly"
                              (Ass(_1, _3))
# 689 "parser.ml"
               : 'i_))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'qual_id) in
    Obj.repr(
# 90 "parser.mly"
                        (Proc(_1, []))
# 696 "parser.ml"
               : 'i_))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 4 : 'qual_id) in
    let _3 = (Parsing.peek_val __caml_parser_env 2 : 'e_sep) in
    Obj.repr(
# 91 "parser.mly"
                                          (Proc(_1, _3))
# 704 "parser.ml"
               : 'i_))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 5 : string) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'i_rec) in
    Obj.repr(
# 92 "parser.mly"
                                             (Loop(_1, _4))
# 712 "parser.ml"
               : 'i_))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 6 : string) in
    let _4 = (Parsing.peek_val __caml_parser_env 3 : 'i_rec) in
    let _6 = (Parsing.peek_val __caml_parser_env 1 : string) in
    Obj.repr(
# 93 "parser.mly"
                                                (if _1 <> _6 then failwith "ID Loop pas pareil zbfuiyvzftezvy" else Loop(_1, _4))
# 721 "parser.ml"
               : 'i_))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'i_) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'i_rec) in
    Obj.repr(
# 96 "parser.mly"
             (_1::_2)
# 729 "parser.ml"
               : 'i_rec))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'i_) in
    Obj.repr(
# 97 "parser.mly"
         ([_1])
# 736 "parser.ml"
               : 'i_rec))
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
