.intel_syntax noprefix
.globl _start
.text
_start:
	xor rdi, rdi
	mov eax, 0x3c
	syscall
