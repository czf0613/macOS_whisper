#!/bin/bash
set -e

cd $(dirname "$0")
/usr/bin/python3 -m venv .

source bin/activate
pip install -i https://mirrors.tuna.tsinghua.edu.cn/pypi/web/simple -r res/requirements.txt
deactivate

mkdir -p work_cache