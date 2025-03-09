# Jupyter Kernel Manager

用于管理 Jupyter 的 Python kernels。支持添加新的 conda 环境到 Jupyter，以及移除不需要的 kernels。

## 功能特点

- 快速创建新的 conda 环境并添加到 Jupyter
- 自定义 Jupyter kernel 的显示名称
- 安全地移除用户创建的 kernels（保护系统默认 kernels）
- 跨平台支持（Windows/MacOS）

## 系统要求

- Windows/MacOS 操作系统
- PowerShell (Windows) / Terminal (MacOS)
- Anaconda
- Jupyter Lab

## 快速开始

### Windows 安装

```powershell
irm https://raw.githubusercontent.com/OSpoon/jupyter-kernel-manager/main/install.ps1 | iex
```

### MacOS 安装

```bash
curl -s https://raw.githubusercontent.com/OSpoon/jupyter-kernel-manager/main/install.sh | bash
```

### 使用说明

1. 安装完成后需要重新打开终端
2. Windows 下使用 `jkm.ps1`，MacOS 下使用 `jkm.sh`
3. 首次使用可能需要设置执行权限：
   - Windows: 以管理员身份运行 PowerShell，执行 `Set-ExecutionPolicy RemoteSigned -Scope CurrentUser`
   - MacOS: 执行 `chmod +x ~/jupyter-kernel-manager/bin/jkm.sh`

### 常见问题

1. 环境变量未生效：重新打开终端
2. 权限问题：确保有管理员权限
3. conda 未找到：确保已将 conda 添加到环境变量

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