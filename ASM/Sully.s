.intel_syntax noprefix
.globl _start
.text
.macro VON
	sub rsp, 0x900
	mov rsi, offset src
	mov r8d, 2067
	dec byte ptr [rsi+r8-290]
	mov ecx, r8d
jo:	movb al, [rsi+rcx]
	cmp al, 0x7e
	jne hn
	sub al, 0x74
hn:	movb [rsp+rcx], al
	dec cx
	jns jo
.endm
.macro NEU
	mov rax, offset i
	movb al, [rax]
	add al, 0x30
	mov rdi, offset n
	movb [rdi+6], al
	mov esi, 01101
	mov edx, 0644
	mov eax, 0x2
	syscall
	mov edi, eax
	test eax, eax
	js xit
	lea rsi, [rsp]
	mov edx, r8d
	mov eax, 0x1
	syscall
	add rsp, 0x400
	mov rsi, offset e
	mov edx, 0x1
	mov eax, 0x1
	syscall
	mov rsi, offset src
	mov edx, r8d
	mov eax, 0x1
	syscall
	mov rsi, offset e
	mov edx, 0x2
	mov eax, 0x1
	syscall
	mov eax, 0x3
	syscall
.endm
.macro MANN
	mov dil, i
	test dil, dil
	jz xit
	sub rsp, 0x40
	mov eax, 58
	syscall
	test eax, eax
	jnz lin
	mov rcx, offset as
	mov [rsp], rcx
	mov rcx, offset n
	mov [rsp+8], rcx
	mov qword ptr [rsp+16], 0x0
	mov rdi, offset as
	lea rsi, [rsp]
	mov edx, 0x0
	mov eax, 59
	syscall
	jmp xit
lin:mov edi, eax
	mov rsi, rsp
	mov edx, 0x0
	mov r10, 0x0
	mov eax, 61
	syscall
	mov eax, 58
	syscall
	test eax, eax
	jnz run
	mov rcx, offset ld
	mov [rsp], rcx
	mov rcx, offset t
	mov [rsp+8], rcx
	mov rcx, offset o
	mov [rsp+16], rcx
	mov rcx, offset n
	movb [rcx+7], 0x0
	mov [rsp+24], rcx
	mov qword ptr [rsp+32], 0x0
	mov rdi, offset ld
	lea rsi, [rsp]
	mov edx, 0x0
	mov eax, 59
	syscall
	jmp xit
run:mov edi, eax
	mov rsi, rsp
	mov edx, 0x0
	mov r10, 0x0
	mov eax, 61
	syscall
	mov rdi, offset t
	mov eax, 87
	syscall
	mov rcx, offset n
	movb [rcx+7], 0x0
	mov [rsp], rcx
	mov qword ptr [rsp+8], 0x0
	mov rdi, offset n
	lea rsi, [rsp]
	mov edx, 0x0
	mov eax, 59
	syscall
	add rsp, 0x40
.endm
_start: VON;NEU;MANN
	xor rdi, rdi
xit:mov eax, 0x3c
	syscall

.data
i: .byte 5
e: .byte 0x22,0x0a
o: .byte 0x2d,0x6f,0x0
t: .byte 0x61,0x2e,0x6f,0x75,0x74,0x0
n: .byte 0x53,0x75,0x6c,0x6c,0x79,0x5f,0x05,0x2e,0x73,0x0
as: .byte 0x2f,0x75,0x73,0x72,0x2f,0x62,0x69,0x6e,0x2f,0x61,0x73,0x0
ld: .byte 0x2f,0x75,0x73,0x72,0x2f,0x62,0x69,0x6e,0x2f,0x6c,0x64,0x0
src: .ascii ".intel_syntax noprefix~.globl _start~.text~.macro VON~	sub rsp, 0x900~	mov rsi, offset src~	mov r8d, 2067~	dec byte ptr [rsi+r8-290]~	mov ecx, r8d~jo:	movb al, [rsi+rcx]~	cmp al, 0x7e~	jne hn~	sub al, 0x74~hn:	movb [rsp+rcx], al~	dec cx~	jns jo~.endm~.macro NEU~	mov rax, offset i~	movb al, [rax]~	add al, 0x30~	mov rdi, offset n~	movb [rdi+6], al~	mov esi, 01101~	mov edx, 0644~	mov eax, 0x2~	syscall~	mov edi, eax~	test eax, eax~	js xit~	lea rsi, [rsp]~	mov edx, r8d~	mov eax, 0x1~	syscall~	add rsp, 0x400~	mov rsi, offset e~	mov edx, 0x1~	mov eax, 0x1~	syscall~	mov rsi, offset src~	mov edx, r8d~	mov eax, 0x1~	syscall~	mov rsi, offset e~	mov edx, 0x2~	mov eax, 0x1~	syscall~	mov eax, 0x3~	syscall~.endm~.macro MANN~	mov dil, i~	test dil, dil~	jz xit~	sub rsp, 0x40~	mov eax, 58~	syscall~	test eax, eax~	jnz lin~	mov rcx, offset as~	mov [rsp], rcx~	mov rcx, offset n~	mov [rsp+8], rcx~	mov qword ptr [rsp+16], 0x0~	mov rdi, offset as~	lea rsi, [rsp]~	mov edx, 0x0~	mov eax, 59~	syscall~	jmp xit~lin:mov edi, eax~	mov rsi, rsp~	mov edx, 0x0~	mov r10, 0x0~	mov eax, 61~	syscall~	mov eax, 58~	syscall~	test eax, eax~	jnz run~	mov rcx, offset ld~	mov [rsp], rcx~	mov rcx, offset t~	mov [rsp+8], rcx~	mov rcx, offset o~	mov [rsp+16], rcx~	mov rcx, offset n~	movb [rcx+7], 0x0~	mov [rsp+24], rcx~	mov qword ptr [rsp+32], 0x0~	mov rdi, offset ld~	lea rsi, [rsp]~	mov edx, 0x0~	mov eax, 59~	syscall~	jmp xit~run:mov edi, eax~	mov rsi, rsp~	mov edx, 0x0~	mov r10, 0x0~	mov eax, 61~	syscall~	mov rdi, offset t~	mov eax, 87~	syscall~	mov rcx, offset n~	movb [rcx+7], 0x0~	mov [rsp], rcx~	mov qword ptr [rsp+8], 0x0~	mov rdi, offset n~	lea rsi, [rsp]~	mov edx, 0x0~	mov eax, 59~	syscall~	add rsp, 0x40~.endm~_start: VON;NEU;MANN~	xor rdi, rdi~xit:mov eax, 0x3c~	syscall~~.data~i: .byte 5~e: .byte 0x22,0x0a~o: .byte 0x2d,0x6f,0x0~t: .byte 0x61,0x2e,0x6f,0x75,0x74,0x0~n: .byte 0x53,0x75,0x6c,0x6c,0x79,0x5f,0x05,0x2e,0x73,0x0~as: .byte 0x2f,0x75,0x73,0x72,0x2f,0x62,0x69,0x6e,0x2f,0x61,0x73,0x0~ld: .byte 0x2f,0x75,0x73,0x72,0x2f,0x62,0x69,0x6e,0x2f,0x6c,0x64,0x0~src: .ascii "
