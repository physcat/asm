.syntax unified
.data
message:
	.ascii "Hello, world.\n"
	.equ len, . - message

.text
.global _start
_start:
        mov     r0, #1		/* STDOUT */
        ldr     r1, =message	/* Load Register - string address in r1 */
        ldr     r2, =len	/* lenght of string in r2 */
        mov     r7, #4		/* SYS_WRITE system call to write */
        svc     #0x0		/* interupt - call the kernel */
 
        mov     r0, #0		/* return code in r0 */
        mov     r7, #1		/* SYS_EXIT */
        svc     #0x0 		/* supervisor call - call the kernel */
