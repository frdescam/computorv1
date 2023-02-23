(* ************************************************************************** *)
(*                                                                            *)
(*                                                        :::      ::::::::   *)
(*   main.ml                                            :+:      :+:    :+:   *)
(*                                                    +:+ +:+         +:+     *)
(*   By: frdescam <marvin@42.fr>                    +#+  +:+       +#+        *)
(*                                                +#+#+#+#+#+   +#+           *)
(*   Created: 2022/11/27 23:10:10 by frdescam          #+#    #+#             *)
(*   Updated: 2023/02/23 12:41:20 by frdescam         ###   ########.fr       *)
(*                                                                            *)
(* ************************************************************************** *)

open Complex
open Types

let exit_error error_msg =
        print_endline error_msg;
        exit 1

let extract_data_from_argv () =
        let polynomial_string = Sys.argv.(1) in
        let lexbuf = Lexing.from_string polynomial_string in
        Polynomial_parser.parse Polynomial_lexer.lex lexbuf

let compute_degree polynomial =
        let left_degree =
                List.fold_left (fun acc t -> max acc t.exponent) (-1) polynomial.left_terms
        in
        let right_degree =
                List.fold_left (fun acc t -> max acc t.exponent) (-1) polynomial.right_terms
        in
        let degree = max left_degree right_degree
        in
        {
                polynomial with degree = degree
        }

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
        print_endline "before disc";
        let polynomial = compute_discriminant polynomial
        in 
        print_endline "after disc";
        match polynomial.discriminant with
        | Some d when d < 0. -> compute_solutions_negative_discriminant polynomial
        | Some d when d > 0. -> compute_solutions_positive_discriminant polynomial
        | _ -> compute_solution_null_discriminant polynomial

let print_solution solution =
        let re = solution.re in
        let im = solution.im in
        if im = 0.
                then Printf.printf "%.1f\n" re
        else
                let operator = if im > 0. then '+' else '-' in
                let im = abs_float im in
                Printf.printf "%.1f %c %.1fi\n" re operator im

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
                extract_data_from_argv ()
        in
        let polynomial =
                compute_degree polynomial
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
