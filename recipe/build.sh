#!/usr/bin/env bash

set -o xtrace -o nounset -o pipefail -o errexit

mkdir -p "${PREFIX}/bin"

make -j${CPU_COUNT} -C CPP/7zip/Bundles/Alone7z/ -f makefile.gcc
make -j${CPU_COUNT} -C CPP/7zip/Bundles/Alone2/ -f makefile.gcc
make -j${CPU_COUNT} -C CPP/7zip/Bundles/Alone/ -f makefile.gcc
make -j${CPU_COUNT} -C CPP/7zip/UI/Console/ -f makefile.gcc

cp CPP/7zip/Bundles/Alone7z/_o/7zr "${PREFIX}/bin"
cp CPP/7zip/Bundles/Alone2/_o/7zz "${PREFIX}/bin"
cp CPP/7zip/Bundles/Alone/_o/7za "${PREFIX}/bin"
cp CPP/7zip/UI/Console/_o/7z "${PREFIX}/bin"
