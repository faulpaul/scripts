#!/bin/bash

mkdir spliced
for i in $(ls); do
    convert $i -crop 100%x50% +repage spliced/`basename $i .JPG`_%d.jpg
    mv spliced/`basename $i .JPG`_0.jpg spliced/`basename $i .JPG`_2.jpg
    echo "converting $i done"
done
