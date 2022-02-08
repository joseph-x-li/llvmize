open Core

module CL = Ocamlcfg.Cfg_with_layout
module CP = Ocamlcfg.Passes
module FF = Ocamlcfg.File_formats

let verbose = ref true

let dump files ~dot ~show_instr =
  let process file =
    printf "Dumping %s\n" file;
    let u, _ = FF.restore file in
    let dump_cfg oc cl =
       if dot then CL.save_as_dot ~show_instr cl "";
       CL.print cl oc ""
    in
    let dump_item oc ppf = function
      | FF.Cfg g ->
        dump_cfg oc g;
      | Data d -> Printcmm.data ppf d
      | Linear _ -> Misc.fatal_errorf "Unexpected format in %s" file
    in
    let dump_filename ext = sprintf "%s.dump.%s" file ext in
    Out_channel.with_file (dump_filename "cfg") ~f:(fun oc_cfg ->
        let ppf = Format.formatter_of_out_channel oc_cfg in
        List.iter u.items ~f:(dump_item oc_cfg ppf))

    in
  List.iter files ~f:process
