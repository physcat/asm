.section .data

.section .bss
.equ BUFFER_SIZE, 500
.lcomm BUFFER_DATA, BUFFER_SIZE

.section .text
.globl _start
_start:
	movl %esp, %ebp
	addl $4, %esp
	movl (%ebp), %eax
	cmpl $2, %eax 
	jne _end

	movl $5, %eax		# sys_open
	movl 8(%ebp), %ebx	# vargv[1] = filename
	movl $0, %ecx		# O_RDONLY = 0, open read only
	movl $0666, %edx	# permissions don't really matter
	int $0x80
	movl %eax, -4(%ebp) # save the file handle

_read_loop:
	movl $3, %eax
	movl -4(%ebp), %ebx
	movl $BUFFER_DATA, %ecx
	movl $BUFFER_SIZE, %edx
	int $0x80

	movl %eax, %edx 
	movl $4, %eax
	movl $1, %ebx
	movl $BUFFER_DATA, %ecx
	int $0x80


	cmpl $BUFFER_SIZE, %edx
	je _read_loop


_end:
	movl $1, %eax
	int $0x80

