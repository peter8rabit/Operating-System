#!/bin/sh

nasm -f bin boot1d.asm
nasm -f elf -o boot2d.o boot2d.asm

./gas -o csw.o csw.s
./cc.sh thread
./linker -T link-os.ld -o boot.obj boot2d.o thread.o csw.o

dd if=/dev/zero of=fdd.img count=2880
cat boot1d boot.obj | dd of=fdd.img conv=notrunc
