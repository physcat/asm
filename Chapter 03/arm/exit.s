.section .data

.section .text
.globl _start
_start:
	mov %r0, $123	/* return/exit code */
	mov %r7, $1	/* sys_exit */
	swi $0		/* call the kernel (interupt) */
