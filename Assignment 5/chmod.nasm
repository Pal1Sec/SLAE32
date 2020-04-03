; Filename: chmod.nasm
; Author: SLAE-14209

global _start

section .text

_start:

    cdq                        ; convert double to quad
    push 0xf                   ; syscall chmod() = int chmod(const char *pathname, mode_t mode);
    pop eax
    push edx
    call 0x404058 <code+24>
    
    das                        ;---|
    je                         ;   |
    jo                         ;   |--> "txt.eals/pmt/"
    jae                        ;   |
    popa                       ;   |
    gs cs je 0x4040ce          ;---|
    
    pop ebx
    push dword 0x1ff           ; hex 0x1ff = 777 octal 
    pop ecx
    
    push byte 0x1              ; syscall exit()
    pop eax
    int 0x80
