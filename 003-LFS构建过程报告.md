# RISC-V + QEMU Linux From Scratch (LFS) 过程性报告

## 1. 任务概述
本任务目标是在 RISC-V 架构下，基于 QEMU `virt` 平台，从零构建一个最小化的 Linux 系统。
系统架构：**OpenSBI (M-Mode) -> Linux Kernel (S-Mode) -> BusyBox (User-Mode)**。
存储方案：采用 ext4 格式的磁盘镜像。

## 2. 环境准备
- **宿主机**: Ubuntu 24.04.4 LTS (WSL)
- **工具链**: `riscv64-linux-gnu-gcc` (13.3.0)
- **模拟器**: `qemu-system-riscv64` (8.2.2)
- **依赖安装**: 安装了 `build-essential`, `flex`, `bison`, `libssl-dev`, `bc` 等必要构建工具。

## 3. 关键组件构建

### 3.1 OpenSBI (运行时固件)
- **版本**: v1.8
- **构建命令**: `make PLATFORM=generic CROSS_COMPILE=riscv64-linux-gnu-`
- **说明**: 针对 QEMU `virt` 平台，使用通用 (generic) 配置生成 `fw_dynamic.bin`。

### 3.2 Linux 内核
- **版本**: v6.6 LTS
- **架构**: riscv64
- **关键配置**:
  - `CONFIG_VIRTIO_BLK=y`, `CONFIG_VIRTIO_NET=y`, `CONFIG_VIRTIO_PCI=y` (虚拟化支持)
  - `CONFIG_HVC_RISCV_SBI=y` (SBI 控制台)
  - `CONFIG_EXT4_FS=y` (磁盘文件系统)
  - `CONFIG_9P_FS=y` (主机共享支持)
- **构建结果**: 生成 `arch/riscv/boot/Image`。

### 3.3 根文件系统 (Rootfs)
- **核心工具**: BusyBox v1.36 (静态编译)
- **构建方式**: `make ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- STATIC=y`
- **初始化配置**:
  - 编写 `/etc/inittab` 定义启动流程（PID 1）。
  - 编写 `/etc/init.d/rcS` 实现 `/proc` 和 `/sys` 的自动挂载及设备节点管理（mdev）。
- **镜像制作**: 
  - 使用 `dd` 创建 128MB 空镜像。
  - 使用 `mkfs.ext4` 格式化。
  - 挂载后同步文件系统内容。

## 4. 系统启动与测试
- **启动脚本**: `run-qemu.sh`
- **QEMU 参数**:
  - `-machine virt`: 指定 RISC-V 虚拟平台。
  - `-bios fw_dynamic.bin`: 加载 OpenSBI。
  - `-drive file=rootfs.ext4,format=raw,id=hd0 -device virtio-blk-device,drive=hd0`: 挂载虚拟硬盘。
  - `-append "root=/dev/vda rw console=ttyS0"`: 指定根设备和控制台。
- **验证结果**: 系统成功引导，完成文件系统挂载，并跳转至 `Please press Enter to activate this console.`，证明 BusyBox 的 init 进程已成功运行。

## 5. 交付物清单
- `opensbi/build/platform/generic/firmware/fw_dynamic.bin` (固件)
- `linux/arch/riscv/boot/Image` (内核)
- `rootfs.ext4` (根文件系统镜像)
- `run-qemu.sh` (一键启动脚本)
- `report.md` (本报告)
