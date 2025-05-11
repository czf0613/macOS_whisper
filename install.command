#!/bin/bash
set -e

# 创建venv
cd $(dirname "$0")
/usr/bin/python3 -m venv .

# 安装依赖包
source bin/activate
pip install -i https://mirrors.tuna.tsinghua.edu.cn/pypi/web/simple -r res/requirements.txt
deactivate

# 下载资源
wget https://nas.kevinc.ltd:30002/p/public/mlx-whisper/ffmpeg?sign=YsQ9tSmEFmvR1zWmxikDgU6rWnCOD963HHeE4N4HG88=:0 -v -O res/ffmpeg
chmod +x res/ffmpeg
mkdir -p work_cache
wget https://nas.kevinc.ltd:30002/d/public/mlx-whisper/whisper-large-v3-mlx.zip?sign=He6kNNE-6uNAWjOkek-snrEJOiRzwGwuIXn0FN5eUcY=:0 -v -O work_cache/model.zip
unzip -o work_cache/model.zip -d .
rm -rf work_cache
rm -rf __MACOSX || true