#!/bin/bash

# 获取当前脚本所在目录的绝对路径
BASE_DIR=$(cd "$(dirname "$0")"; pwd)

QEMU=qemu-system-riscv64
KERNEL=$BASE_DIR/linux/arch/riscv/boot/Image
SBI=$BASE_DIR/opensbi/build/platform/generic/firmware/fw_dynamic.bin
ROOTFS=$BASE_DIR/rootfs.ext4

echo "Starting RISC-V LFS with:"
echo "  Kernel: $KERNEL"
echo "  BIOS:   $SBI"
echo "  Rootfs: $ROOTFS"

$QEMU -nographic -machine virt \
    -bios $SBI \
    -kernel $KERNEL \
    -drive file=$ROOTFS,format=raw,id=hd0 \
    -device virtio-blk-device,drive=hd0 \
    -append "root=/dev/vda rw console=ttyS0 earlycon=sbi"
