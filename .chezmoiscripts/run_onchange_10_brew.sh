#!/usr/bin/env bash
set -euo pipefail

# Run only if brew exists (bootstrap happens before chezmoi init --apply)
if ! command -v brew >/dev/null 2>&1; then
  echo "[brew] Homebrew not found. Skipping brew bundle."
  exit 0
fi

if [[ -f "$HOME/.Brewfile" ]]; then
  echo "[brew] Running brew bundle..."
  brew bundle --file "$HOME/.Brewfile"
else
  echo "[brew] No ~/.Brewfile found. Skipping."
fi
