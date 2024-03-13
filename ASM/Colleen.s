.intel_syntax noprefix
.globl _start
.text
_start:
	call me_quine
	xor rdi, rdi
	mov eax, 0x3c
	syscall
/*
	The function of the comment is to comment the function above or below 
*/
me_quine:
	push rbp
	mov rbp, rsp
	sub rsp, 0x400
	mov ecx, 666
	lea rsi, src
hm:	movb dl, [rsi+rcx]
	cmp dl, 0x7e
	jne n
	sub dl, 0x74
n:	movb [rsp+rcx], dl
	dec ecx
	jns hm
	mov rsi, rsp
	mov edi, 0x1
	mov edx, 666
	mov eax, 0x1
	syscall
	lea rsi, quo
	mov edx, 0x1
	mov eax, 0x1
	syscall
	lea rsi, src
	mov edx, 666
	mov eax, 0x1
	syscall
	lea rsi, end
	mov edx, 0x2
	mov eax, 0x1
	syscall
	mov rsp, rbp
	pop rbp
	ret
.data
/*
	nop
*/
quo: .byte 0x22
end: .word 0x0a22
src: .ascii ".intel_syntax noprefix~.globl _start~.text~_start:~	call me_quine~	xor rdi, rdi~	mov eax, 0x3c~	syscall~/*~	The function of the comment is to comment the function above or below ~*/~me_quine:~	push rbp~	mov rbp, rsp~	sub rsp, 0x400~	mov ecx, 666~	lea rsi, src~hm:	movb dl, [rsi+rcx]~	cmp dl, 0x7e~	jne n~	sub dl, 0x74~n:	movb [rsp+rcx], dl~	dec ecx~	jns hm~	mov rsi, rsp~	mov edi, 0x1~	mov edx, 666~	mov eax, 0x1~	syscall~	lea rsi, quo~	mov edx, 0x1~	mov eax, 0x1~	syscall~	lea rsi, src~	mov edx, 666~	mov eax, 0x1~	syscall~	lea rsi, end~	mov edx, 0x2~	mov eax, 0x1~	syscall~	mov rsp, rbp~	pop rbp~	ret~.data~/*~	nop~*/~quo: .byte 0x22~end: .word 0x0a22~src: .ascii "
