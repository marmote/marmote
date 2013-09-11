#!/bin/bash

if [ $# != 1 ]; then
    echo "Usage: $0 <output file name>"
    exit 1
fi

function meas {
    echo Saving packet payloads to file $1
    echo Waiting for packets...
    uhd_rx_cfile -a addr=192.168.10.2 -f 2.405G --samp-rate=10M -g 15 -N 50M $1
    cp $1 mm_tmp.dat

}

if [ -f "$1.dat" ]; then
    echo "File '$1.dat' already exists."
    read -n1 -p "Are you sure you want to overwrite it? [y/N] " answer
    echo
    case $answer in
        y|Y) meas $1.dat ;;
        n|N) exit ;;
        *) exit ;;
    esac
else
    touch $1.dat
    meas $1.dat
fi
