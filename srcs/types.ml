(* ************************************************************************** *)
(*                                                                            *)
(*                                                        :::      ::::::::   *)
(*   types.ml                                           :+:      :+:    :+:   *)
(*                                                    +:+ +:+         +:+     *)
(*   By: frdescam <marvin@42.fr>                    +#+  +:+       +#+        *)
(*                                                +#+#+#+#+#+   +#+           *)
(*   Created: 2023/02/23 11:39:56 by frdescam          #+#    #+#             *)
(*   Updated: 2023/02/23 11:40:39 by frdescam         ###   ########.fr       *)
(*                                                                            *)
(* ************************************************************************** *)

type polynomial_term_t = {
        coefficient: float;
        exponent: int
}

type solution_t =
        | Solution of Complex.t
        | AllReal
        | NoSolutions

type polynomial_t = {
        left_terms: polynomial_term_t list;
        right_terms: polynomial_term_t list;
        reduced_form: polynomial_term_t list;
        degree: int;
        discriminant: float option;
        solution_1: solution_t option;
        solution_2: solution_t option
}
