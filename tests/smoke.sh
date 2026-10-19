#!/usr/bin/env bash

set -Eeuo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

bash -n "$ROOT_DIR/bin/proxy-chain"
bash -n "$ROOT_DIR/install.sh"
bash -n "$ROOT_DIR/scripts/check-secrets.sh"

help_output="$(bash "$ROOT_DIR/bin/proxy-chain" help)"
grep -q 'proxy-chain init' <<< "$help_output"
grep -q 'proxy-chain test' <<< "$help_output"
grep -q 'proxy-chain uninstall' <<< "$help_output"

grep -q '## 第一步' "$ROOT_DIR/README.md"
grep -q '## 第二步' "$ROOT_DIR/README.md"
grep -q '## 第三步' "$ROOT_DIR/README.md"

printf 'Smoke tests passed.\n'
