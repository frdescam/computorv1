(* ************************************************************************** *)
(*                                                                            *)
(*                                                        :::      ::::::::   *)
(*   polynomial_parser.mly                              :+:      :+:    :+:   *)
(*                                                    +:+ +:+         +:+     *)
(*   By: frdescam <marvin@42.fr>                    +#+  +:+       +#+        *)
(*                                                +#+#+#+#+#+   +#+           *)
(*   Created: 2023/02/06 20:11:39 by frdescam          #+#    #+#             *)
(*   Updated: 2023/02/23 11:42:00 by frdescam         ###   ########.fr       *)
(*                                                                            *)
(* ************************************************************************** *)

%{
        open Types
%}

%token <int> INT
%token <float> FLOAT
%token PLUS MINUS TIMES DIVIDE POWER EQUAL VAR EOF
%type <Types.polynomial_term_t> term
%type <Types.polynomial_term_t list> terms_list
%type <float> number
%start <Types.polynomial_t> parse

%%

parse:
        | tl = terms_list EOF {
                {
                                left_terms = tl;
                                right_terms = [];
                                reduced_form = [];
                                degree = 0;
                                discriminant = None;
                                solution_1 = None;
                                solution_2 = None
                }
        }
        | tl = terms_list EQUAL tr = terms_list EOF {
                {
                                left_terms = tl;
                                right_terms = tr;
                                reduced_form = [];
                                degree = 0;
                                discriminant = None;
                                solution_1 = None;
                                solution_2 = None
                }
        }

terms_list:
        | l = list(term) { l }

term:
        | t = signed_term { t }
        | t = unsigned_term { t }

signed_term:
        | PLUS t = term { t }
        | MINUS t = term { { t with coefficient = -. t.coefficient } }

unsigned_term:
        | c = number VAR POWER e = INT { { coefficient = c; exponent = e } }
        | c = number VAR { { coefficient = c; exponent = 1 } }
        | c = number { { coefficient = c; exponent = 0 } }

number:
        | i = INT { float_of_int i }
        | f = FLOAT { f }
