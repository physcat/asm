.include "linux.s"
.include "record-def.s"
#PURPOSE:   This function writes a record to
#           the given file descriptor
#
#INPUT:     The file descriptor and a buffer
#
#OUTPUT:    This function produces a status code
#
#STACK LOCAL VARIABLES
.equ ST_WRITE_BUFFER, 16
.equ ST_FILEDES, 24
.section .text
.globl write_record
.type write_record, @function
write_record:
push %rbp
movq  %rsp, %rbp

push %rbx
movq  $SYS_WRITE, %rax
movq  ST_FILEDES(%rbp), %rdi
movq  ST_WRITE_BUFFER(%rbp), %rsi
movq  $RECORD_SIZE, %rdx
syscall

#NOTE - %eax has the return value, which we will
#       give back to our calling program
pop  %rbx

movq  %rbp, %rsp
pop  %rbp
ret
