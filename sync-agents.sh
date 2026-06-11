#!/bin/bash
set -euo pipefail

# どこから実行されてもリポルート（このスクリプトの場所）を基準にする
cd "$(dirname "$0")"

GROK_DIR="$HOME/.grok"
TARGET="$GROK_DIR/AGENTS.md"

# 初回環境でも動くようディレクトリを保証する
mkdir -p "$GROK_DIR"

if [ -f "$TARGET" ]; then
  echo "Backing up..."
  cp "$TARGET" "$TARGET.bak.$(date +%Y%m%d%H%M%S)"
  # バックアップは直近3世代のみ保持する
  ls -t "$TARGET".bak.* 2>/dev/null | tail -n +4 | while read -r old; do
    rm -f "$old"
  done
fi

echo "Copying..."
cp AGENTS.md "$TARGET"

echo "Verifying..."
diff AGENTS.md "$TARGET"

echo "Done."
