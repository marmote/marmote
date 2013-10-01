#!/bin/bash

# Bash script for Marmote phase measurements

if [ $# != 1 ]; then
    echo "Usage: $0 <freq in MHz>"
    exit 1
fi

SEQ=0
while [ -f $(printf "f%s_%03d" $1 $SEQ) ];
do
    echo SEQ is $SEQ
    let SEQ=SEQ+1
done

FILENAME=$(printf "f%s_%03d.dat" $1 $SEQ)
echo Recording to file $FILENAME...

#uhd_rx_cfile -a addr=192.168.10.2 -f "$1"M --samp-rate=25M -g 20 -N 55M $FILENAME
uhd_rx_cfile -f "$1"M --samp-rate=25M -g 20 -N 55M $FILENAME

if [ $? -ne 0 ]; then
    echo Failure
    exit
else
    cp $FILENAME mm_tmp.dat
    echo Done
fi

