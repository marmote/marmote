#!/bin/bash

if [ $# = 0 ]; then
    echo "Usage: $0 <list of nodes to program>"
    exit 1
fi

echo "Programming nodes $@..."

for i in $@; do
    echo Executing "make telosb install,$i bsl,/dev/ttyUSB$i"
    make telosb install,$i bsl,/dev/ttyUSB$i &
done
echo "Done"

exit 0