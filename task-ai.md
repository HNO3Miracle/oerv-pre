# RISC-V + QEMU Linux From Scratch (LFS) 修订版计划

## 目标
构建一个基于 RISC-V 架构的最小化 Linux 系统，采用 "OpenSBI + Kernel + BusyBox" 架构，并使用 ext4 磁盘镜像挂载。

## 阶段一：环境与交叉编译器 (已在进行)
1. 确认宿主机依赖。
2. 安装/验证 `riscv64-linux-gnu-gcc`。

## 阶段二：OpenSBI 编译
1. 获取 OpenSBI 源码。
2. 针对 QEMU `virt` 平台编译固件。

## 阶段三：Linux 内核编译
1. 获取内核源码 (推荐 LTS 版本)。
2. 配置 `defconfig` 并手动开启：
   - `CONFIG_VIRTIO_BLK`, `CONFIG_VIRTIO_NET`, `CONFIG_VIRTIO_PCI`
   - `CONFIG_HVC_RISCV_SBI`
   - `CONFIG_EXT4_FS`

## 阶段四：BusyBox 与 Rootfs
1. 静态编译 BusyBox。
2. 构建标准目录结构。
3. **关键配置**：编写 `/etc/inittab` 和初始启动脚本。
4. **镜像制作**：使用 `dd` 创建 100M 左右的镜像文件，格式化为 ext4。

## 阶段五：集成启动与验证
1. 编写 QEMU 启动指令，挂载 ext4 镜像作为 `/dev/vda`。
2. 验证系统启动至 Shell。

## 阶段六：报告编写
1. 记录关键决策（如为何跳过 U-Boot）。
2. 整理启动日志和镜像。
