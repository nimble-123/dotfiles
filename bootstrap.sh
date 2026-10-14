#!/usr/bin/env bash
# Neuer Mac:  curl -fsSL https://raw.githubusercontent.com/nimble-123/dotfiles/main/bootstrap.sh | bash
# Idempotent: kann beliebig oft laufen.
set -euo pipefail

GITHUB_USER="nimble-123"

say()  { printf '\n\033[1;34m==> %s\033[0m\n' "$*"; }
fail() { printf '\n\033[1;31m✗ %s\033[0m\n' "$*" >&2; exit 1; }

is_admin=false
id -Gn | tr ' ' '\n' | grep -qx admin && is_admin=true

# --- 1. Xcode Command Line Tools ---------------------------------------------
if ! xcode-select -p >/dev/null 2>&1; then
  say "Installiere Xcode Command Line Tools (Dialog bestätigen) …"
  xcode-select --install || true
  until xcode-select -p >/dev/null 2>&1; do sleep 5; done
fi

# --- 2. Homebrew -------------------------------------------------------------
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

if ! command -v brew >/dev/null 2>&1; then
  $is_admin || fail "Homebrew fehlt und dieser Account hat keine Admin-Rechte.
  Homebrew braucht einmalig Admin-Rechte für /opt/homebrew.
  Optionen: IT/Self-Service um Homebrew bitten oder temporäre Admin-Rechte holen,
  dann dieses Skript erneut starten."
  say "Installiere Homebrew …"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" </dev/tty
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# --- 3. chezmoi --------------------------------------------------------------
command -v chezmoi >/dev/null 2>&1 || { say "Installiere chezmoi …"; brew install chezmoi; }

# --- 4. Dotfiles -------------------------------------------------------------
src="$(chezmoi source-path 2>/dev/null || echo "$HOME/.local/share/chezmoi")"
if [[ -d "$src/.git" ]]; then
  say "Repo vorhanden – aktualisiere …"
  git -C "$src" pull --ff-only
else
  say "Klone Dotfiles (Fragen zu E-Mail / Arbeits-Mac folgen) …"
  chezmoi init "$GITHUB_USER" </dev/tty
fi

git -C "$src" config core.hooksPath .githooks

say "Diese Änderungen würde chezmoi vornehmen:"
chezmoi diff --no-pager || true

read -r -p $'\nJetzt anwenden? [y/N] ' answer </dev/tty
if [[ "$answer" =~ ^[YyJj]$ ]]; then
  chezmoi apply </dev/tty
  say "Fertig. Offene manuelle Schritte: Checkliste in der README."
else
  echo "Abgebrochen. Später: chezmoi diff && chezmoi apply"
fi
