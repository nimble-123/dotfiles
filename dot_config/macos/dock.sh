#!/usr/bin/env bash
set -euo pipefail

command -v dockutil >/dev/null 2>&1 || { echo "dockutil fehlt (brew install dockutil)"; exit 0; }

add_app () {
  local app="$1"; local after="$2"
  [[ -e "$app" ]] && dockutil --add "$app" --after "$after" --allhomes >/dev/null || true
}

add_stack () {
  local path="$1"
  [[ -e "$path" ]] && dockutil --add "$path" --section others --view grid --display folder --allhomes >/dev/null || true
}

# Clear Dock
dockutil --remove all --allhomes >/dev/null || true

# Core
dockutil --add "/System/Applications/Launchpad.app" --after "Finder" --allhomes >/dev/null || true
add_app "/Applications/Microsoft Edge.app" "Launchpad"     # oder Chrome
add_app "/Applications/Microsoft Outlook.app" "Microsoft Edge"
add_app "/Applications/Notion.app" "Microsoft Outlook"

# Comms
add_app "/Applications/Slack.app" "Notion"
add_app "/Applications/WhatsApp.app" "Slack"
add_app "/Applications/Discord.app" "WhatsApp"

# Dev
add_app "/Applications/Warp.app" "Discord"
add_app "/Applications/Visual Studio Code.app" "Warp"
add_app "/Applications/Antigravity.app" "Visual Studio Code"
add_app "/Applications/Postman.app" "Antigravity"

# Optional daily
add_app "/Applications/1Password.app" "Postman"
add_app "/Applications/Spotify.app" "1Password"
add_app "/Applications/ChatGPT.app" "Spotify"
add_app "/Applications/App Store.app" "ChatGPT"
add_app "/Applications/System Settings.app" "App Store"

# Stacks
add_stack "$HOME/Dock/Dev"
add_stack "$HOME/Dock/Office"
add_stack "$HOME/Downloads"

killall Dock >/dev/null 2>&1 || true
echo "[dock] Dock configuration applied."