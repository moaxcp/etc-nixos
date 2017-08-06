#!/usr/bin/env bash
echo "script started"
PIPE=/tmp/obnam-log.pipe
if [ -p $PIPE ]; then
    echo "removing ${PIPE}"
    rm -f $PIPE
else 
    echo "${PIPE} not found"
fi 
echo "opening pipe"
mkfifo -m 600 $PIPE
echo "starting cat"
cat < $PIPE &
echo "starting obnam"
obnam --log $PIPE backup > $PIPE 2>&1
echo "removing pipe"
rm -f $PIPE

