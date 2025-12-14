#!/usr/bin/env bash
set -euo pipefail

if ! command -v code >/dev/null 2>&1; then
  echo "[vscode] 'code' command not found. Skipping extension install."
  echo "        In VS Code: Cmd+Shift+P -> 'Shell Command: Install code command in PATH'"
  exit 0
fi

if [[ -x "$HOME/.config/vscode/install-extensions.sh" ]]; then
  echo "[vscode] Installing extensions..."
  "$HOME/.config/vscode/install-extensions.sh"
else
  echo "[vscode] install-extensions.sh missing or not executable. Skipping."
fi
