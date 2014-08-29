#!/bin/bash

for i in "$@"
do
    case $i in
        --prefix=*)
            PREFIX="${i#*=}"
            shift
        ;;
        --jobs=*)
            JOBS="${i#*=}"
            shift
        ;;
        *)
            shift
        ;;
    esac
done

wget http://www.haskell.org/ghc/dist/7.8.3/ghc-7.8.3-src.tar.xz
tar xf ghc-7.8.3-src.tar.xz

cd ghc-7.8.3

patch -p1 < ../D69_simplified.diff

cp mk/build.mk.sample mk/build.mk
sed -i '21s;#;;' mk/build.mk

./configure --prefix="$PREFIX"
make -j"$JOBS"
