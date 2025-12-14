#!/usr/bin/env bash
set -euo pipefail

if [[ "$(uname -s)" != "Darwin" ]]; then
  exit 0
fi

if ! command -v dockutil >/dev/null 2>&1; then
  echo "[dock] dockutil not found. Install via Brewfile (brew install dockutil). Skipping."
  exit 0
fi

# Run the main dock configuration script
DOCK_SCRIPT="${HOME}/.config/macos/dock.sh"

if [[ -x "$DOCK_SCRIPT" ]]; then
  echo "[dock] Running dock setup..."
  "$DOCK_SCRIPT"
else
  echo "[dock] Warning: $DOCK_SCRIPT not found or not executable. Skipping."
  exit 0
fi
