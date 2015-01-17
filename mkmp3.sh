#!/bin/bash

#clive & mplayer to download an youtube video and convert it to an mp3
#usage: mkmp3.sh $youtubeurl $artist $title

if [ $# -gt 3 -o $# -lt 1 ]; then
    echo 1
    exit 1
fi

artist=$1
title=$2
youtubeurl=$3

#get video && convert && clean up

clive -G=bar -N temp.flv  $youtubeurl && mplayer -quiet -dumpaudio -dumpfile /home/pgossing/Media/Music/neu/$artist' - '$title.mp3 temp.flv && rm -rf temp.flv

#http://www.youtube.com/watch?v=ySUapnLe1-M
