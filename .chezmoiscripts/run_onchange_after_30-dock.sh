#!/usr/bin/env bash
# Dock-Layout. Läuft erneut, sobald sich diese Datei ändert.
# Ein Layout für beide Macs: nicht installierte Apps werden übersprungen.
set -euo pipefail

command -v dockutil >/dev/null 2>&1 || { echo "[dock] dockutil fehlt – überspringe."; exit 0; }

dockutil --remove all --no-restart >/dev/null 2>&1 || true

# Reihenfolge in Blöcken: Kommunikation, Office, Wissen, API/KI, Dev, Sicherheit, System
for app in \
  "/System/Applications/Apps.app" \
  "/Applications/Microsoft Edge.app" \
  "/Applications/Microsoft Outlook.app" \
  "/Applications/Microsoft Teams.app" \
  "/Applications/Slack.app" \
  "/Applications/WhatsApp.app" \
  "/Applications/Discord.app" \
  "/Applications/Spotify.app" \
  "/Applications/Microsoft Excel.app" \
  "/Applications/Microsoft PowerPoint.app" \
  "/Applications/Microsoft Word.app" \
  "/Applications/Microsoft OneNote.app" \
  "/Applications/skills-hub.app" \
  "/Applications/Takt.app" \
  "/Applications/Obsidian.app" \
  "/Applications/Notion.app" \
  "/Applications/Bruno.app" \
  "/Applications/Postman.app" \
  "/Applications/Claude.app" \
  "/Applications/ChatGPT.app" \
  "/Applications/Visual Studio Code.app" \
  "/Applications/Antigravity.app" \
  "/Applications/Warp.app" \
  "/Applications/Docker.app/Contents/MacOS/Docker Desktop.app" \
  "/Applications/KeePassXC.app" \
  "/Applications/1Password.app" \
  "/System/Applications/App Store.app" \
  "/System/Applications/System Settings.app"; do
  [[ -e "$app" ]] && dockutil --add "$app" --no-restart >/dev/null || true
done

# --- Rechts: Downloads als Stack ---------------------------------------------
dockutil --add "$HOME/Downloads" --section others --view fan --display stack --sort dateadded --no-restart >/dev/null || true

killall Dock >/dev/null 2>&1 || true
echo "[dock] Dock eingerichtet."
