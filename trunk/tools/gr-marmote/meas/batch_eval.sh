#!/bin/bash

OUTFILE="result.txt"

if [ $# != 2 ]; then
    echo "Usage: $0 <path to eval script> <spread factor>"
    exit 1
fi

alpha_range=(0.500)
threshold_range=(0.03125 0.0625 0.125)

function eval_meas {

    # print header
    echo -n "d" | tee -a $OUTFILE;
    for t in ${threshold_range[*]}
    do
        for a in ${alpha_range[*]}
        do
            echo -n " |t=${t}_a=${a}|" | tee -a $OUTFILE
        done
    done
    echo | tee -a $OUTFILE

    # evaluate
    for f in `ls *.dat | sort -n `
    do
        echo -n "${f%%.*}" | tee -a $OUTFILE;
        for t in ${threshold_range[*]}
        do
            for a in ${alpha_range[*]}
            do
                #echo -n " |d=${f%%.*} t=$t a=$a|"
                #echo -n " |t=$t a=$a|"
                PRR=`$1 -s $2 -t $t -a $a -f $f | grep -v Volk`
                #echo -n "PRR: $PRR"
                if [ -z $PRR ]; then
                    echo -n " -" | tee -a $OUTFILE
                else
                    echo -n " $PRR" | tee -a $OUTFILE
                fi
            done
        done
        echo | tee -a $OUTFILE
    done
}

if [ -f $OUTFILE ]; then
    echo "File '$OUTFILE' already exists."
    read -n1 -p "Are you sure you want to overwrite it? [y/N] " answer
    echo
    case $answer in
        y|Y) rm $OUTFILE; eval_meas $1 $2 ;;
        n|N) exit ;;
        *) exit ;;
    esac
else
    touch $OUTFILE
    eval_meas $1 $2
fi
