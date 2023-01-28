(* ************************************************************************** *)
(*                                                                            *)
(*                                                        :::      ::::::::   *)
(*   main.ml                                            :+:      :+:    :+:   *)
(*                                                    +:+ +:+         +:+     *)
(*   By: frdescam <marvin@42.fr>                    +#+  +:+       +#+        *)
(*                                                +#+#+#+#+#+   +#+           *)
(*   Created: 2022/11/27 23:10:10 by frdescam          #+#    #+#             *)
(*   Updated: 2023/01/06 09:31:08 by frdescam         ###   ########.fr       *)
(*                                                                            *)
(* ************************************************************************** *)

open Complex

type polynomial_term_t = {
        coefficient: float;
        exponent: int
}

type solution =
        | Solution of Complex.t
        | AllReal
        | NoSolutions

type polynomial_t = {
        left_terms: polynomial_term_t list;
        right_terms: polynomial_term_t list;
        reduced_form: polynomial_term_t list;
        degree: int;
        discriminant: float option;
        solution_1: solution option;
        solution_2: solution option
}

let exit_error error_msg =
        print_endline error_msg;
        exit 1

let extract_data_from_argv () =
        {
                left_terms = [];
                right_terms = [];
                reduced_form =
                        {coefficient = 1.; exponent = 2} ::
                        {coefficient = (-. 5.); exponent = 1} ::
                        {coefficient = 2.; exponent = 0} :: [];
                degree = 2;
                discriminant = None;
                solution_1 = None;
                solution_2 = None
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
