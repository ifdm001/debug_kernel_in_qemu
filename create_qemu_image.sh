#!/bin/sh

sudo debootstrap sid sid
echo -e "rootnroot" | chroot sid passwd
echo -e "auto loniface lo inet loopbacknauto eth0niface eth0 inet dhcp" >
sid/etc/network/interfaces
ln -sf vimrc sid/etc/vimrc.tiny
rm -f sid/etc/udev/rules.d/70-persistent-net.rules
echo devkernel > sid/etc/hostname
BLOCKS=$(((1024*$(du -m -s sid | awk '{print $1}')*12)/10))
genext2fs -z -d sid -b $BLOCKS -i 1024 sid.ext3
resize2fs sid.ext3 1G
tune2fs -j -c 0 -i 0 sid.ext3
qemu-system-x86_64 -no-kvm -s -S  -kernel
/mnt/build/linux-2.6/arch/x86/boot/bzImage -hda /mnt/sid.ext3 -append
"root=/dev/sda"
