rm -rf out
mkdir out
./in-cc.sh nasm -felf32 /wd/src/boot.asm -o /wd/out/boot.o 
./in-cc.sh i686-elf-gcc -c /wd/src/kernel.c -o /wd/out/kernel.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra
./in-cc.sh i686-elf-gcc -T /wd/src/linker.ld -o /wd/out/vios.bin -ffreestanding -O2 -nostdlib /wd/out/boot.o /wd/out/kernel.o -lgcc
./in-cc.sh grub-file --is-x86-multiboot /wd/out/vios.bin && echo "Valid multiboot"
./in-cc.sh /bin/bash -C /wd/in-cc-grub.sh
