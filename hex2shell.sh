#!/bin/bash

# uses hexdump to transform a binary into a shellcode

binary=$1
outputfile=$2

# dump to hex | cut columns | double spaces     | trailing spaces | empty lines | add \x           | add trailing "| add "\x in front
function hex2dump {
hexdump -C $1 | cut -c11-58 | sed 's/\ \ /\ /g' | sed 's/\s*$//g' | sed '/^$/d' | sed 's/\s/\\x/g' | sed 's/$/"/g' | sed 's/^/"\\x/g'
}

if [ $2 ]; then
    hex2dump $1 > $2
    echo 'shellcode has been safed into: '$2
    echo '------------------------------------------------------'
    cat $2
else
    hex2dump $1
fi
