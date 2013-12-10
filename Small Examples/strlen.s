# Program returns the length of str
.section .data
str:
	.ascii "Hello World\n"

.section .text
.globl _start
_start:
	push $str
	call strlen
	addl $4, %esp

	movl %eax, %ebx	# use strlen as exit code 
	movl $1, %eax
	int $0x80

.type strlen, @function
strlen:
	pushl %ebp
	movl %esp, %ebp

	movl 8(%ebp), %ebx	# the address to a string
	movl %ebx, %eax
strlen_loop:
	cmpb $0x0, (%eax)	# notice the cmpb - each character in
						# the string is only a byte not a long!
	je strlen_end
	incl %eax
	jmp strlen_loop
strlen_end:
	subl %ebx, %eax
	movl %ebp, %esp
	popl %ebp
	ret
