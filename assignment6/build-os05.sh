#!/bin/sh

# boot disk
nasm -f bin boot1d.asm
nasm -f elf -o boot2d.o boot2d.asm

./cc.sh boot
./cc.sh fdc
./linker -T link-os.ld -o boot.obj boot2d.o boot.o fdc.o

dd if=/dev/zero of=fdd.img count=2880
cat boot1d boot.obj | dd of=fdd.img conv=notrunc

# pingpong.exe
./cc.sh pingpong
./linker -T link-main.ld -o pingpong.exe pingpong.o

