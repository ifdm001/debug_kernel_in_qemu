#!/bin/sh
rm sid.ext3
BLOCKS=$(((1024*$(du -m -s sid | awk '{print $1}')*12)/10))
echo $BLOCKS
genext2fs -z -d sid -b $BLOCKS -i 1024 sid.ext3
resize2fs sid.ext3 1G
tune2fs -j -c 0 -i 0 sid.ext3
