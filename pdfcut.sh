#!/bin/bash

#to make for loops split with non whitespace characters
IFS=$'\n'

for i in $(ls); do
    #create folder with the pdf name
    mkdir `basename $i .pdf`
    echo $i
    #get page count
    pdftk $i dump_data | grep NumberOfPages | cut -d: -f 2
    echo $pagenumber
    #spliting pdf
    pagelist=''
    #for j in $(seq $pagenumber); do
        #$pagelist=$pagelist' '$j'.pdf'
    #done
    echo $pagelist
    #pdftk '$i' cat 
    echo "spliting $i done"
done
