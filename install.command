#!/bin/bash
set -e
echo "安装中...请勿关闭终端！"

# 创建venv
cd "$(dirname "$0")"
/usr/bin/python3 -m venv .

# 安装依赖包
source bin/activate
pip install -i https://mirrors.tuna.tsinghua.edu.cn/pypi/web/simple -r res/requirements.txt
deactivate

# 下载资源
curl -fLv \
-o res/ffmpeg \
"https://nas.kevinc.ltd:30002/p/public/mlx-whisper/ffmpeg?sign=YsQ9tSmEFmvR1zWmxikDgU6rWnCOD963HHeE4N4HG88=:0"

chmod +x res/ffmpeg

curl -fLv \
-o model.zip \
"https://nas.kevinc.ltd:30002/d/public/mlx-whisper/whisper-large-v3-mlx.zip?sign=He6kNNE-6uNAWjOkek-snrEJOiRzwGwuIXn0FN5eUcY=:0"

unzip -o model.zip -d .
rm -rf __MACOSX || true
rm -f model.zip || true

echo "安装完成！"