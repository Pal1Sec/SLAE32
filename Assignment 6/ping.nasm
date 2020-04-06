; Filename: ping-polymorphic.nasm
; Author: SLAE-14209
  
global _start           
section .text
_start:
  
    push 0xb
    pop eax
    cdq
    push edx
   
    push 0x74736f68         ; 
    push 0x6c61636f         ; 
    push 0x6c20676e         ; => "//bin/////ping localhost "
    push 0x69702f2f         ; 
    push 0x2f2f2f6e         ; 
    push 0x69622f2f         ;
    
    mov esi, esp
    push edx
    ;push word 0x632d       ; "c-"
    add dx, 0x521d
    add dx, 0x1110
    push dx
    xor edx, edx
   
    mov ecx, esp
    push edx
    ;push 0x68732f2f        ; "hs//"
    mov ebx, 0x68732f2e
    inc ebx
    push ebx
    
    ;push 0x6e69622f       ; "nib/"
    mov ebx, 0x6e696230
    dec ebx
    push ebx
    
    mov ebx, esp
    push edx
    push esi
    push ecx    
    push ebx
    mov ecx, esp
    int 0x80
