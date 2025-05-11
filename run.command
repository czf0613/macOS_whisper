#!/bin/bash
set -e

cd $(dirname "$0")
mkdir -p work_cache

source bin/activate
python src/main.py
deactivate