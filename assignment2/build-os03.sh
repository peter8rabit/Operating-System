#!/bin/sh

nasm -f bin boot1b.asm

gcc -arch i386 -static -m32 -S keyboard.c

echo '.org 0x8200\n' > foo.s
cat keyboard.s >> foo.s
mv foo.s keyboard.s

as -arch i386 -m32 -static -o keyboard.o keyboard.s
gobjcopy -O binary keyboard.o keyboard

dd if=keyboard of=foo ibs=0x8200 skip=1
mv foo keyboard
rm foo

dd if=/dev/zero of=fdd.img count=2880
cat boot1b keyboard > boot
dd if=boot of=fdd.img conv=notrunc
