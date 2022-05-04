[@@@ocaml.warning "+a-30-40-41-42"]

module Label = Label

module Cfg = struct
  include Cfg

  module Basic_block = struct
    type t = basic_block

    let start t = t.start
    let body t = t.body
    let terminator t = t.terminator
  end

  let successor_labels b =
    successor_labels ~normal:true ~exn:false b |> Label.Set.elements
  ;;

  let num_args c = Array.length c.fun_args
  let get_args c = c.fun_args
end

module Cfg_with_layout = struct
  include Cfg_with_layout

  let eliminate_dead_blocks = Eliminate_dead_blocks.run

  (* eliminate fallthrough implies dead block elimination *)
  let eliminate_fallthrough_blocks c =
    Eliminate_fallthrough_blocks.run c |> ignore;
    ()
  ;;

  let of_linear = Linear_to_cfg.run
  let to_linear = Cfg_to_linear.run

  (* let print (c : t) = Cfg_to_linear.print_assembly (cfg c)  *)
end

module Passes = struct
  let simplify_terminators = Simplify_terminator.run
  let add_extra_debug = Extra_debug.add

  let remove_debug (g : Cfg.t) =
    let remove_dbg_instr (i : _ Cfg.instruction) =
      { i with dbg = Debuginfo.none; fdo = Fdo_info.none }
    in
    let remove_dbg_block _label (b : Cfg.basic_block) =
      b.body <- List.map remove_dbg_instr b.body;
      b.terminator <- remove_dbg_instr b.terminator
    in
    Cfg.iter_blocks ~f:remove_dbg_block g
  ;;
end

module Util = struct
  let verbose = Cfg.verbose
  let print_assembly = Cfg_to_linear.print_assembly
end

module File_formats = struct
  type item =
    | Cfg of Cfg_with_layout.t
    | Linear of Linear.fundecl
    | Data of Cmm.data_item list

  (* All items are Data or either CFG or Linear but not both. *)
  (* CR-someday gyorsh: Is there a way to encode the constraint
     using polymorphic variants? *)
  type unit_info =
    { unit_name : string
    ; items : item list
    ; for_pack : string option
    ; ir : Clflags.Compiler_ir.t
    }

  let to_cfg_format : item -> Cfg_format.cfg_item_info = function
    | Linear _ -> Misc.fatal_error "Unexpected Linear item in cfg_unit_info"
    | Cfg g -> Cfg_format.Cfg g
    | Data d -> Cfg_format.Data d
  ;;

  let to_linear_format : item -> Linear_format.linear_item_info = function
    | Cfg _ -> Misc.fatal_error "Unexpected Cfg item in linear_unit_info"
    | Linear f -> Linear_format.Func f
    | Data d -> Linear_format.Data d
  ;;

  let of_cfg_format : Cfg_format.cfg_item_info -> item = function
    | Cfg g -> Cfg g
    | Data d -> Data d
  ;;

  let of_linear_format : Linear_format.linear_item_info -> item = function
    | Func f -> Linear f
    | Data d -> Data d
  ;;

  let save filename u =
    let unit_name = u.unit_name in
    let for_pack = u.for_pack in
    match u.ir, Clflags.Compiler_ir.extract_extension_with_pass filename with
    | Linear, Some (Linear, _) ->
      let items = List.map to_linear_format u.items in
      Linear_format.save filename { items; unit_name; for_pack }
    | Cfg, Some (Cfg, _) ->
      let items = List.map to_cfg_format u.items in
      Cfg_format.save filename { items; unit_name; for_pack }
    | (Linear | Cfg), None | Linear, Some (Cfg, _) | Cfg, Some (Linear, _) ->
      Misc.fatal_errorf
        "Mismatch between content of unit to save and filename extension %s"
        filename
  ;;

  let restore filename =
    match Clflags.Compiler_ir.extract_extension_with_pass filename with
    | Some (Linear, _) ->
      let u, digest = Linear_format.restore filename in
      let items = List.map of_linear_format u.items in
      let u' = { unit_name = u.unit_name; items; for_pack = u.for_pack; ir = Linear } in
      u', digest
    | Some (Cfg, _) ->
      let u, digest = Cfg_format.restore filename in
      let items = List.map of_cfg_format u.items in
      let u' = { unit_name = u.unit_name; items; for_pack = u.for_pack; ir = Cfg } in
      u', digest
    | None -> Misc.fatal_errorf "Unexpected filename extension %s" filename ()
  ;;
end
