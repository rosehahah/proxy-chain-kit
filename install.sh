#!/usr/bin/env bash

set -Eeuo pipefail

if [[ "$(uname -s)" != "Darwin" ]]; then
  printf '错误：当前版本仅支持 macOS。\n' >&2
  exit 1
fi

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="${HOME}/.local/bin"
TARGET_BIN="${TARGET_DIR}/proxy-chain"

mkdir -p "$TARGET_DIR"
install -m 755 "${ROOT_DIR}/bin/proxy-chain" "$TARGET_BIN"

printf '✓ 已安装到 %s\n' "$TARGET_BIN"
if [[ ":${PATH}:" != *":${TARGET_DIR}:"* ]]; then
  printf '\n当前终端的 PATH 里没有 %s。\n' "$TARGET_DIR"
  printf '你可以直接运行：\n\n  %s init\n\n' "$TARGET_BIN"
else
  printf '\n下一步运行：\n\n  proxy-chain init\n\n'
fi
