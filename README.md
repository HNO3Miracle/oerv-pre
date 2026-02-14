# RISC-V LFS Delivery

RISC-V + QEMU Linux From Scratch 交付仓库。

## 包含文件
- `report.md`: 详细构建报告。
- `Image`: 编译好的 Linux 内核 (v6.6)。
- `fw_dynamic.bin`: 编译好的 OpenSBI 固件 (v1.8)。
- `run-qemu.sh`: 启动脚本。

## 运行说明
1. 确保当前目录下有 `rootfs.ext4`。
2. 执行 `./run-qemu.sh`。
