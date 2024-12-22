section .bss
	buffer resb 128 ; reserve 128 bytes (resb) for variable buffer

section .data
	msg db 'Your message: '
	len equ $ - msg

section .text
	global _start

_start
	mov rax, 0 ; syscall 0 (read)
	mov rdi, 0 ; stdin (file descriptor)
	mov rsi, buffer ; pointer to buffer
	mov rdx, 128 ; read 128 bytes from buffer
	syscall

	; Write "your message"
	mov rax, 1 ; syscall 1 (write)
	mov rdi, 1 ; stdout
	mov rsi, msg ; pointer to the msg variable
	mov rdx, len ; pointer to the len variable
	syscall

	; Write input message
	mov rax, 1
	mov rdi, 1
	mov rsi, buffer
	mov rdx, 128
	syscall

	mov rax, 60 ; syscall 60 (exit)
	xor rdi, rdi ; compare every bit, if they are the same, return 0 (XOR - exclusive OR)
	syscall
	
