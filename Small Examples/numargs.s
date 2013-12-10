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
	movl $0, %eax
	movl (%esp,%eax, 4), %ebx
	movl $1, %eax
	int $0x80
