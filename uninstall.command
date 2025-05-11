#!/bin/bash
set -e

echo "正在删除虚拟环境和依赖..."
cd "$(dirname "$0")"

# 删掉venv
rm -rvf bin/ || true
rm -rvf include/ || true
rm -rvf lib/ || true
rm -rvf share/ || true
rm -vf pyvenv.cfg || true

# 删掉依赖
rm -rvf work_cache/ || true
rm -vf res/ffmpeg || true
rm -rvf whisper-large-v3-mlx/ || true

echo "删除完成！可以关闭终端"