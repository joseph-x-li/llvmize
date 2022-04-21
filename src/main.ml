open Core

module CL = Ocamlcfg.Cfg_with_layout
module CP = Ocamlcfg.Passes
module FF = Ocamlcfg.File_formats

let verbose = ref true

let dump files ~dot ~show_instr =
  let process file =
    printf "Dumping %s\n" file;
    let u, _ = FF.restore file in
    let 
      dump_cfg oc cl = (* out channel, CL.t *)
       if dot then (
        CL.save_as_dot ~show_instr cl "";
        CL.print cl oc ""
      )
    in
    let 
      dump_item oc ppf = function
        | FF.Cfg g -> dump_cfg oc g;
        | Data d ->   Printcmm.data ppf d
        | Linear _ -> Misc.fatal_errorf "Unexpected format in %s" file
    in
    let 
      dump_filename ext = sprintf "%s.dump.%s" file ext 
    in
    Out_channel.with_file
      (dump_filename "cfg")
      ~f:(fun oc_cfg -> let ppf = Format.formatter_of_out_channel oc_cfg in
        List.iter u.items ~f:(dump_item oc_cfg ppf))

  in
  (* iter over a list of filenames; provide, by name, a lambda. *)
  List.iter files ~f:process 

(* let context = Llvm.global_context ()
let llmodule = Llvm.create_module context "testmodule"
let i64 = Llvm.i64_type context

(* Create a llvm function that takes two i64 and returns their sum 
   Called incr_int: i64 * i64 -> i64 *)
let llvm_dummy_func = 
   let ft = Llvm.function_type i64 (Array.create ~len:2 i64) in
   Llvm.declare_function "incr_int" ft llmodule 
   Llvm. *)

(* Parse a file and print out the function names and its type *)
let print_function_names files = 
  let process file = 
    printf "Parsing %s\n" file;
    let u, _ = FF.restore file in 
    (* Parse four fileds of u. Begin with unit_name *)
    printf "unit_name: %s\n" u.unit_name;
    (* Parse u.items *)
    printf "items: \n"; 
    let _ : unit list = List.map u.items ~f:(
      fun uitem -> match uitem with 
        | Linear _ -> ()
        | Data _ -> ()
        | Cfg g -> let cfg = CL.cfg g in printf "CFG fun_name: %s\n" (Ocamlcfg.Cfg.fun_name cfg)
      ) 
    in 
    (* Parse u.for_pack *)
    printf "for_pack: %s\n" (match u.for_pack with | Some s -> s | None -> "None");
    (* Parse u.ir *)
    printf "ir: %s\n" (Clflags.Compiler_ir.to_string u.ir);
    ()
  in (* end: process *)
  List.iter files ~f:process;