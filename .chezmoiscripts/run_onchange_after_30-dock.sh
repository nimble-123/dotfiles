#!/usr/bin/env bash
# Dock-Layout + Stacks. Läuft erneut, sobald sich diese Datei ändert.
# Nicht installierte Apps werden übersprungen.
set -euo pipefail

command -v dockutil >/dev/null 2>&1 || { echo "[dock] dockutil fehlt – überspringe."; exit 0; }

DEV_DIR="$HOME/Dock/Dev"
OFFICE_DIR="$HOME/Dock/Office"
mkdir -p "$DEV_DIR" "$OFFICE_DIR"
find "$DEV_DIR" "$OFFICE_DIR" -maxdepth 1 -type l ! -exec test -e {} \; -delete

link() { [[ -e "$1" ]] && ln -sf "$1" "$2/" || true; }

# --- Stack: Dev --------------------------------------------------------------
for app in "Visual Studio Code" Antigravity Cursor Xcode Warp \
           Docker Postman Bruno Chatbox ChatGPT Figma; do
  link "/Applications/$app.app" "$DEV_DIR"
done
link "/System/Applications/Utilities/Terminal.app" "$DEV_DIR"

# --- Stack: Office -----------------------------------------------------------
for app in "Microsoft Outlook" "Microsoft Teams" "Microsoft Word" "Microsoft Excel" \
           "Microsoft PowerPoint" "Microsoft OneNote" OneDrive Zotero Notion Obsidian; do
  link "/Applications/$app.app" "$OFFICE_DIR"
done

# --- Dock-Apps ---------------------------------------------------------------
dockutil --remove all --no-restart >/dev/null 2>&1 || true

for app in \
  "/System/Applications/Apps.app" \
  "/Applications/Microsoft Edge.app" \
  "/Applications/Microsoft Outlook.app" \
  "/Applications/Notion.app" \
  "/Applications/Slack.app" \
  "/Applications/WhatsApp.app" \
  "/Applications/Discord.app" \
  "/Applications/Warp.app" \
  "/Applications/Visual Studio Code.app" \
  "/Applications/Antigravity.app" \
  "/Applications/Postman.app" \
  "/Applications/1Password.app" \
  "/Applications/Spotify.app" \
  "/Applications/ChatGPT.app" \
  "/System/Applications/App Store.app" \
  "/System/Applications/System Settings.app"; do
  [[ -e "$app" ]] && dockutil --add "$app" --no-restart >/dev/null || true
done

# --- Stacks ------------------------------------------------------------------
for stack in "$DEV_DIR" "$OFFICE_DIR" "$HOME/Downloads"; do
  dockutil --add "$stack" --section others --view grid --display folder --no-restart >/dev/null || true
done

killall Dock >/dev/null 2>&1 || true
echo "[dock] Dock eingerichtet."
