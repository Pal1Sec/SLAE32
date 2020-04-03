; Filename: exec.nasm
; Author: SLAE-14209

global _start

section .text

_start:

    push byte 0xb             ; syscall execve()
    pop eax                   ; EAX = syscall 11
    cwd                       ; EDX = 0
    push edx
    push word 0x632d          ; "-c"
    mov edi, esp              ; ESP -> EDI
    push dword 0x68732f       ; "/sh"
    push dword 0x6e69622f     ; "/bin"
    mov ebx, esp              ; ESP -> EBX
    push edx                  ; EDX = 0
    call 0x1                  ; storing the command into the stack
    push edi
    push ebx
    mov ecx, esp              ; ECX (/bin/bash -c whoami) -> stack
    int 0x80
