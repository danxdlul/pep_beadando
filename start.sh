#!/bin/sh
rm times.txt

./bin/primtenyezok 1 100000 
./bin/primtenyezok 1 1000000
./bin/primtenyezok 1 10000000

./bin/primtenyezok 2 100000
./bin/primtenyezok 2 1000000
./bin/primtenyezok 2 10000000

./bin/primtenyezok 4 100000 
./bin/primtenyezok 4 1000000 
./bin/primtenyezok 4 10000000

Rscript figure.R

xdg-open eredmeny.eps

