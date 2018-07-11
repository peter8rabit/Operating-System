#!/bin/sh

nasm -f bin boot1c.asm
nasm -f elf -o boot2c.o boot2c.asm

./cc.sh fdc
./cc.sh fat12
./linker -T link.ld -o boot.obj boot2c.o fat12.o fdc.o

dd if=/dev/zero of=fdd.img count=2880
cat boot1c boot.obj | dd of=fdd.img conv=notrunc

