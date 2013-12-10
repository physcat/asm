.syntax unified
.data
message:
        .asciz "Hello, world.\n"
	len = . - message

.text
.global _start
_start:
        mov     r0, $1		/* STDOUT */
        ldr     r1, =message	/* string address in r1 */
        ldr     r2, =len	/* lenght of string in r2 */
        mov     r7, $4		/* SYS_WRITE system call to write */
        swi     $0		/* interupt - call the kernel */
 
        mov     r0, $0		/* return code in r0 */
        mov     r7, $1		/* SYS_EXIT */
        swi     $0 		/* interupt - call the kernel */
