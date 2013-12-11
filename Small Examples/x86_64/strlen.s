# Program returns the length of str
.section .data
str:
	.ascii "Hello"

.section .text
.globl _start
_start:
	push $str
	call strlen
	addq $8, %rsp

	movq %rax, %rbx	# use strlen as exit code 
	movq $1, %rax
	int $0x80

.type strlen, @function
strlen:
	push %rbp
	movq %rsp, %rbp

	movq 16(%rbp), %rbx	# the address to a string
	movq %rbx, %rax
strlen_loop:
	cmpb $0x0, (%rax)	# notice the cmpb - each character in
						# the string is only a byte not a long!
	je strlen_end
	incq %rax
	jmp strlen_loop
strlen_end:
	subq %rbx, %rax
	movq %rbp, %rsp
	pop %rbp
	ret
