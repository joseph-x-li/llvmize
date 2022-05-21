# README

## Building 
 1) Clone this repo
 2) Download [this](https://hub.docker.com/repository/docker/dockercat9000/jst-compilers) docker container: `docker pull dockercat9000/jst-compilers:latest`
 3) Run the container and mount this repo. For example: `docker run -v /home/joseph/Github/llvmize:/data -td dockercat9000/jst-compilers`  
  a) NOTE: Only use absolute paths in the `-v` flag.  
  b) NOTE: These `docker` commands might need `sudo`.  
 4) Create a terminal in the container with `docker exec -it #### /bin/bash` where `####` are the beginning few digits of the container hash.
 5) Run `source ~/.profile` to setup the OCaml paths.
 6) Run `dune build` in `/data` to build the project.

## Usage
 1) Go to the `playground` directory.
 2) Run `make` to use `test1.ml` to create `test.ll`.
 3) Run `make asm` to use `test.ll` to generate `test.asm`.
 4) Edit `test1.ml` to test different OCaml programs.
 4) Run `make clean` to clean intermediate files.