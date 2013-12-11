.section .data

.section .bss
.equ BUFFER_SIZE, 500
.lcomm BUFFER_DATA, BUFFER_SIZE

.section .text
.globl _start
_start:
	movq %rsp, %rbp
	addq $8, %rsp
	movq (%rbp), %rax
	cmpq $2, %rax 
	jne _end

	movq $2, %rax		# sys_open
	movq 16(%rbp), %rdi	# vargv[1] = filename
	movq $0, %rsi		# O_RDONLY = 0, open read only
	movq $0666, %rdx	# permissions don't really matter
	syscall
	movq %rax, -8(%rbp) # save the file handle

_read_loop:
	movq $0, %rax
	movq -8(%rbp), %rdi
	movq $BUFFER_DATA, %rsi
	movq $BUFFER_SIZE, %rdx
	syscall

	movq %rax, %rdx 
	movq $1, %rax
	movq $1, %rdi
	movq $BUFFER_DATA, %rsi
	syscall


	cmpq $BUFFER_SIZE, %rdx
	je _read_loop

_end:
	movq $0, %rdi
	movq $0x3c, %rax
	syscall

