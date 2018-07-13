#!/bin/sh
gcc -arch i386 -static -fno-stack-protector -S $1.c
cat $1.s | sed -e 's/\.subsections_via_symbols/#.subsections_via_symbols/g' | sed -e 's/.macosx_version/#.macosx_version/g' | sed -e 's/\.section.*__text.*$/.text/g' | sed -e 's/\.section.*__data.*$/.data/g' | sed -e 's/\.zerofill[^,]*,[^,]*,\([^,]*\),\([^,]*\).*/	.align \2\
\	\.type\	\1, @object\
\	.size\	\1, \2\
\1:\
\	.zero\	\2/g' > $1.as
./gas -o $1.o $1.as
rm $1.s $1.as
