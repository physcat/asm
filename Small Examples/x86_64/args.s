# nothing new here, Just combining some of the previous ideas into something 
# a bit bigger
# 
# run: ./args one two three etc
#
.section .data
ENDL:
	.ascii "\n"

.section .text
.globl _start
_start:
	push %rsp		# push address of argc
	call print_args
	addq $4, %rsp

	movq %rax, %rdi	# use the function exit status as the final exit status
	movq $0x3c, %rax
	syscall


.type print_args, @function
print_args:
	push %rbp			# save the old ebp
	movq %rsp, %rbp		# ebp now points to current esp
	subq $8, %rsp		# space on the stack
	movq 16(%rbp), %rbx	# address for argc !
	movq (%rbx), %rax	# argc into %rax
print_loop:
	cmpq $0, %rax
	je print_args_end

	decq %rax
	movq %rax, -8(%rbp)		# store the number of args left
	
	push 8(%rbx, %rax, 8)	# push the address for the string
	call strlen
	movq %rax, %rdx			# str length in %rdx
	pop %rsi				# str address in %rcx
	movq $1, %rdi			# stdout - 1
	movq $1, %rax			# sys_write - 4
	syscall

	movq $ENDL, %rsi	# \n
	movq $1, %rdx		# len
# don't make the mistake to think these will still be set after in interrupt call
# they really won't be!
	movq $1, %rdi			# stdout - 1
	movq $1, %rax			# sys_write - 4
	syscall

	movq -8(%rbp), %rax		# How many left again?
	movq 16(%rbp), %rbx		# address for argc, how else are we going 
							# to know where argv is?
	jmp print_loop

print_args_end:
	movq %rbp, %rsp
	pop %rbp
	ret


.type strlen, @function
strlen:
	push %rbp
	movq %rsp, %rbp

	movq 16(%rbp), %rbx
	movq %rbx, %rax
strlen_loop:
	cmpb $0x0, (%rax)
	je strlen_end
	incq %rax
	jmp strlen_loop
strlen_end:
	subq %rbx, %rax
	movq %rbp, %rsp
	pop %rbp
	ret
