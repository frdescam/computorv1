(* ************************************************************************** *)
(*                                                                            *)
(*                                                        :::      ::::::::   *)
(*   main.ml                                            :+:      :+:    :+:   *)
(*                                                    +:+ +:+         +:+     *)
(*   By: frdescam <marvin@42.fr>                    +#+  +:+       +#+        *)
(*                                                +#+#+#+#+#+   +#+           *)
(*   Created: 2022/11/27 23:10:10 by frdescam          #+#    #+#             *)
(*   Updated: 2023/03/05 17:26:34 by frdescam         ###   ########.fr       *)
(*                                                                            *)
(* ************************************************************************** *)

open Complex
open Types

let exit_error error_msg =
        print_endline error_msg;
        exit 1

let extract_data_from_argv () =
        try
        (
                let polynomial_string = Sys.argv.(1) in
                let lexbuf = Lexing.from_string polynomial_string in
                Polynomial_parser.parse Polynomial_lexer.lex lexbuf
        ) with e -> exit_error "Syntax error"

let add_default_terms polynomial =
        let reduced_form = polynomial.reduced_form
        in
        let degree = polynomial.degree
        in
        let reduced_form =
                if not (List.exists (fun {exponent; _} -> exponent = 0) reduced_form)
                then
                        {coefficient = 0.; exponent = 0} :: reduced_form
                else
                        reduced_form
        in
        let reduced_form =
                if degree > 0 && not (List.exists (fun {exponent; _} -> exponent = 1) reduced_form)
                then
                        {coefficient = 0.; exponent = 1} :: reduced_form
                else
                        reduced_form
        in
        let reduced_form =
                if degree > 1 && not (List.exists (fun {exponent; _} -> exponent = 2) reduced_form)
                then
                        {coefficient = 0.; exponent = 2} :: reduced_form
                else
                        reduced_form
        in
        let reduced_form = List.sort (fun {exponent=e1; _} {exponent=e2; _} ->
                compare e2 e1) reduced_form
        in
        { polynomial with reduced_form = reduced_form }

let find_degree polynomial =
        let degree = match polynomial.reduced_form with
        | [] -> 0
        | hd :: _ -> hd.exponent
        in
        { polynomial with degree = degree }

let reduce_polynomial polynomial =
        let all_terms = polynomial.left_terms @ List.map (fun {coefficient; exponent} ->
        {
                coefficient = -1. *. coefficient; exponent
        }) polynomial.right_terms
        in
        let grouped_terms = List.fold_left (fun acc t ->
                let exponent = t.exponent in
                let (same, other) = List.partition (fun t' -> t'.exponent = exponent) acc in
                let coefficient = List.fold_left
                        (fun acc {coefficient; _} -> acc +. coefficient)
                        0.
                        (t :: same)
                in
                (if coefficient = 0. then other else {coefficient; exponent} :: other))
        []
        all_terms
        in
        let reduced_terms = List.sort (fun {exponent=e1; _} {exponent=e2; _} ->
                compare e2 e1) grouped_terms
        in
        { polynomial with reduced_form = reduced_terms }

let solve_0 polynomial =
        let a = (List.nth polynomial.reduced_form 0).coefficient
        in
                {
                        polynomial with solution_1 =
                                Some (
                                        match a with
                                        | 0. -> AllReal
                                        | _ -> NoSolutions
                                )
                }

let solve_1 polynomial =
        let a = (List.nth polynomial.reduced_form 0).coefficient
        and b = (List.nth polynomial.reduced_form 1).coefficient
        in
                {
                        (* Solution = -b / a *)
                        polynomial with solution_1 =
                                Some (Solution (Complex.{
                                        re = (-.b /. a);
                                        im = 0.
                                }))
                }

let compute_discriminant polynomial =
        let a = (List.nth polynomial.reduced_form 0).coefficient
        and b = (List.nth polynomial.reduced_form 1).coefficient
        and c = (List.nth polynomial.reduced_form 2).coefficient
        in
                {
                        (* Discriminent = b² - 4ac *)
                        polynomial with discriminant =
                                Some (
                                        b *. b -. 4. *. a *. c
                                )
                }

let compute_solution_null_discriminant polynomial =
        let a = (List.nth polynomial.reduced_form 0).coefficient
        and b = (List.nth polynomial.reduced_form 1).coefficient
        in
                {
                        (* Solution = (-b / 2a *)
                        polynomial with solution_1 =
                                Some (Solution (Complex.{
                                        re = (-.b /. (2. *. a));
                                        im = 0.
                                }))
                }

let compute_solutions_negative_discriminant polynomial =
        let a = (List.nth polynomial.reduced_form 0).coefficient
        and b = (List.nth polynomial.reduced_form 1).coefficient
        and discriminant =
                match polynomial.discriminant with
                | Some d -> d;
                | None -> exit_error "Internal error"
        in
        {
                polynomial with
                (* Solution 1 = (-b + i * sqrt(discriminant)) / 2a *)
                solution_1 =
                        Some (Solution (Complex.{
                                re = (-.b /. (2. *. a));
                                im = ((Stdlib.sqrt (abs_float discriminant)) /. (2. *. a)) 
                        }));
                (* Solution 1 = (-b - i * sqrt(discriminant)) / 2a *)
                solution_2 =
                        Some (Solution (Complex.{
                                re = (-.b /. (2. *. a));
                                im = (-.(Stdlib.sqrt (abs_float discriminant)) /. (2. *. a)) 
                        }))
                }

let compute_solutions_positive_discriminant polynomial =
        let a = (List.nth polynomial.reduced_form 0).coefficient
        and b = (List.nth polynomial.reduced_form 1).coefficient
        and discriminant =
                match polynomial.discriminant with
                | Some d -> d;
                | None -> exit_error "Internal error"
        in
        {
                polynomial with
                (* Solution 1 = (-b - sqrt(discriminant)) / 2a *)
                solution_1 =
                        Some (Solution (Complex.{
                                re = ((-.b -. Stdlib.sqrt discriminant) /. (2. *. a));
                                im = 0.
                        }));
                (* Solution 1 = (-b + sqrt(discriminant)) / 2a *)
                solution_2 =
                        Some (Solution (Complex.{
                                re = ((-.b +. Stdlib.sqrt discriminant) /. (2. *. a));
                                im = 0.
                        }))
                }

let solve_2 polynomial =
        let polynomial = compute_discriminant polynomial
        in 
        match polynomial.discriminant with
        | Some d when d < 0. -> compute_solutions_negative_discriminant polynomial
        | Some d when d > 0. -> compute_solutions_positive_discriminant polynomial
        | _ -> compute_solution_null_discriminant polynomial

let print_solution solution =
        let re = solution.re in
        let im = solution.im in
        if im = 0.
                then Printf.printf "%.3f\n" re
        else
                let operator = if im > 0. then '+' else '-' in
                let im = abs_float im in
                Printf.printf "%.3f %c %.3fi\n" re operator im

let print_solutions polynomial =
        match polynomial.solution_1 with
        | Some NoSolutions -> print_endline "There is no solution to this polynomial."
        | Some AllReal -> print_endline "All real numbers are solution of this polynomial."
        | Some Solution s -> print_string "x1: "; print_solution s
        | None -> ();
        ;
        match polynomial.solution_2 with
        | Some Solution s -> print_string "x2: "; print_solution s
        | _ -> ()

let _ =
        if Array.length Sys.argv != 2 then
                exit_error "Error: invalid argument count";

        let polynomial =
                extract_data_from_argv () |> reduce_polynomial |> find_degree |> add_default_terms 
        in
        let polynomial =
                match polynomial.degree with
                | 0 -> solve_0 polynomial
                | 1 -> solve_1 polynomial
                | 2 -> solve_2 polynomial
                | _ -> exit_error "Error: polynomials after 2nd degree aren't supported"
        in
        (
                match polynomial.discriminant with
                | Some d -> Printf.printf "Discriminant : %f\n" d
                | None -> ()
        );
        print_solutions polynomial
