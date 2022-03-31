#!/bin/bash

set -e
set -u

# Transplant the code.
if [ -e source ]
then
    (cd source && git pull)
else
    git clone https://github.com/LTLA/kanaval source
fi

rm -rf kanaval
cp -r source/include/kanaval kanaval
