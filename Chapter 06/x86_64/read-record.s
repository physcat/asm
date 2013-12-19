.include "record-def.s"
.include "linux.s"

#PURPOSE:   This function reads a record from the file
#          descriptor
#
#INPUT:    The file descriptor and a buffer
#
#OUTPUT:   This function writes the data to the buffer
#          and returns a status code.
#
#STACK LOCAL VARIABLES
.equ ST_READ_BUFFER, 16 
.equ ST_FILEDES, 24
.section .text
.globl read_record
.type read_record, @function
read_record:
push %rbp
movq  %rsp, %rbp

push %rbx
movq  ST_FILEDES(%rbp), %rdi
movq  ST_READ_BUFFER(%rbp), %rsi
movq  $RECORD_SIZE, %rdx
movq  $SYS_READ, %rax
syscall

#NOTE - %eax has the return value, which we will
#       give back to our calling program
pop  %rbx

movq  %rbp, %rsp
pop  %rbp
ret
