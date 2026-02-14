# RISC-V LFS Delivery

RISC-V + QEMU Linux From Scratch 交付仓库。

## 包含文件
- `report.md`: 详细构建报告。
- `Image`: 编译好的 Linux 内核 (v6.6)。
- `fw_dynamic.bin`: 编译好的 OpenSBI 固件 (v1.8)。
- `rootfs.ext4.gz`: 根文件系统镜像（压缩包）。
- `run-qemu.sh`: 启动脚本。

## 运行说明
1. **解压镜像**:
   ```bash
   gunzip -k rootfs.ext4.gz
   ```
2. **启动系统**:
   ```bash
   ./run-qemu.sh
   ```
3. **交互**:
   按下回车进入 Shell。退出请按 `Ctrl + A` 然后按 `X`。
