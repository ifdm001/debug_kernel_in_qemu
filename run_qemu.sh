sudo qemu-system-x86_64 -enable-kvm -s -kernel \
/mnt/build/linux/arch/x86/boot/bzImage -hda sid.ext3 -append "root=/dev/sda \
console=ttyS0" -nographic -net nic,macaddr=02:00:00:00:00:00 -net \
tap,script=ovs-up.sh,downscript=ovs-down.sh
