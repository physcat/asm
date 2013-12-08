#PURPOSE:  This program finds the maximum number of a
#          set of data items.
#
#VARIABLES: The registers have the following uses:
#
# %rdi - Holds the index of the data item being examined
# %rbx - Largest data item found
# %rax - Current data item
#
# The following memory locations are used:
#
# data_items - contains the item data.  A 0 is used
#              to terminate the data
#

.section .data

	data_items:		#These are the data items
		.long 3,67,34,222,45,75,54,34,44,33,22,11,66,0	# 32 bit integers
#		.quad 3,67,34,222,45,75,54,34,44,33,22,11,66,0	# 64 bit integers

.section .text

.globl _start
_start:
	movq $0, %rdi					# move 0 into the index register
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# Careful here, data_items are longs (32 bit) so use movl 
# and only use the 32 bit half of rax ie. eax
	movl data_items(,%rdi,4), %eax	# load the first byte of data (32 bit integers - long)
#	movq data_items(,%rdi,8), %rax	# load the first byte of data (64 bit integers - quad)
	movq %rax, %rbx					# since this is the first item,
									# %qax is the biggest

start_loop:							# start loop
	cmpq $0, %rax					# check to see if we've hit the end
	je loop_exit
	incq %rdi						# load next value
	movl data_items(,%rdi,4), %eax	# (32 bit integers - long)
#	movq data_items(,%rdi,8), %rax	# (64 bit integers - quad)
	cmpq %rbx, %rax					# compare values
	jle start_loop					# jump to loop beginning if the new
									# one isn't bigger
	movq %rax, %rbx					# move the value as the largest
	jmp start_loop					# jump to loop beginning
	
loop_exit:
# %rbx is the status code for the exit system call
# and it already has the maximum number

	movq $1, %rax					#1 is the exit() syscall
    int  $0x80
