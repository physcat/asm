# Assembly directive:
# .equ - useful for macros kinda like #define in C
# .ascii - Great place to leave a string
# . Yeah a period on its own should be read as 'this place'
#
# Writing to the screen:
# %eax = 4, system call to write (sys_write)
# %ebx = 1, 1 is the stdout file
# %ecx = string, address for the string
# %edx = len, length of the string

.section .data
msg:
	.ascii "Hello, world!\n"
	.equ len, . - msg		# this (address) - msg (address) = 14
							# remember \n is just one character

.section .text
.globl _start
_start:
	movl $msg, %ecx	# Address for string in %ecx
	movl $len, %edx	# Length of string in %edx
	movl $1, %ebx	# STDOUT is 1
	movl $4, %eax	# SYS_WRITE
	int $0x80

	movl $len, %ebx
	movl $1, %eax
	int $0x80
