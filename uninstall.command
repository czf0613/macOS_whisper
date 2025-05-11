#!/bin/bash
set -e

cd $(dirname "$0")

# 删掉venv
rm -rf bin/ || true
rm -rf include/ || true
rm -rf lib/ || true
rm -rf share/ || true
rm -f pyvenv.cfg || true

# 删掉依赖
rm -rf work_cache/ || true
rm -f res/ffmpeg || true
rm -rf whisper-large-v3-mlx/ || true