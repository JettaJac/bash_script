#!/bin/bash

if [[ $# != 0 ]]; then
    echo "Illegal number of parameters"
else
    # goaccess ../04/*.log --log-format=COMBINED -o report.html
    goaccess ../04/*.log -o report.html --log-format=COMBINED --ws-url=goaccess.io
fi

# tail -f report.html > /tmp/wspipein.fifo
# open report.html