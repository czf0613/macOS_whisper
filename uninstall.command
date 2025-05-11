#!/bin/bash
set -e

cd $(dirname "$0")

rm -rf bin/ || true
rm -rf include/ || true
rm -rf lib/ || true
rm -rf share/ || true
rm -f pyvenv.cfg || true

rm -rf work_cache/ || true