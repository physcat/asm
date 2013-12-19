.include "linux.s"
.globl write_newline
.type write_newline, @function
.section .data
newline:
.ascii "\n"
.section .text
.equ ST_FILEDES, 16
write_newline:
push %rbp
movq  %rsp, %rbp

movq  $SYS_WRITE, %rax
movq  ST_FILEDES(%rbp), %rdi
movq  $newline, %rsi
movq  $1, %rdx
syscall

movq  %rbp, %rsp
popq  %rbp
ret
