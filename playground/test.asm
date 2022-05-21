
test.o:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <camlTest1__incr_261>:
   0:	48 8d 47 02          	lea    0x2(%rdi),%rax
   4:	c3                   	retq   
   5:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
   c:	00 00 00 
   f:	90                   	nop

0000000000000010 <camlTest1__ident_263>:
  10:	48 89 f8             	mov    %rdi,%rax
  13:	c3                   	retq   
