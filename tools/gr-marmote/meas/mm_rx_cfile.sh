#!/bin/bash

# Bash script for MarmotE phase measurements

if [ $# != 4 ]; then
    echo "Usage: $0 <rx> <tx1> <tx2> <freq>"
    echo
    echo "  rx   : [1 | 2]"
    echo "  tx1  : [1..10] MarmotE node id (even subcarriers)"
    echo "  tx2  : [1..10] MarmotE node id (odd subcarriers)"
    echo "  freq : [2400..2500] MHz"
    echo
    exit 1
fi

SEQ=0
#while [ -f $(printf "f%s_%03d.dat" $4 $SEQ) ];
while [ -f $(printf "r%1d_t%1d_t%1d_f%s_%03d.dat" $1 $2 $3 $4 $SEQ) ];
do
    let SEQ=SEQ+1
done

#FILENAME=$(printf "f%s_%03d.dat" $4 $SEQ)
FILENAME=$(printf "r%1d_t%1d_t%1d_f%s_%03d.dat" $1 $2 $3 $4 $SEQ)
echo
echo Recording to file $FILENAME...
echo

uhd_rx_cfile -f "$4"M --samp-rate=25M -g 30 -N 50M $FILENAME

if [ $? -ne 0 ]; then
    echo Failure
    exit
else
    cp $FILENAME tmp.dat
    echo
    echo Saved to file $FILENAME

    gr_plot_fft_c -R 25000000 -s  5000000 $FILENAME && \
    gr_plot_fft_c -R 25000000 -s 17500000 $FILENAME
fi

