#!/bin/bash

# Bash script for MarmotE phase measurements

if [ $# != 3 ]; then
    echo "Usage: $0 <rx> <tx1> <tx2>"
    echo
    echo "  rx   : [1 | 2]"
    echo "  tx1  : [1..10] MarmotE node id"
    echo "  tx2  : [1..10] MarmotE node id"
    echo
    exit 1
fi

SEQ=0
while [ -d $(printf "r%1d_t%1d_t%1d_%03d" $1 $2 $3 $SEQ) ];
do
    let SEQ=SEQ+1
done

DIRNAME=$(printf "r%1d_t%1d_t%1d_%03d" $1 $2 $3 $SEQ)
mkdir $DIRNAME

for f in {2400..2500..10}
do
    FILENAME=$(printf "r%1d_t%1d_t%1d_f%s.dat" $1 $2 $3 $f)
    echo
    echo Recording to file $DIRNAME/$FILENAME...
    echo

    uhd_rx_cfile -f "$f"M --samp-rate=25M -g 30 -N 50M $DIRNAME/$FILENAME

    if [ $? -ne 0 ]; then
        echo Failure
        exit
    else
        echo
        echo Saved to file $DIRNAME/$FILENAME
    fi
done

#baudline -quadrature -channels 2 -format le32f -samplerate 25000000 -scale 32767 -basefrequency 2400000000
~/bin/baudline -quadrature -channels 2 -format le32f -samplerate 25000000 -scale 32767

exit
