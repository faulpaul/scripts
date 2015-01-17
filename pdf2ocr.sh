#!/bin/bash

#
# Script to convert pdf files via ocr to text files
# you need ImageMagick and tesseract
# expect wrong results!!!
#

#error function
function errormessage {
    echo "usage:"
    echo "pdf2ocr.sh input.pdf output.txt"
    echo "example:"
    echo "pdf2ocr.sh info.pdf info.txt"
    exit 1
}

#check for parameters
if [ $# -gt 2 -o $# -lt 2 ]; then
    errormessage
fi

input=$1
output=$2
tif=temp.tif

echo "1/6 convert pdf to tif"
/usr/bin/convert $input temp.tif

echo "2/6 change to grayscale"
/usr/bin/convert -type Grayscale temp.tif temp2.tif

echo "3/6 adjust Threshold(black) to 70%"
/usr/bin/convert -black-threshold 70% temp2.tif temp3.tif

echo "4/6 convert to black"
/usr/bin/convert -monochrome temp3.tif temp4.tif

echo "5/6 ocr"
/usr/bin/tesseract temp4.tif $output

echo "6/6 cleanup"
rm -rf temp.tif temp2.tif temp3.tif temp4.tif

echo "done"
