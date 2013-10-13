#!/bin/bash
 
for f in *.css; do
    echo $f ${f/.css/.scss};
    sass-convert -F css -T scss $f ${f%%.*}.scss;
done
