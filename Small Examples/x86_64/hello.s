# Assembly directive:
# .equ - useful for macros kinda like #define in C
# .ascii - Great place to leave a string
# . Yeah a period on its own should be read as 'this place'
#
# Writing to the screen:
# %rax = 4, system call to write (sys_write)
# %rbx = 1, 1 is the stdout file
# %rcx = string, address for the string
# %rdx = len, length of the string

.section .data
msg:
	.ascii "Hello, world!\n"
	.equ len, . - msg		# this (address) - msg (address) = 14
							# remember \n is just one character

.section .text
.globl _start
_start:
	movq $msg, %rcx	# Address for string in %rcx
	movq $len, %rdx	# Length of string in %rdx
	movq $1, %rbx	# STDOUT is 1
	movq $4, %rax	# SYS_WRITE
	int $0x80

	movq $len, %rbx
	movq $1, %rax
	int $0x80
