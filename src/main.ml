open Core

module CG = Ocamlcfg.Cfg
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

(* Print out ONE basic instructon and the stamp of the arguments followed by a 
  bar then followed by the stamp of the destination. *)
let print_basic_instr_ln (instr : CG.basic CG.instruction) = 
  CG.print_basic stdout instr;
  printf " |";
  Array.iter instr.arg ~f:(fun reg -> printf " %d" (reg.stamp));
  printf " ;";
  Array.iter instr.res ~f:(fun reg -> printf " %d" (reg.stamp));
  printf "\n"

(* Print out ONE terminator instructon and the stamp of the arguments followed by a 
  bar then followed by the stamp of the destination. *)
let print_terminator_instr_ln (instr : CG.terminator CG.instruction) = 
  CG.print_terminator stdout instr;
  printf " |";
  Array.iter instr.arg ~f:(fun reg -> printf " %d" (reg.stamp));
  printf " ;";
  Array.iter instr.res ~f:(fun reg -> printf " %d" (reg.stamp));
  printf "\n"

(* Print a basic block by printing its block label number followed by the basic
  instructions and finally the terminator instruction *)
let print_block (lbl : Label.t) (blk : CG.Basic_block.t) = 
  printf "*****Block %d*****\n" lbl;
  List.iter (CG.Basic_block.body blk) ~f:(print_basic_instr_ln);
  print_terminator_instr_ln (CG.Basic_block.terminator blk)

(* Print a CFG by printing its blocks *)
let print_cfg (g : CL.t) = 
  let cfg = CL.cfg g in 
  let nargs = CG.num_args cfg in
  printf "*****CFG*****\n";
  printf "fun_name: %s\n" (CG.fun_name cfg);
  printf "fun_args: %d\n" nargs;
  CG.iter_blocks cfg ~f:(print_block);
  ()

let context = Llvm.global_context ()
let llmodule = Llvm.create_module context "testmodule"
let builder = Llvm.builder context

(* Instantiate a i64 type *)
let i64 = Llvm.i64_type context

(* Holds a map from stamp(aka int) -> Llvalue *)
let named_values : (int, Llvm.llvalue) Hashtbl.t = Hashtbl.create (module Int)

(* Translate a CFG by creating a function in Llvm 
  and  *)
let ll_cfg (g : CL.t) = 
  let cfg = CL.cfg g in
  let funcname = CG.fun_name cfg in
  let nargs = CG.num_args cfg in
  let args = CG.get_args cfg in
  let ft = Llvm.function_type i64 (Array.create ~len:nargs i64) in
  (*  *)
  let f = Llvm.declare_function funcname ft llmodule in
  Array.iteri (Llvm.params f) 
  ~f:(fun i a -> 
      let name = args.(i).stamp in 
      Hashtbl.add_exn named_values ~key:name ~data:a;
  );



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
        | Cfg g -> print_cfg g
      ) 
    in 
    (* Parse u.for_pack *)
    printf "for_pack: %s\n" (match u.for_pack with | Some s -> s | None -> "None");
    (* Parse u.ir *)
    printf "ir: %s\n" (Clflags.Compiler_ir.to_string u.ir);
    ()
  in (* end: process *)
  List.iter files ~f:process;