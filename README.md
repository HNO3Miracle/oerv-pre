# RISC-V + QEMU Linux From Scratch (LFS) 笔试任务

本项目记录了基于 RISC-V 架构，使用 QEMU 模拟器从零构建最小化 Linux 系统（LFS）的全过程。

## 项目架构
- **固件**: OpenSBI v1.8 (generic)
- **内核**: Linux Kernel v6.6 LTS (riscv64)
- **用户态**: BusyBox v1.36 (Static Linked)
- **文件系统**: ext4 格式磁盘镜像

## 目录说明
- `001-*.md`, `002-*.md`: 任务规划与阶段性总结。
- `003-LFS构建过程报告.md`: **核心报告文档**，包含详细的构建步骤与技术决策。
- `run-qemu.sh`: 一键启动系统的脚本。
- `task.md`, `revise.md`: 原始任务要求与专家评价意见。

## 如何运行
确保宿主机已安装 `qemu-system-riscv64`。

1. **解压交付物** (如果从 tar 包恢复):
   ```bash
   tar -zxvf riscv_lfs_delivery.tar.gz
   cd output
   ```
2. **启动系统**:
   ```bash
   ./run-qemu.sh
   ```
3. **交互**:
   当看到 `Please press Enter to activate this console.` 时，按下回车键即可进入 Shell。
   退出 QEMU 请使用 `Ctrl + A` 紧接着按 `X`。

## 关键成果
- 成功实现了 OpenSBI 引导内核并挂载 ext4 磁盘镜像。
- 优化了启动架构（跳过 U-Boot 直接引导），提升了启动速度与系统精简度。
- 完善了 init 进程配置，确保系统能够正常进入交互模式。
