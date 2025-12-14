#!/usr/bin/env bash
set -euo pipefail

if [[ "$(uname -s)" != "Darwin" ]]; then
  exit 0
fi

if [[ -x "$HOME/.config/macos/defaults.sh" ]]; then
  echo "[macos] Applying defaults..."
  "$HOME/.config/macos/defaults.sh"
else
  echo "[macos] defaults.sh missing or not executable. Skipping."
fi
