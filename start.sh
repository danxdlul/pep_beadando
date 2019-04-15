#!/bin/sh
rm times.txt

numbers1=131072     #2^17
numbers2=1048576    #2^20
numbers3=8388608    #2^23

./bin/primtenyezok 1 $numbers1     
./bin/primtenyezok 1 $numbers2    
./bin/primtenyezok 1 $numbers3    

./bin/primtenyezok 2 $numbers1
./bin/primtenyezok 2 $numbers2
./bin/primtenyezok 2 $numbers3

./bin/primtenyezok 4 $numbers1 
./bin/primtenyezok 4 $numbers2 
./bin/primtenyezok 4 $numbers3


#./bin/primtenyezok 1 100000 
#./bin/primtenyezok 1 1000000
#./bin/primtenyezok 1 10000000

#./bin/primtenyezok 2 100000
#./bin/primtenyezok 2 1000000
#./bin/primtenyezok 2 10000000

#./bin/primtenyezok 4 100000 
#./bin/primtenyezok 4 1000000 
#./bin/primtenyezok 4 10000000


Rscript figure.R

xdg-open eredmeny.ps

