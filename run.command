#!/bin/bash
set -e

cd "$(dirname "$0")"
mkdir -p work_cache

source bin/activate

# 设置环境变量，找到ffmpeg在哪，mlx好像会依赖这个东西
export PATH="$(pwd)/res:$PATH"
python src/main.py

deactivate
echo "运行完成，可以关闭终端"