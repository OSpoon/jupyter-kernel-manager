# Jupyter Kernel Manager

用于管理 Jupyter 的 Python kernels。支持添加新的 conda 环境到 Jupyter，以及移除不需要的 kernels。

## 功能特点

- 快速创建新的 conda 环境并添加到 Jupyter
- 自定义 Jupyter kernel 的显示名称
- 安全地移除用户创建的 kernels（保护系统默认 kernels）

## 系统要求

- Windows 操作系统
- PowerShell
- Anaconda
- Jupyter Lab

## 快速开始

### 一键安装（推荐）

```powershell
irm https://raw.githubusercontent.com/OSpoon/jupyter-kernel-manager/main/jkm.ps1 | iex
```

### 手动安装

1. 克隆仓库：
```bash
git clone https://github.com/OSpoon/jupyter-kernel-manager.git
```

2. 进入项目目录：
```bash
cd jupyter-kernel-manager
```

3. 运行脚本：
```bash
.\jkm.ps1
```

## 许可证

MIT License

Copyright (c) 2024 OSpoon

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.