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
	pushl %esp		# push address of argc
	call print_args
	addl $4, %esp

	movl %eax, %ebx	# use the function exit status as the final exit status
	movl $1, %eax
	int $0x80


.type print_args, @function
print_args:
	pushl %ebp			# save the old ebp
	movl %esp, %ebp		# ebp now points to current esp
	subl $4, %esp		# space on the stack
	movl 8(%ebp), %ebx	# address for argc !
	movl (%ebx), %eax	# argc into %eax
print_loop:
	cmpl $0, %eax
	je print_args_end

	decl %eax
	movl %eax, -4(%ebp)		# store the number of args left
	
	push 4(%ebx, %eax, 4)	# push the address for the string
	call strlen
	movl %eax, %edx			# str length in %edx
	popl %ecx				# str address in %ecx
	movl $1, %ebx			# stdout - 1
	movl $4, %eax			# sys_write - 4
	int $0x80

	movl $ENDL, %ecx	# \n
	movl $1, %edx		# len
# don't make the mistake to think these will still be set after in interrupt call
# they really won't be!
	movl $1, %ebx			# stdout - 1
	movl $4, %eax			# sys_write - 4
	int $0x80

	movl -4(%ebp), %eax		# How many left again?
	movl 8(%ebp), %ebx		# address for argc, how else are we going 
							# to know where argv is?
	jmp print_loop

print_args_end:
	movl %ebp, %esp
	popl %ebp
	ret


.type strlen, @function
strlen:
	pushl %ebp
	movl %esp, %ebp

	movl 8(%ebp), %ebx
	movl %ebx, %eax
strlen_loop:
	cmpb $0x0, (%eax)
	je strlen_end
	incl %eax
	jmp strlen_loop
strlen_end:
	subl %ebx, %eax
	movl %ebp, %esp
	popl %ebp
	ret
