.intel_syntax noprefix
.globl _start
.text
.macro BOOT
	call quineify
	xor rdi, rdi
	mov eax, 0x3c
	syscall
.endm
_start:BOOT
quineify:
	push rbp
	mov rbp, rsp
	call procreate
	mov r8, rax
	lea rsi, src
	sub rsp, 0x400
	mov ecx, 830
foo:movb al, [rsi+rcx]
	cmp al, 0x7e
	jne bar
	sub al, 0x74
bar:movb [rsp+rcx], al
	dec ecx
	jns foo
	mov rdi, r8
	lea rsi, [rsp]
	mov edx, 830
	mov eax, 0x1
	syscall
	mov esi, offset spc
	mov edx, 0x1
	mov eax, 0x1
	syscall
	lea rsi, src
	mov edx, 830
	mov eax, 0x1
	syscall
	mov esi, offset spc
	mov edx, 0x2
	mov eax, 0x1
	syscall
	mov rdi, r8
	mov eax, 0x3
	syscall
	mov rsp, rbp
	pop rbp
	ret
procreate:
	mov edi, offset chl
	mov sil, 0101
	mov edx, 0644
	mov eax, 0x2
	syscall
	ret
.data
spc: .byte 0x22,0x0a
chl: .byte 0x47,0x72,0x61,0x63,0x65,0x5f,0x6b,0x69,0x64,0x2e,0x73,0x0
src: .ascii ".intel_syntax noprefix~.globl _start~.text~.macro BOOT~	call quineify~	xor rdi, rdi~	mov eax, 0x3c~	syscall~.endm~_start:BOOT~quineify:~	push rbp~	mov rbp, rsp~	call procreate~	mov r8, rax~	lea rsi, src~	sub rsp, 0x400~	mov ecx, 830~foo:movb al, [rsi+rcx]~	cmp al, 0x7e~	jne bar~	sub al, 0x74~bar:movb [rsp+rcx], al~	dec ecx~	jns foo~	mov rdi, r8~	lea rsi, [rsp]~	mov edx, 830~	mov eax, 0x1~	syscall~	mov esi, offset spc~	mov edx, 0x1~	mov eax, 0x1~	syscall~	lea rsi, src~	mov edx, 830~	mov eax, 0x1~	syscall~	mov esi, offset spc~	mov edx, 0x2~	mov eax, 0x1~	syscall~	mov rdi, r8~	mov eax, 0x3~	syscall~	mov rsp, rbp~	pop rbp~	ret~procreate:~	mov edi, offset chl~	mov sil, 0101~	mov edx, 0644~	mov eax, 0x2~	syscall~	ret~.data~spc: .byte 0x22,0x0a~chl: .byte 0x47,0x72,0x61,0x63,0x65,0x5f,0x6b,0x69,0x64,0x2e,0x73,0x0~src: .ascii "
