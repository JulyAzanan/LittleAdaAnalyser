type ast =
    Plus of ast * ast
  | Fois of ast * ast
  | Let of ast * ast * ast
  | Cte of int
  | Id of string

val affiche : ast -> unit
