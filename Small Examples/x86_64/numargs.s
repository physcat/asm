# This program returns the number of 
# arguments passed to the program (argc)
# when the program starts %esp points to argc
#
# run ./numargs one two
# check with echo $? as usual.
# note: this example gives 3 as the program names is also counted.
.section .data

.section .text
.globl _start
_start:
	movq $0, %rax
	movq (%rsp,%rax, 8), %rbx
	movq $1, %rax
	int $0x80
