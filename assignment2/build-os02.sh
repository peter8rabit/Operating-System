#!/bin/sh

nasm -f bin boot1.asm

gcc -arch i386 -static -m32 -S boot2.c

echo '.org 0x8200\n' > foo.s
cat boot2.s >> foo.s
mv foo.s boot2.s

as -arch i386 -m32 -static -o boot2.o boot2.s
gobjcopy -O binary boot2.o boot2

dd if=boot2 of=foo ibs=0x8200 skip=1
mv foo boot2
rm foo

dd if=/dev/zero of=fdd.img count=2880
cat boot1 boot2 > boot
dd if=boot of=fdd.img conv=notrunc
