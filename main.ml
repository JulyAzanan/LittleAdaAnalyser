open Ast
open Print_consts
open Check_affect
open Check_scope

let main =
  let lexbuf = Lexing.from_channel stdin
  in let file = try (Parser.s (Lex.decoupe) lexbuf) with exn -> begin
        let curr = lexbuf.Lexing.lex_curr_p in
        let line = curr.Lexing.pos_lnum in
        let cnum = curr.Lexing.pos_cnum - curr.Lexing.pos_bol in
        let tok = Lexing.lexeme lexbuf in
        let _ = begin match exn with
          | Stdlib.Parsing.Parse_error -> Format.printf "\x1b[1m\x1b[91mSyntax Error\x1b[0m"
          | Ast.MixedOperators e -> Format.printf "\x1b[1m\x1b[91mMixed Operators Error\x1b[0m"
          | Ast.DistinctIdentifiers (i1, i2) -> Format.printf "\x1b[1m\x1b[91mDistinct identifier Error\x1b[0m \x1b[36m%s\x1b[0m/\x1b[36m%s\x1b[0m" i1 i2
          | Failure s -> Format.printf "\x1b[1m\x1b[91mFailure: \x1b[0m\x1b[91m%s\x1b[0m" s
          | _ -> raise exn
        end in Format.printf " (line \x1b[33m%i\x1b[0m:\x1b[33m%i\x1b[0m) \x1b[91mon token\x1b[0m \"\x1b[36m%s\x1b[0m\"\n" line (cnum+1) tok;
        exit 3615
      end
  in let _ = print_string "\n\x1b[1m\x1b[36mConstants :\x1b[0m\n"
  in let _ = try print_consts file with exn -> begin
        let _ = begin match exn with
          | Print_consts.OutOfRadix c -> Format.printf "\x1b[1m\x1b[91mOut Of Radix Error\x1b[0m\x1b[91m on char '\x1b[36m%c\x1b[0m'\n" c
          | Print_consts.OutOfBase (b, n) -> Format.printf "\x1b[1m\x1b[91mOut Of Base Error\x1b[0m\x1b[91m on value \x1b[33m%i\x1b[0m \x1b[91mwith base\x1b[0m \x1b[33m%i\x1b[0m\n" n b
          | _ -> raise exn
        end in exit 42
      end 
  in let _ = try check_affect file with exn -> begin
        let _ = print_string "\n\x1b[1m\x1b[36mAffectations :\x1b[0m\n"
        in let _ = begin match exn with
            | Check_affect.ConstantAffectation s -> Format.printf "\x1b[1m\x1b[91mConstant Affectation Error\x1b[0m\x1b[91m on identifier \x1b[0m\"\x1b[36m%s\x1b[0m\"\n" s
            | _ -> raise exn
          end in exit 69
      end 
  in try check_scope file with exn -> begin
      let _ = print_string "\n\x1b[1m\x1b[36mScope :\x1b[0m\n"
      in let _ = begin match exn with
          | Check_scope.LabelRedefinition s -> Format.printf "\x1b[1m\x1b[91mLabel Redefinition Error\x1b[0m\x1b[91m on label \x1b[0m\"\x1b[36m%s\x1b[0m\"\n" s
          | Check_scope.UndefinedIdentifier s -> Format.printf "\x1b[1m\x1b[91mUndefined Identifier Error\x1b[0m\x1b[91m on identifier \x1b[0m\"\x1b[36m%s\x1b[0m\"\n" s
          | _ -> raise exn
        end in exit 69
    end 
