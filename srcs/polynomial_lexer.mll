(* ************************************************************************** *)
(*                                                                            *)
(*                                                        :::      ::::::::   *)
(*   polynomial_lexer.mll                               :+:      :+:    :+:   *)
(*                                                    +:+ +:+         +:+     *)
(*   By: frdescam <marvin@42.fr>                    +#+  +:+       +#+        *)
(*                                                +#+#+#+#+#+   +#+           *)
(*   Created: 2023/02/16 19:09:56 by frdescam          #+#    #+#             *)
(*   Updated: 2023/02/23 10:06:28 by frdescam         ###   ########.fr       *)
(*                                                                            *)
(* ************************************************************************** *)

{
        open Polynomial_parser
}

let digit = ['0'-'9']
let decimal = digit+
let floating = '-'? decimal '.' decimal
let integer = '-'? decimal

rule lex = parse
          | [' ' '\t']           { lex lexbuf }
          | integer as i         { INT(int_of_string i) }
          | floating as f        { FLOAT(float_of_string f) }
          | '+'                  { PLUS }
          | '-'                  { MINUS }
          | '*'                  { TIMES }
          | '/'                  { DIVIDE }
          | '^'                  { POWER }
          | '='                  { EQUAL }
          | ['x' 'X']            { VAR }
          | '\n'                 { EOF }
          | eof                  { EOF }
