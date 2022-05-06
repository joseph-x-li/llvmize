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

(* Instantiate an i64 type and its pointer *)
let i64 = Llvm.i64_type context
(* let i64p = Llvm.pointer_type i64 *)


(* Holds a map from stamp(aka int) -> Llvalue *)
let stamp2stack : (int, Llvm.llvalue) Hashtbl.t = Hashtbl.create (module Int)

(* Find the stack slot corresponding to a stamp or create a stack slot. *)
let s2s_get_val (stamp : int) =
  let ptr = Hashtbl.find_or_add 
    stamp2stack 
    stamp 
    ~default: (fun () -> Llvm.build_alloca i64 "" builder) in
  Llvm.build_load ptr "" builder

(* let s2s_get_ptr (stamp : int) =
  Hashtbl.find_or_add 
    stamp2stack 
    stamp 
    ~default: (fun () -> Llvm.build_alloca i64p "" builder) *)

let s2s_store (dest : int) (llval : Llvm.llvalue) =
  let ptr = Hashtbl.find_or_add 
    stamp2stack 
    dest 
    ~default: (fun () -> Llvm.build_alloca i64 "" builder) in
  let _ : Llvm.llvalue = Llvm.build_store llval ptr builder in 
  ()

(* Find the stack slot corresponding to a stamp or create a stack slot. *)

(* Update the stamp->llvalue mapping due to an addition or something 
  If the stamp is not in the mapping, then add it. *)
(* let s2s_update (stamp : int) (newllv : Llvm.llvalue) =
  Hashtbl.update stamp2value stamp ~f:(fun _ -> newllv) *)

(* Holds a map from int to llvm.llbasicblock so branching 
  instructions can look up the llbasicblock value here *)
let label2block : (int, Llvm.llbasicblock) Hashtbl.t = Hashtbl.create (module Int)

(* Return Llvm.llbasicblock in l2b or create one with that label *)
(* Label is int *)
let l2b_find_or_add (lbl : int) (f: Llvm.llvalue) =
  Hashtbl.find_or_add 
    label2block 
    lbl 
    ~default: (fun () -> Llvm.append_block context (sprintf "%d" lbl) f)


(* Take a basic instruction and build it into the current basic block 
  It uses the global variable builder which writes to the current basic block
  so we do not actually have to pass in a reference to the current bb (?) *)
let ll_basic_instr (instr : CG.basic CG.instruction) = 
  (* unpack instruction arguments *)
  let arg_llv = Array.map instr.arg ~f:(fun reg -> s2s_get_val (reg.stamp)) in
  (* unpack instruction destinations *)
  (* let res_llv = Array.map instr.res ~f:(fun reg -> s2s_find_or_add (reg.stamp)) in *)
  (* build the instruction *)
  match instr.desc with 
      Op Move -> 
      let a0 = arg_llv.(0) in 
      let res_stamp = instr.res.(0).stamp in
      (* Build load from arg then store to res *)
      s2s_store res_stamp a0;
    | Op Intop Iadd -> 
      let a0 = arg_llv.(0) in 
      let a1 = arg_llv.(1) in 
      let res_stamp = instr.res.(0).stamp in 
      let resllv = Llvm.build_add a0 a1 "" builder in 
      s2s_store res_stamp resllv;
    | Op Intop_imm (Iadd, n) -> 
      let a0 = arg_llv.(0) in 
      let a1 = Llvm.const_int i64 n in
      let res_stamp = instr.res.(0).stamp in 
      let resllv = Llvm.build_add a0 a1 "" builder in 
      s2s_store res_stamp resllv;
    | _ -> printf "HIT UNIMPLEMENTED MATCH ARM @ BASIC INSTR\n"; ()

let ll_terminator_instr (f: Llvm.llvalue) (instr : CG.terminator CG.instruction) = 
  let arg_llv = Array.map instr.arg ~f:(fun reg -> s2s_get_val (reg.stamp)) in
  match instr.desc with 
    Always nextlbl -> 
      let nextbb = l2b_find_or_add nextlbl f in
      let _: Llvm.llvalue = Llvm.build_br nextbb builder in ()
    | Return -> let _: Llvm.llvalue = Llvm.build_ret arg_llv.(0) builder in ()
    | _ -> printf "HIT UNIMPLEMENTED MATCH ARM @ TERMINATOR INSTR\n"; ()


let ll_block (f: Llvm.llvalue) (lbl: Label.t) (blk: CG.Basic_block.t) = 
  printf "Translating Block %d\n" lbl;
  (* create basic block *)
  let currbb = l2b_find_or_add lbl f in
  let terminator = CG.Basic_block.terminator blk in
  Llvm.position_at_end currbb builder;
  (* Translate basic instructions *)
  List.iter (CG.Basic_block.body blk) ~f:(fun instr -> ll_basic_instr instr);
  (* Translate terminator instruction *)
  ll_terminator_instr f terminator


(* Translate a CFG by creating a function in Llvm 
  and declaring it in the module. 
  The function declaration also creates llvalues for the args,
  so we can place those into the named_values *)
let ll_cfg (g : CL.t) = 
  (* clear stamp2value *)
  Hashtbl.clear stamp2stack;
  (* clear label2block *)
  Hashtbl.clear label2block;
  (* create the function *)
  let cfg = CL.cfg g in
  let funcname = CG.fun_name cfg in
  (* Return early if function name is "camlTest1__entry" 
  because it contains instructions that I have no clue how to translate 
  like const_symbol? (function pointers for vtable?)
  *)
  if String.equal funcname "camlTest1__entry" then () else
  let nargs = CG.num_args cfg in
  let args = CG.get_args cfg in
  let ft = Llvm.function_type i64 (Array.create ~len:nargs i64) in
  let f: Llvm.llvalue = Llvm.declare_function funcname ft llmodule in
  let entry_label = CG.entry_label cfg in
  let first_block = l2b_find_or_add entry_label f in
  (* Start at first block *)
  Llvm.position_at_end first_block builder;
  (* Build the function arguments 
     Also add instructions to store arguments *)
  Array.iteri (Llvm.params f) ~f:(fun idx llval -> s2s_store args.(idx).stamp llval);
  CG.iter_blocks cfg ~f:(ll_block f);
  Llvm_analysis.assert_valid_function f;
  Llvm.print_module "test.ll" llmodule;
  ()



(* Parse a file and print out the function names and its type *)
let change_this_name files = 
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
        | Cfg g -> if false then print_cfg g else ll_cfg g
      ) 
    in 
    (* Parse u.for_pack *)
    printf "for_pack: %s\n" (match u.for_pack with | Some s -> s | None -> "None");
    (* Parse u.ir *)
    printf "ir: %s\n" (Clflags.Compiler_ir.to_string u.ir);
    ()
  in (* end: process *)
  List.iter files ~f:process;