#!/usr/bin/env bash
set -euo pipefail

if [[ "$(uname -s)" != "Darwin" ]]; then
  exit 0
fi

if ! command -v dockutil >/dev/null 2>&1; then
  echo "[dock] dockutil not found. Install via Brewfile (brew install dockutil). Skipping."
  exit 0
fi

add_app () {
  local app="$1"
  local after="$2"
  [[ -e "$app" ]] && dockutil --add "$app" --after "$after" --allhomes >/dev/null || true
}

add_stack () {
  local path="$1"
  [[ -e "$path" ]] && dockutil --add "$path" --section others --view grid --display folder --allhomes >/dev/null || true
}

# Clear Dock
dockutil --remove all --allhomes >/dev/null || true

# Minimal Core (anpassen wie du willst)
add_app "/System/Applications/Launchpad.app" "Finder"

# Browser: nimm einen als Default (ich nehme Edge als Beispiel)
add_app "/Applications/Microsoft Edge.app" "Launchpad"

# Mail/Calendar (optional)
add_app "/Applications/Microsoft Outlook.app" "Microsoft Edge"
add_app "/System/Applications/Calendar.app" "Microsoft Outlook"

# Dev default apps (optional)
add_app "/Applications/Warp.app" "Calendar"
add_app "/Applications/Visual Studio Code.app" "Warp"
add_app "/Applications/Docker.app" "Visual Studio Code"
add_app "/Applications/Postman.app" "Docker"

# Optional daily
add_app "/Applications/1Password.app" "Postman"
add_app "/Applications/Spotify.app" "1Password"

# ---- Stacks on the right ----
add_stack "$HOME/Dock/Dev"
add_stack "$HOME/Dock/Office"
add_stack "$HOME/Downloads"
[[ -d "$HOME/Screenshots" ]] && add_stack "$HOME/Screenshots"

killall Dock >/dev/null 2>&1 || true
echo "[dock] Dock built (run_once)."
