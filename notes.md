# TODO
 - Fix the placement of alloca statements
 - Add all the other arithmetic statements

 - Create a README that takes the project from start to finish so that seth and greta can try it over the weekend.
 - create a docker container and etc???

 # OCaml Quirks (Most to Least Severe)
 - Function currying
 - Garbage Collector
 - OCaml ABI
 - 2n + 1 integer representation
 - Polymorphism

# Important Files to Look Att
`/home/joseph/.opam/dev/.opam-switch/sources/ocaml-variants/backend/cfg/cfg_intf.ml`

`/home/joseph/.opam/dev/.opam-switch/sources/ocaml-variants/backend/cfg/cfg.ml`

`/home/joseph/.opam/dev/lib/ocaml/compiler-libs/cfg.mli`

# How To...

## Setup

 1) Install special ocaml through git pin. Point to the bootstrapped dune.exe in the dune directory.
 2) Install llvm-13 by adding llvm PPAs  
    a) Also need to symlink /usr/local/bin/llvm-config to llvm-config-13 due to install script using the executable `llvm-config`
 3) Build llvmize by running `dune build`


## Development Resources

 - [LLVM OCaml Tutorial](https://releases.llvm.org/12.0.0/docs/tutorial/OCamlLangImpl3.html)
 - [LLVM OCaml Bindings](https://llvm.moe/ocaml/)
 - [OCaml - LLVM Attempt @ ocaml-llvm-ng](https://github.com/whitequark/ocaml-llvm-ng)
 - [OCaml - LLVM Attempt @ ocamlnc](https://github.com/ramntry/ocamlnc)