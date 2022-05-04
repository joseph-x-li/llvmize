# HOW-TO

 1) Install special ocaml through git pin. Point to the bootstrapped dune.exe in the dune directory.
 2) Install llvm-13 by adding llvm PPAs
   a) Also need to symlink /usr/local/bin/llvm-config to llvm-config-13 due to install script using the executable `llvm-config`
 3) Build llvmize by running `dune build`


# Resources

 - [LLVM OCaml Bindings](https://releases.llvm.org/12.0.0/docs/tutorial/OCamlLangImpl3.html)
 - [OCaml - LLVM Attempt @ ocaml-llvm-ng](https://github.com/whitequark/ocaml-llvm-ng)
 - [OCaml - LLVM Attempt @ ocamlnc](https://github.com/ramntry/ocamlnc)