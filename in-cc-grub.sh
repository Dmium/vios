mkdir -p /wd/isodir/boot/grub
cp /wd/out/vios.bin /wd/isodir/boot/vios.bin
cp /wd/src/grub.cfg /wd/isodir/boot/grub/grub.cfg
grub-mkrescue -o /wd/isodir/vios.iso /wd/isodir
rm -rf /wd/isodir/boot
echo done
