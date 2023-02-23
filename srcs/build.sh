#!/bin/bash

ocamlc -c types.ml
menhir polynomial_parser.mly --infer
ocamlc -c polynomial_parser.mli
ocamllex polynomial_lexer.mll 
ocamlc -c polynomial_lexer.ml;
ocamlc -c polynomial_parser.ml;
ocamlc -c main.ml
ocamlc -o polynomial_resolver polynomial_lexer.cmo polynomial_parser.cmo main.cmo
