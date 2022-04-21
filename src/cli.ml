open Core

let set_verbose v =  Main.verbose := v ;
  ()

let flag_dot =
  Command.Param.(
    flag "-dot" no_arg ~doc:" emit CFG in .dot format for debug")

let flag_dot_show_instr =
  Command.Param.(
    flag "-dot-detailed" no_arg
      ~doc:" emit detailed CFG in .dot format for debug")

let flag_v =
  Command.Param.(
    flag "-verbose" ~aliases:["-v"] no_arg
      ~doc:" print lots of info for debug")

let flag_q =
  Command.Param.(
    flag "-quiet" ~aliases:["-q"] no_arg ~doc:" don't print anything")

let anon_files =
  Command.Param.(
    anon (non_empty_sequence_as_list ("FILENAME" %: string)))

let main_command =
  Command.basic ~summary:"Convert OCaml CFG to LLVM IR"
    Command.Let_syntax.(
      let%map v = flag_v
      and q = flag_q
      and files = anon_files in 
      (* and dot = flag_dot
      and show_instr = flag_dot_show_instr in *)
      if v then set_verbose true;
      if q then set_verbose false;
      fun () -> Main.print_function_names files)
      (* fun () -> Main.dump files ~dot ~show_instr) *)

let () =
  set_verbose false;
  Command.run main_command