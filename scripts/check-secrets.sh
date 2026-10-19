#!/usr/bin/env bash

set -Eeuo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

tracked_files=()
while IFS= read -r -d '' file; do
  tracked_files+=("$file")
done < <(find . -type f \
  ! -path './.git/*' \
  ! -path './assets/*' \
  -print0)

patterns=(
  'gh[pousr]_[A-Za-z0-9_]+'
  'sk-ant-[A-Za-z0-9_-]+'
  'sk-proj-[A-Za-z0-9_-]+'
  'https?://[^[:space:]/]+:[^[:space:]@]+@'
  '/Users/[A-Za-z0-9._-]+'
  'Proxy-Authorization:[[:space:]]*Basic'
)

failed=0
for pattern in "${patterns[@]}"; do
  if grep -EIn "$pattern" "${tracked_files[@]}"; then
    failed=1
  fi
done

public_ips="$(grep -Eho '([0-9]{1,3}\.){3}[0-9]{1,3}' "${tracked_files[@]}" | sort -u || true)"
while IFS= read -r ip; do
  [[ -z "$ip" ]] && continue
  case "$ip" in
    127.*|0.0.0.0) ;;
    *) printf '发现可能的公网 IP：%s\n' "$ip" >&2; failed=1 ;;
  esac
done <<< "$public_ips"

if (( failed != 0 )); then
  printf '敏感信息检查失败。\n' >&2
  exit 1
fi

printf '敏感信息检查通过。\n'
