#!/bin/bash

./configure --prefix=${PREFIX} --build=$BUILD --host=$HOST
make
if [[ $(uname) == Linux ]]; then
    make check
fi
make install
