.intel_syntax noprefix
.globl _start
.bss
r: .skip 0x10
n: .skip 0x20
.text
.macro ITOA
	lea rdi, [r]
	xor ecx, ecx
	mov eax, [i]
	mov ebx, 0xa
mo:	xor edx, edx
	idiv ebx
	add dl, 0x30
	mov [rdi+rcx], dl
	inc rcx
	test eax, eax
	jnz mo
	mov byte ptr [rdi+rcx], 0
	lea rsi, [r]
	lea rdi, [r+ecx-1]
rv:	cmp rsi, rdi
	jge rd
	mov al, [rsi]
	mov bl, [rdi]
	mov [rsi], bl
	mov [rdi], al
	inc rsi
	dec rdi
	jmp rv
rd:
.endm
.macro WHOAMI
	ITOA
	lea rdi, [n]
	lea rsi, [m]
	xor ecx, ecx
co:	mov al, [rsi+rcx]
	test al, al
	jz cd
	mov [rdi+rcx], al
	inc rcx
	jmp co
cd:	lea rdi, [n+rcx]
	lea rsi, [r]
	xor ecx, ecx
cr:	mov al, [rsi+rcx]
	test al, al
	jz ce
	mov [rdi+rcx], al
	inc rcx
	jmp cr
ce:	mov byte ptr [rdi+rcx], 0x2e
	mov byte ptr [rdi+rcx+1], 0x73
	mov byte ptr [rdi+rcx+2], 0
.endm
.macro VON
	sub rsp, 0x4200
	mov eax, [i]
	shl eax, 1
	jbe xit
.ifndef INIT
	mov eax, [i]
	dec eax
	mov [i], eax
.endif
	mov rsi, offset src
	mov r8d, i - src
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
	WHOAMI
	mov rdi, offset n
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
	mov edx, 0xa
	mov eax, 0x1
	syscall
	mov rsi, offset r
	xor eax, eax
	xor edx, edx
ln:	mov al, [rsi+rdx]
	inc edx
	test al, al
	jnz ln
	dec edx
	mov eax, 0x1
	syscall
	mov rsi, offset l
	mov edx, 0x1
	mov eax, 0x1
	syscall
	mov eax, 0x3
	syscall
.endm
.macro MANN
	mov eax, [i]
	test eax, eax
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
	xor ebx, ebx
nu:	mov al, [rcx+rbx]
	inc ebx
	test al, al
	jnz nu
	sub ebx, 3
	mov byte ptr [rcx+rbx], 0x0
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
l: .byte 0xa
o: .byte 0x2d,0x6f,0x0
s: .byte 0x2e,0x73,0x0
t: .byte 0x61,0x2e,0x6f,0x75,0x74,0x0
m: .byte 0x53,0x75,0x6c,0x6c,0x79,0x5f,0x0
e: .byte 0x22,0x0a,0x69,0x3a,0x20,0x2e,0x69,0x6e,0x74,0x20
as: .byte 0x2f,0x75,0x73,0x72,0x2f,0x62,0x69,0x6e,0x2f,0x61,0x73,0x0
ld: .byte 0x2f,0x75,0x73,0x72,0x2f,0x62,0x69,0x6e,0x2f,0x6c,0x64,0x0
src: .ascii ".intel_syntax noprefix~.globl _start~.bss~r: .skip 0x10~n: .skip 0x20~.text~.macro ITOA~	lea rdi, [r]~	xor ecx, ecx~	mov eax, [i]~	mov ebx, 0xa~mo:	xor edx, edx~	idiv ebx~	add dl, 0x30~	mov [rdi+rcx], dl~	inc rcx~	test eax, eax~	jnz mo~	mov byte ptr [rdi+rcx], 0~	lea rsi, [r]~	lea rdi, [r+ecx-1]~rv:	cmp rsi, rdi~	jge rd~	mov al, [rsi]~	mov bl, [rdi]~	mov [rsi], bl~	mov [rdi], al~	inc rsi~	dec rdi~	jmp rv~rd:~.endm~.macro WHOAMI~	ITOA~	lea rdi, [n]~	lea rsi, [m]~	xor ecx, ecx~co:	mov al, [rsi+rcx]~	test al, al~	jz cd~	mov [rdi+rcx], al~	inc rcx~	jmp co~cd:	lea rdi, [n+rcx]~	lea rsi, [r]~	xor ecx, ecx~cr:	mov al, [rsi+rcx]~	test al, al~	jz ce~	mov [rdi+rcx], al~	inc rcx~	jmp cr~ce:	mov byte ptr [rdi+rcx], 0x2e~	mov byte ptr [rdi+rcx+1], 0x73~	mov byte ptr [rdi+rcx+2], 0~.endm~.macro VON~	sub rsp, 0x4200~	mov eax, [i]~	shl eax, 1~	jbe xit~.ifndef INIT~	mov eax, [i]~	dec eax~	mov [i], eax~.endif~	mov rsi, offset src~	mov r8d, i - src~	mov ecx, r8d~jo:	movb al, [rsi+rcx]~	cmp al, 0x7e~	jne hn~	sub al, 0x74~hn:	movb [rsp+rcx], al~	dec cx~	jns jo~.endm~.macro NEU~	WHOAMI~	mov rdi, offset n~	mov esi, 01101~	mov edx, 0644~	mov eax, 0x2~	syscall~	mov edi, eax~	test eax, eax~	js xit~	lea rsi, [rsp]~	mov edx, r8d~	mov eax, 0x1~	syscall~	add rsp, 0x400~	mov rsi, offset e~	mov edx, 0x1~	mov eax, 0x1~	syscall~	mov rsi, offset src~	mov edx, r8d~	mov eax, 0x1~	syscall~	mov rsi, offset e~	mov edx, 0xa~	mov eax, 0x1~	syscall~	mov rsi, offset r~	xor eax, eax~	xor edx, edx~ln:	mov al, [rsi+rdx]~	inc edx~	test al, al~	jnz ln~	dec edx~	mov eax, 0x1~	syscall~	mov rsi, offset l~	mov edx, 0x1~	mov eax, 0x1~	syscall~	mov eax, 0x3~	syscall~.endm~.macro MANN~	mov eax, [i]~	test eax, eax~	jz xit~	sub rsp, 0x40~	mov eax, 58~	syscall~	test eax, eax~	jnz lin~	mov rcx, offset as~	mov [rsp], rcx~	mov rcx, offset n~	mov [rsp+8], rcx~	mov qword ptr [rsp+16], 0x0~	mov rdi, offset as~	lea rsi, [rsp]~	mov edx, 0x0~	mov eax, 59~	syscall~	jmp xit~lin:mov edi, eax~	mov rsi, rsp~	mov edx, 0x0~	mov r10, 0x0~	mov eax, 61~	syscall~	mov eax, 58~	syscall~	test eax, eax~	jnz run~	mov rcx, offset ld~	mov [rsp], rcx~	mov rcx, offset t~	mov [rsp+8], rcx~	mov rcx, offset o~	mov [rsp+16], rcx~	mov rcx, offset n~	xor ebx, ebx~nu:	mov al, [rcx+rbx]~	inc ebx~	test al, al~	jnz nu~	sub ebx, 3~	mov byte ptr [rcx+rbx], 0x0~	mov [rsp+24], rcx~	mov qword ptr [rsp+32], 0x0~	mov rdi, offset ld~	lea rsi, [rsp]~	mov edx, 0x0~	mov eax, 59~	syscall~	jmp xit~run:mov edi, eax~	mov rsi, rsp~	mov edx, 0x0~	mov r10, 0x0~	mov eax, 61~	syscall~	mov rdi, offset t~	mov eax, 87~	syscall~	mov rcx, offset n~	mov [rsp], rcx~	mov qword ptr [rsp+8], 0x0~	mov rdi, offset n~	lea rsi, [rsp]~	mov edx, 0x0~	mov eax, 59~	syscall~	add rsp, 0x40~.endm~_start: VON;NEU;MANN~	xor rdi, rdi~xit:mov eax, 0x3c~	syscall~.data~l: .byte 0xa~o: .byte 0x2d,0x6f,0x0~s: .byte 0x2e,0x73,0x0~t: .byte 0x61,0x2e,0x6f,0x75,0x74,0x0~m: .byte 0x53,0x75,0x6c,0x6c,0x79,0x5f,0x0~e: .byte 0x22,0x0a,0x69,0x3a,0x20,0x2e,0x69,0x6e,0x74,0x20~as: .byte 0x2f,0x75,0x73,0x72,0x2f,0x62,0x69,0x6e,0x2f,0x61,0x73,0x0~ld: .byte 0x2f,0x75,0x73,0x72,0x2f,0x62,0x69,0x6e,0x2f,0x6c,0x64,0x0~src: .ascii "
i: .int 5
