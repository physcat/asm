.section .data

.section .text
.globl _start
_start:
	mov %r0, #0	/* return/exit code */
	mov %r7, #1	/* sys_exit */
	svc #0		/* supervisor call (call the kernel) */
				/* this use to be called the Software Interrupt - swi */
