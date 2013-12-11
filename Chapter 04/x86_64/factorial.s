#PURPOSE - Given a number, this program computes the
#          factorial.  For example, the factorial of
#          3 is 3 * 2 * 1, or 6.  The factorial of
#          4 is 4 * 3 * 2 * 1, or 24, and so on.
#

#This program shows how to call a function recursively.

.section .data
#This program has no global data

.section .text
.globl _start
.globl factorial		#this is unneeded unless we want to share
						#this function among other programs
_start:
	push $4				#The factorial takes one argument - the
							#number we want a factorial of.  So, it
							#gets pushed
	call  factorial			#run the factorial function
	addq  $8, %rsp			#Scrubs the parameter that was pushed on
							#the stack
	movq  %rax, %rdi		#factorial returns the answer in %eax, but
							#we want it in %edi to send it as our exit
							#status
	movq  $0x3c, %rax			#call the kernel's exit function
	syscall


#This is the actual function definition
.type factorial,@function
factorial:
	push %rbp				#standard function stuff - we have to
							#restore %ebp to its prior state before
							#returning, so we have to push it
	movq  %rsp, %rbp		#This is because we don't want to modify
							#the stack pointer, so we use %ebp.
	
	movq  16(%rbp), %rax		#This moves the first argument to %eax
							#4(%ebp) holds the return address, and
							#8(%ebp) holds the first parameter
	cmpq  $1, %rax			#If the number is 1, that is our base
							#case, and we simply return (1 is
							#already in %eax as the return value)
	je end_factorial
	decq  %rax				#otherwise, decrease the value
	pushq %rax				#push it for our call to factorial
	call  factorial			#call factorial
	movq  16(%rbp), %rbx		#%eax has the return value, so we
							#reload our parameter into %ebx
	imulq %rbx, %rax		#multiply that by the result of the
							#last call to factorial (in %eax)
							#the answer is stored in %eax, which
							#is good since that's where return
							#values go.
end_factorial:
	movq  %rbp, %rsp		#standard function return stuff - we
	pop  %rbp				#have to restore %ebp and %esp to where
							#they were before the function started
	ret						#return from the function (this pops the
							#return value, too)
	
