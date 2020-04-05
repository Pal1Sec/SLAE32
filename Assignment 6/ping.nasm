; Filename: ping-polymorphic.nasm
; Author: SLAE-14209
  
global _start           
section .text
_start:
  
    push 0xb
    pop eax
    cld
    push edx
   
    push 0x0a0a312e        ; push '.1  '
    push 0x302e302e        ; push '.0.0'
    push 0x37323120        ; push ' 127'     
    push 0x676e6970        ; push 'ping'
    
    mov esi, esp
    push edx
    ;push word 0x632d      ; "c-"
    add dx, 0x521d
    add dx, 0x1110
    push dx
    xor edx, edx
   
    mov ecx, esp
    push edx
    ;push 0x68732f2f       ; "hs//"
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
