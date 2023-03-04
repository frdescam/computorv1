#!/bin/bash

#ocamlc -c types.ml
#menhir polynomial_parser.mly --infer
#ocamlc -c polynomial_parser.mli
#ocamllex polynomial_lexer.mll 
#ocamlc -c polynomial_lexer.ml;
#ocamlc -c polynomial_parser.ml;
#ocamlc -c main.ml
#ocamlc -o polynomial_resolver polynomial_lexer.cmo polynomial_parser.cmo main.cmo

ocamlopt -c types.ml
menhir polynomial_parser.mly --infer
ocamlopt -c polynomial_parser.mli
ocamllex polynomial_lexer.mll 
ocamlopt -c polynomial_lexer.ml;
ocamlopt -c polynomial_parser.ml;
ocamlopt -c main.ml
ocamlopt -o polynomial_resolver polynomial_lexer.cmx polynomial_parser.cmx main.cmx types.cmx
