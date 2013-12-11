# Assembly directive:
# .equ - useful for macros kinda like #define in C
# .ascii - Great place to leave a string
# . Yeah a period on its own should be read as 'this place'
#
# Writing to the screen:
# %rax = 1, system call to write (sys_write)
# %rdi = 1, 1 is the stdout file
# %rsi = string, address for the string
# %rdx = len, length of the string

.section .data
msg:
	.ascii "Hello, world!\n"
	.equ len, . - msg		# this (address) - msg (address) = 14
							# remember \n is just one character

.section .text
.globl _start
_start:
	movq $msg, %rsi	# Address for string in %rcx
	movq $len, %rdx	# Length of string in %rdx
	movq $1, %rdi	# STDOUT is 1
	movq $1, %rax	# SYS_WRITE
	syscall

	movq $len, %rdi
	movq $0x3c, %rax
	syscall	
