#!/usr/bin/env bash
set -euo pipefail
EXT_FILE="${1:-$HOME/.config/vscode/extensions.txt}"
command -v code >/dev/null 2>&1 || {
  echo "VS Code 'code' command fehlt. In VS Code: Cmd+Shift+P -> 'Shell Command: Install code command in PATH'"
  exit 1
}
grep -vE '^\s*$' "$EXT_FILE" | while read -r ext; do
  code --install-extension "$ext" || true
done
