#!/usr/bin/env bash
set -euo pipefail

command -v dockutil >/dev/null 2>&1 || {
  echo "dockutil not found. Install via: brew install dockutil"
  exit 0
}

add_app () {
  local app="$1"
  local after="$2"

  if [[ -e "$app" ]]; then
    dockutil --add "$app" --after "$after" --allhomes >/dev/null
  fi
}

# Clear Dock
dockutil --remove all --allhomes >/dev/null

# Base
dockutil --add "/System/Applications/Launchpad.app" --after "Finder" --allhomes >/dev/null

# Examples (nur wenn vorhanden):
add_app "/Applications/Google Chrome.app" "Launchpad"
add_app "/Applications/Visual Studio Code.app" "Google Chrome"
add_app "/Applications/iTerm.app" "Visual Studio Code"
add_app "/Applications/Warp.app" "iTerm"

# System Settings (Ventura+) / System Preferences (alt)
if [[ -e "/System/Applications/System Settings.app" ]]; then
  dockutil --add "/System/Applications/System Settings.app" --after "Warp" --allhomes >/dev/null || true
elif [[ -e "/Applications/System Preferences.app" ]]; then
  dockutil --add "/Applications/System Preferences.app" --after "Warp" --allhomes >/dev/null || true
fi

# Downloads folder
dockutil --add "$HOME/Downloads" --section others --view grid --display folder --allhomes >/dev/null

killall Dock >/dev/null 2>&1 || true