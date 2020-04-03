; Filename: exec.nasm
; Author: SLAE-14209

global _start

section .text

_start:

    jmp short 0x38       
    mov eax, 0x5         ; syscall open()
    pop ebx              ; pop address "txt.eals/pmt/" into EBX
    xor ecx, ecx         ; zeroize ECX register
    int 0x80             ; int open(const char *pathname, int flags);
    
    mov ebx, eax
    mov eax, 0x3         ; syscall read()
    mov edi, esp         ; ESP -> EDI
    mov ecx, edi         ; ESP -> ECX
    mov edx, 0x1000      ; 0x1000 = 4096
    int 0x80             ; int read(int fd, void *buf, size_t count);
    
    mov edx, eax
    mov eax, 0x4         ; syscall write()
    mov ebx, 0x1         ; STDOUT = 1
    int 0x80             ; int write(int fd, const void *buf, size_t count);
    
    mov eax, 0x1         ; syscall exit()
    mov ebx, 0x0         ; exit
    int 0x80
    
    call 0x2
    das                  ;---|
    jz 0xad              ;   |
    jo 0x71              ;   |
    jnc 0xb0             ;   |--> "txt.eals/pmt/"
    popa                 ;   |
    cs jz 0xc1           ;   |
    jz 0x4b              ;---|
