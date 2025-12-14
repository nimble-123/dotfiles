#!/usr/bin/env bash
set -euo pipefail

# Only on macOS
[[ "$(uname -s)" == "Darwin" ]] || exit 0

DEV_DIR="$HOME/Dock/Dev"
OFFICE_DIR="$HOME/Dock/Office"

mkdir -p "$DEV_DIR" "$OFFICE_DIR"

link_app () {
  local app_path="$1"
  local target_dir="$2"

  # Only link if app exists
  if [[ -e "$app_path" ]]; then
    ln -sf "$app_path" "$target_dir/"
  fi
}

# Optional: remove broken symlinks (keeps folders tidy)
cleanup_broken () {
  local dir="$1"
  find "$dir" -maxdepth 1 -type l ! -exec test -e {} \; -print -delete 2>/dev/null || true
}
cleanup_broken "$DEV_DIR"
cleanup_broken "$OFFICE_DIR"

###############################################################################
# DEV stack
###############################################################################
# IDEs / Editors (choose one as dock-default; the other can live here)
link_app "/Applications/Visual Studio Code.app" "$DEV_DIR"
link_app "/Applications/Antigravity.app" "$DEV_DIR"
link_app "/Applications/Cursor.app" "$DEV_DIR"
link_app "/Applications/WebStorm.app" "$DEV_DIR"
link_app "/Applications/Xcode.app" "$DEV_DIR"

# Terminals (keep the "secondary" one in the stack)
link_app "/Applications/Warp.app" "$DEV_DIR"
link_app "/Applications/iTerm.app" "$DEV_DIR"
link_app "/Applications/Terminal.app" "$DEV_DIR"

# Dev tools
link_app "/Applications/Docker.app" "$DEV_DIR"
link_app "/Applications/Postman.app" "$DEV_DIR"
link_app "/Applications/CAP Console.app" "$DEV_DIR"

link_app "/Applications/Chatbox.app" "$DEV_DIR"
link_app "/Applications/ChatGPT Atlas.app" "$DEV_DIR"
link_app "/Applications/ChatGPT.app" "$DEV_DIR"
link_app "/Applications/Docker.app" "$DEV_DIR"
link_app "/Applications/Figma.app" "$DEV_DIR"
link_app "/Applications/Frame0.app" "$DEV_DIR"

###############################################################################
# OFFICE stack
###############################################################################
# Microsoft 365
link_app "/Applications/Microsoft Outlook.app" "$OFFICE_DIR"
link_app "/Applications/Microsoft Teams.app" "$OFFICE_DIR"
link_app "/Applications/Microsoft Word.app" "$OFFICE_DIR"
link_app "/Applications/Microsoft Excel.app" "$OFFICE_DIR"
link_app "/Applications/Microsoft PowerPoint.app" "$OFFICE_DIR"
link_app "/Applications/Microsoft OneNote.app" "$OFFICE_DIR"
link_app "/Applications/OneDrive.app" "$OFFICE_DIR"
link_app "/Applications/Zotero.app" "$OFFICE_DIR"

# Knowledge / Notes
link_app "/Applications/Notion.app" "$OFFICE_DIR"

echo "[dock-stacks] Updated: $DEV_DIR and $OFFICE_DIR"
