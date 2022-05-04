(** Limited interface to the Control Flow Graph (CFG)
    internal representation from OCaml compiler. *)

[@@@ocaml.warning "+a-30-40-41-42"]

module Label : sig
  type t = int
end

module Cfg : sig
  include module type of struct
    include Cfg_intf.S
  end

  module Basic_block : sig
    (** The implementation of type [t] is a mutable structure. *)
    type t

    val start : t -> Label.t
    val body : t -> basic instruction list
    val terminator : t -> terminator instruction
  end

  (** The implementation of type [t] is a mutable structure. *)
  type t

  val iter_blocks : t -> f:(Label.t -> Basic_block.t -> unit) -> unit
  val get_block : t -> Label.t -> Basic_block.t option
  val print_basic : out_channel -> basic instruction -> unit
  val print_terminator : out_channel -> ?sep:string -> terminator instruction -> unit

  (** [successor_labels] only returns non-exceptional edges. We need to pass
      [t] because the successor label of terminator (Tailcall Self) is
      recorded in [t], and not in the basic_block. *)
  val successor_labels : Basic_block.t -> Label.t list

  val predecessor_labels : Basic_block.t -> Label.t list
  val fun_name : t -> string
  val entry_label : t -> Label.t

  val num_args : t -> int
  val get_args : t -> Reg.t array
end

module Cfg_with_layout : sig
  type t

  val cfg : t -> Cfg.t
  val layout : t -> Label.t list
  val set_layout : t -> Label.t list -> unit

  val save_as_dot
    :  t
    -> ?show_instr:bool
    -> ?show_exn:bool
    -> ?annotate_block:(Label.t -> string)
    -> ?annotate_succ:(Label.t -> Label.t -> string)
    -> string
    -> unit

  val print : t -> out_channel -> string -> unit
  val preserve_orig_labels : t -> bool

  (** eliminate_* can call simplify_terminators *)
  val eliminate_dead_blocks : t -> unit

  (** eliminate fallthrough implies dead block elimination *)
  val eliminate_fallthrough_blocks : t -> unit

  val of_linear : Linear.fundecl -> preserve_orig_labels:bool -> t
  val to_linear : t -> Linear.fundecl
end

module Passes : sig
  val add_extra_debug : Cfg_with_layout.t -> unit
  val remove_debug : Cfg.t -> unit
  val simplify_terminators : Cfg.t -> unit
end

module Util : sig
  val verbose : bool ref
  val print_assembly : Cfg.Basic_block.t list -> unit
end

module File_formats : sig
  type item =
    | Cfg of Cfg_with_layout.t
    | Linear of Linear.fundecl
    | Data of Cmm.data_item list

  (* All items are Data or either CFG or Linear but not both. *)
  type unit_info =
    { unit_name : string
    ; items : item list
    ; for_pack : string option
    ; ir : Clflags.Compiler_ir.t
    }

  val save : string -> unit_info -> unit

  (* Determines the format based on filename extension. *)
  val restore : string -> unit_info * Digest.t
end
