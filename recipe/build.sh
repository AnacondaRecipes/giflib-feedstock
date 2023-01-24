#!/bin/bash

cp $RECIPE_DIR/CMakeLists.txt .
mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=$PREFIX -DCMAKE_BUILD_TYPE=Release ..
make -j$CPU_COUNT
if [[ "$target_platform" == linux* ]]; then
  make -C ../tests UTILS=$PWD
fi
make install
# Remove the executable gif2rgb and its associated man page.
# This executable has a CVE (CVE-2022-28506) that doesn't have a fix yet.
rm $PREFIX/bin/gif2rgb
rm $PREFIX/share/man/man1/gif2rgb.1
