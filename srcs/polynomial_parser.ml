
module MenhirBasics = struct
  
  exception Error
  
  let _eRR =
    fun _s ->
      raise Error
  
  type token = 
    | VAR
    | TIMES
    | POWER
    | PLUS
    | MINUS
    | INT of (
# 17 "polynomial_parser.mly"
       (int)
# 20 "polynomial_parser.ml"
  )
    | FLOAT of (
# 18 "polynomial_parser.mly"
       (float)
# 25 "polynomial_parser.ml"
  )
    | EQUAL
    | EOF
  
end

include MenhirBasics

# 13 "polynomial_parser.mly"
  
        open Types

# 38 "polynomial_parser.ml"

type ('s, 'r) _menhir_state = 
  | MenhirState00 : ('s, _menhir_box_parse) _menhir_state
    (** State 00.
        Stack shape : .
        Start symbol: parse. *)

  | MenhirState08 : (('s, _menhir_box_parse) _menhir_cell1_PLUS, _menhir_box_parse) _menhir_state
    (** State 08.
        Stack shape : PLUS.
        Start symbol: parse. *)

  | MenhirState09 : (('s, _menhir_box_parse) _menhir_cell1_MINUS, _menhir_box_parse) _menhir_state
    (** State 09.
        Stack shape : MINUS.
        Start symbol: parse. *)

  | MenhirState25 : (('s, _menhir_box_parse) _menhir_cell1_terms_list, _menhir_box_parse) _menhir_state
    (** State 25.
        Stack shape : terms_list.
        Start symbol: parse. *)

  | MenhirState28 : (('s, _menhir_box_parse) _menhir_cell1_term, _menhir_box_parse) _menhir_state
    (** State 28.
        Stack shape : term.
        Start symbol: parse. *)


and ('s, 'r) _menhir_cell1_term = 
  | MenhirCell1_term of 's * ('s, 'r) _menhir_state * (Types.polynomial_term_t)

and ('s, 'r) _menhir_cell1_terms_list = 
  | MenhirCell1_terms_list of 's * ('s, 'r) _menhir_state * (Types.polynomial_term_t list)

and ('s, 'r) _menhir_cell1_MINUS = 
  | MenhirCell1_MINUS of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_PLUS = 
  | MenhirCell1_PLUS of 's * ('s, 'r) _menhir_state

and _menhir_box_parse = 
  | MenhirBox_parse of (Types.polynomial_t) [@@unboxed]

let _menhir_action_01 =
  fun () ->
    (
# 208 "<standard.mly>"
    ( [] )
# 87 "polynomial_parser.ml"
     : (Types.polynomial_term_t list))

let _menhir_action_02 =
  fun x xs ->
    (
# 210 "<standard.mly>"
    ( x :: xs )
# 95 "polynomial_parser.ml"
     : (Types.polynomial_term_t list))

let _menhir_action_03 =
  fun i ->
    (
# 74 "polynomial_parser.mly"
                  ( float_of_int i )
# 103 "polynomial_parser.ml"
     : (float))

let _menhir_action_04 =
  fun f ->
    (
# 75 "polynomial_parser.mly"
                    ( f )
# 111 "polynomial_parser.ml"
     : (float))

let _menhir_action_05 =
  fun tl ->
    (
# 28 "polynomial_parser.mly"
                              (
                {
                                left_terms = tl;
                                right_terms = [];
                                reduced_form = [];
                                degree = 0;
                                discriminant = None;
                                solution_1 = None;
                                solution_2 = None
                }
        )
# 129 "polynomial_parser.ml"
     : (Types.polynomial_t))

let _menhir_action_06 =
  fun tl tr ->
    (
# 39 "polynomial_parser.mly"
                                                    (
                {
                                left_terms = tl;
                                right_terms = tr;
                                reduced_form = [];
                                degree = 0;
                                discriminant = None;
                                solution_1 = None;
                                solution_2 = None
                }
        )
# 147 "polynomial_parser.ml"
     : (Types.polynomial_t))

let _menhir_action_07 =
  fun t ->
    (
# 59 "polynomial_parser.mly"
                        ( t )
# 155 "polynomial_parser.ml"
     : (Types.polynomial_term_t))

let _menhir_action_08 =
  fun t ->
    (
# 60 "polynomial_parser.mly"
                         ( { t with coefficient = -. t.coefficient } )
# 163 "polynomial_parser.ml"
     : (Types.polynomial_term_t))

let _menhir_action_09 =
  fun t ->
    (
# 55 "polynomial_parser.mly"
                          ( t )
# 171 "polynomial_parser.ml"
     : (Types.polynomial_term_t))

let _menhir_action_10 =
  fun t ->
    (
# 56 "polynomial_parser.mly"
                            ( t )
# 179 "polynomial_parser.ml"
     : (Types.polynomial_term_t))

let _menhir_action_11 =
  fun l ->
    (
# 52 "polynomial_parser.mly"
                         ( l )
# 187 "polynomial_parser.ml"
     : (Types.polynomial_term_t list))

let _menhir_action_12 =
  fun c e ->
    (
# 63 "polynomial_parser.mly"
                                             ( { coefficient = c; exponent = e } )
# 195 "polynomial_parser.ml"
     : (Types.polynomial_term_t))

let _menhir_action_13 =
  fun e ->
    (
# 64 "polynomial_parser.mly"
                                  ( { coefficient = 1.; exponent = e } )
# 203 "polynomial_parser.ml"
     : (Types.polynomial_term_t))

let _menhir_action_14 =
  fun c e ->
    (
# 65 "polynomial_parser.mly"
                                       ( { coefficient = c; exponent = e } )
# 211 "polynomial_parser.ml"
     : (Types.polynomial_term_t))

let _menhir_action_15 =
  fun e ->
    (
# 66 "polynomial_parser.mly"
                            ( { coefficient = 1.; exponent = e } )
# 219 "polynomial_parser.ml"
     : (Types.polynomial_term_t))

let _menhir_action_16 =
  fun c ->
    (
# 67 "polynomial_parser.mly"
                               ( { coefficient = c; exponent = 1 } )
# 227 "polynomial_parser.ml"
     : (Types.polynomial_term_t))

let _menhir_action_17 =
  fun () ->
    (
# 68 "polynomial_parser.mly"
                    ( { coefficient = 1.; exponent = 1 } )
# 235 "polynomial_parser.ml"
     : (Types.polynomial_term_t))

let _menhir_action_18 =
  fun c ->
    (
# 69 "polynomial_parser.mly"
                         ( { coefficient = c; exponent = 1 } )
# 243 "polynomial_parser.ml"
     : (Types.polynomial_term_t))

let _menhir_action_19 =
  fun () ->
    (
# 70 "polynomial_parser.mly"
              ( { coefficient = 1.; exponent = 1 } )
# 251 "polynomial_parser.ml"
     : (Types.polynomial_term_t))

let _menhir_action_20 =
  fun c ->
    (
# 71 "polynomial_parser.mly"
                     ( { coefficient = c; exponent = 0 } )
# 259 "polynomial_parser.ml"
     : (Types.polynomial_term_t))

let _menhir_print_token : token -> string =
  fun _tok ->
    match _tok with
    | EOF ->
        "EOF"
    | EQUAL ->
        "EQUAL"
    | FLOAT _ ->
        "FLOAT"
    | INT _ ->
        "INT"
    | MINUS ->
        "MINUS"
    | PLUS ->
        "PLUS"
    | POWER ->
        "POWER"
    | TIMES ->
        "TIMES"
    | VAR ->
        "VAR"

let _menhir_fail : unit -> 'a =
  fun () ->
    Printf.eprintf "Internal failure -- please contact the parser generator's developers.\n%!";
    assert false

include struct
  
  [@@@ocaml.warning "-4-37-39"]
  
  let rec _menhir_goto_parse : type  ttv_stack. ttv_stack -> _ -> _menhir_box_parse =
    fun _menhir_stack _v ->
      MenhirBox_parse _v
  
  let rec _menhir_run_30_spec_25 : type  ttv_stack. (ttv_stack, _menhir_box_parse) _menhir_cell1_terms_list -> _ -> _ -> _menhir_box_parse =
    fun _menhir_stack _v _tok ->
      let _v =
        let l = _v in
        _menhir_action_11 l
      in
      match (_tok : MenhirBasics.token) with
      | EOF ->
          let MenhirCell1_terms_list (_menhir_stack, _, tl) = _menhir_stack in
          let tr = _v in
          let _v = _menhir_action_06 tl tr in
          _menhir_goto_parse _menhir_stack _v
      | _ ->
          _eRR ()
  
  let rec _menhir_run_01 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_parse) _menhir_state -> _menhir_box_parse =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | POWER ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | INT _v ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let e = _v in
              let _v = _menhir_action_15 e in
              _menhir_goto_unsigned_term _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
          | _ ->
              _eRR ())
      | EOF | EQUAL | FLOAT _ | INT _ | MINUS | PLUS | TIMES | VAR ->
          let _v = _menhir_action_19 () in
          _menhir_goto_unsigned_term _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_unsigned_term : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_parse) _menhir_state -> _ -> _menhir_box_parse =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let t = _v in
      let _v = _menhir_action_10 t in
      _menhir_goto_term _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_term : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_parse) _menhir_state -> _ -> _menhir_box_parse =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState00 ->
          _menhir_run_28 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState28 ->
          _menhir_run_28 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState25 ->
          _menhir_run_28 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState08 ->
          _menhir_run_23 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState09 ->
          _menhir_run_13 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
  
  and _menhir_run_28 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_parse) _menhir_state -> _ -> _menhir_box_parse =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_term (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | VAR ->
          _menhir_run_01 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState28
      | TIMES ->
          _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState28
      | PLUS ->
          _menhir_run_08 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState28
      | MINUS ->
          _menhir_run_09 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState28
      | INT _v_0 ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let i = _v_0 in
          let _v = _menhir_action_03 i in
          _menhir_run_15 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState28 _tok
      | FLOAT _v_2 ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let f = _v_2 in
          let _v = _menhir_action_04 f in
          _menhir_run_15 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState28 _tok
      | EOF | EQUAL ->
          let _v = _menhir_action_01 () in
          _menhir_run_29 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_04 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_parse) _menhir_state -> _menhir_box_parse =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | VAR ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | POWER ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | INT _v ->
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  let e = _v in
                  let _v = _menhir_action_13 e in
                  _menhir_goto_unsigned_term _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
              | _ ->
                  _eRR ())
          | EOF | EQUAL | FLOAT _ | INT _ | MINUS | PLUS | TIMES | VAR ->
              let _v = _menhir_action_17 () in
              _menhir_goto_unsigned_term _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok)
      | _ ->
          _eRR ()
  
  and _menhir_run_08 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_parse) _menhir_state -> _menhir_box_parse =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_PLUS (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | VAR ->
          _menhir_run_01 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState08
      | TIMES ->
          _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState08
      | PLUS ->
          _menhir_run_08 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState08
      | MINUS ->
          _menhir_run_09 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState08
      | INT _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let i = _v in
          let _v = _menhir_action_03 i in
          _menhir_run_15 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState08 _tok
      | FLOAT _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let f = _v in
          let _v = _menhir_action_04 f in
          _menhir_run_15 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState08 _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_09 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_parse) _menhir_state -> _menhir_box_parse =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_MINUS (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | VAR ->
          _menhir_run_01 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState09
      | TIMES ->
          _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState09
      | PLUS ->
          _menhir_run_08 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState09
      | MINUS ->
          _menhir_run_09 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState09
      | INT _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let i = _v in
          let _v = _menhir_action_03 i in
          _menhir_run_15 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState09 _tok
      | FLOAT _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let f = _v in
          let _v = _menhir_action_04 f in
          _menhir_run_15 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState09 _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_15 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_parse) _menhir_state -> _ -> _menhir_box_parse =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | VAR ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | POWER ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | INT _v_0 ->
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  let (e, c) = (_v_0, _v) in
                  let _v = _menhir_action_14 c e in
                  _menhir_goto_unsigned_term _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
              | _ ->
                  _eRR ())
          | EOF | EQUAL | FLOAT _ | INT _ | MINUS | PLUS | TIMES | VAR ->
              let c = _v in
              let _v = _menhir_action_18 c in
              _menhir_goto_unsigned_term _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok)
      | TIMES ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | VAR ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | POWER ->
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  (match (_tok : MenhirBasics.token) with
                  | INT _v_1 ->
                      let _tok = _menhir_lexer _menhir_lexbuf in
                      let (e, c) = (_v_1, _v) in
                      let _v = _menhir_action_12 c e in
                      _menhir_goto_unsigned_term _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
                  | _ ->
                      _eRR ())
              | EOF | EQUAL | FLOAT _ | INT _ | MINUS | PLUS | TIMES | VAR ->
                  let c = _v in
                  let _v = _menhir_action_16 c in
                  _menhir_goto_unsigned_term _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok)
          | _ ->
              _eRR ())
      | EOF | EQUAL | FLOAT _ | INT _ | MINUS | PLUS ->
          let c = _v in
          let _v = _menhir_action_20 c in
          _menhir_goto_unsigned_term _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_29 : type  ttv_stack. (ttv_stack, _menhir_box_parse) _menhir_cell1_term -> _ -> _ -> _ -> _ -> _menhir_box_parse =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_term (_menhir_stack, _menhir_s, x) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_02 x xs in
      _menhir_goto_list_term_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_list_term_ : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_parse) _menhir_state -> _ -> _menhir_box_parse =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState00 ->
          _menhir_run_30_spec_00 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState25 ->
          _menhir_run_30_spec_25 _menhir_stack _v _tok
      | MenhirState28 ->
          _menhir_run_29 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_30_spec_00 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> _ -> _menhir_box_parse =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let _v =
        let l = _v in
        _menhir_action_11 l
      in
      match (_tok : MenhirBasics.token) with
      | EQUAL ->
          let _menhir_stack = MenhirCell1_terms_list (_menhir_stack, MenhirState00, _v) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | VAR ->
              _menhir_run_01 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState25
          | TIMES ->
              _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState25
          | PLUS ->
              _menhir_run_08 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState25
          | MINUS ->
              _menhir_run_09 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState25
          | INT _v_0 ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let i = _v_0 in
              let _v = _menhir_action_03 i in
              _menhir_run_15 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState25 _tok
          | FLOAT _v_2 ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let f = _v_2 in
              let _v = _menhir_action_04 f in
              _menhir_run_15 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState25 _tok
          | EOF ->
              let _v = _menhir_action_01 () in
              _menhir_run_30_spec_25 _menhir_stack _v _tok
          | _ ->
              _eRR ())
      | EOF ->
          let tl = _v in
          let _v = _menhir_action_05 tl in
          _menhir_goto_parse _menhir_stack _v
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_23 : type  ttv_stack. (ttv_stack, _menhir_box_parse) _menhir_cell1_PLUS -> _ -> _ -> _ -> _ -> _menhir_box_parse =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_PLUS (_menhir_stack, _menhir_s) = _menhir_stack in
      let t = _v in
      let _v = _menhir_action_07 t in
      _menhir_goto_signed_term _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_signed_term : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_parse) _menhir_state -> _ -> _menhir_box_parse =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let t = _v in
      let _v = _menhir_action_09 t in
      _menhir_goto_term _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_13 : type  ttv_stack. (ttv_stack, _menhir_box_parse) _menhir_cell1_MINUS -> _ -> _ -> _ -> _ -> _menhir_box_parse =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_MINUS (_menhir_stack, _menhir_s) = _menhir_stack in
      let t = _v in
      let _v = _menhir_action_08 t in
      _menhir_goto_signed_term _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  let rec _menhir_run_00 : type  ttv_stack. ttv_stack -> _ -> _ -> _menhir_box_parse =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | VAR ->
          _menhir_run_01 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState00
      | TIMES ->
          _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState00
      | PLUS ->
          _menhir_run_08 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState00
      | MINUS ->
          _menhir_run_09 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState00
      | INT _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let i = _v in
          let _v = _menhir_action_03 i in
          _menhir_run_15 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState00 _tok
      | FLOAT _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let f = _v in
          let _v = _menhir_action_04 f in
          _menhir_run_15 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState00 _tok
      | EOF | EQUAL ->
          let _v = _menhir_action_01 () in
          _menhir_run_30_spec_00 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _eRR ()
  
end

let parse =
  fun _menhir_lexer _menhir_lexbuf ->
    let _menhir_stack = () in
    let MenhirBox_parse v = _menhir_run_00 _menhir_stack _menhir_lexbuf _menhir_lexer in
    v
