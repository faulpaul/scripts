#!/usr/bin/python
import binascii
import sys

shellcode = sys.argv[1]

##remove the \x
shellcode = shellcode.replace('\\','')
shellcode = shellcode.replace('x','')
##remove any newline, spaces
shellcode = shellcode.replace('\n','')
shellcode = shellcode.replace(' ','')
##remove ;
shellcode = shellcode.replace(';','')
##undo the LitleEndian coding
i = 0
output = ''
while i < len(shellcode):
   output = output + shellcode[i+3] + shellcode[i+2] + shellcode[i+1] + shellcode[i]
   i = i + 4

print output 

ascii = binascii.a2b_hex(output)

#print 'ascii is:'
print ascii[::-1]
