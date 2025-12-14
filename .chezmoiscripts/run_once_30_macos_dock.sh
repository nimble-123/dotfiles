#!/usr/bin/env bash
set -euo pipefail

if [[ "$(uname -s)" != "Darwin" ]]; then
  exit 0
fi

# Only run if dockutil exists (ideally installed via Brewfile)
if ! command -v dockutil >/dev/null 2>&1; then
  echo "[dock] dockutil not found. Install via Brewfile (brew install dockutil). Skipping."
  exit 0
fi

if [[ -x "$HOME/.config/macos/dock.sh" ]]; then
  echo "[dock] Building dock (run_once)..."
  "$HOME/.config/macos/dock.sh"
else
  echo "[dock] dock.sh missing or not executable. Skipping."
fi
