# dotfiles

> 🏡 Meine persönliche macOS-Systemkonfiguration mit [chezmoi](https://www.chezmoi.io/)

🌐 **[Zur Website →](https://nimble-123.github.io/dotfiles/)**

Automatisierte Einrichtung für:

- 🍺 Homebrew-Pakete und Apps (170+ Einträge)
- 🐚 Modern Shell Setup (zsh, starship, zinit)
- 💻 VS Code Konfiguration (90+ Extensions)
- 🎨 macOS Systemeinstellungen & Dock-Layout
- ⚡ CLI Tools (eza, bat, fzf, ripgrep, zoxide, ...)

## ⚡ Schnellstart

### Erstinstallation

```bash
# 1. Homebrew installieren (falls noch nicht vorhanden)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 2. chezmoi installieren und dotfiles anwenden
brew install chezmoi
chezmoi init --apply https://github.com/nimble-123/dotfiles.git
```

Das war's! chezmoi führt automatisch aus:

- ✅ Installation aller Homebrew-Pakete aus `.Brewfile`
- ✅ Anwendung der macOS-Systemeinstellungen
- ✅ Dock-Konfiguration
- ✅ Installation aller VS Code Extensions

### Updates

```bash
# Neueste Änderungen holen und anwenden
chezmoi update

# Oder manuell
chezmoi git pull && chezmoi apply
```

## 📁 Struktur

```
.
├── .chezmoiscripts/          # Automatisierungs-Skripte
│   ├── run_onchange_10_brew.sh
│   ├── run_onchange_20_macos_defaults.sh
│   ├── run_once_30_macos_dock.sh
│   └── run_onchange_40_vscode_extensions.sh
├── dot_Brewfile              # Homebrew Pakete & Apps
├── dot_gitconfig             # Git-Konfiguration
├── dot_zshrc                 # Zsh-Konfiguration
├── dot_zprofile              # Zsh-Profil (Homebrew init)
├── dot_config/
│   ├── starship.toml         # Starship Prompt
│   ├── zsh/aliases.zsh       # Shell-Aliases
│   ├── macos/                # macOS-Skripte
│   └── vscode/               # VS Code Extensions
└── private_Library/          # VS Code Settings (privat)
```

## 🛠️ Enthaltene Tools

### Shell & Terminal

- **zsh** mit [zinit](https://github.com/zdharma-continuum/zinit) Plugin-Manager
- **starship** - Moderner, schneller Prompt
- **zoxide** - Smarte Verzeichnis-Navigation
- **fzf** - Fuzzy Finder für Command-History
- **eza** - Modernes `ls` mit Icons
- **bat** - `cat` mit Syntax-Highlighting
- **ripgrep** - Schnellere `grep`-Alternative
- **fd** - Besseres `find`

### Entwicklung

- Git, GitHub CLI, Git Delta
- Node.js (via nvm), Python (pyenv), Go
- Docker Desktop
- Terraform, Azure CLI, Cloud Foundry CLI
- VS Code mit umfangreicher Extension-Liste

### Produktivität

- 1Password CLI
- Maccy (Clipboard Manager)
- Alt-Tab (Window Switcher)
- Stats (System Monitor)
- Shottr (Screenshot Tool)

## 🔧 Konfigurationsdetails

### macOS Einstellungen

Die Datei [`dot_config/macos/executable_defaults.sh`](dot_config/macos/executable_defaults.sh) konfiguriert:

- Schnelle Key-Repeat-Rate
- Screenshots im PNG-Format nach `~/Screenshots`
- Finder: Versteckte Dateien & Erweiterungen anzeigen
- Dock: Autohide, 9×9 Launchpad-Grid
- Safari: Developer Tools aktiviert
- Activity Monitor: CPU-Anzeige im Dock

### Shell-Aliases

Siehe [`dot_config/zsh/aliases.zsh`](dot_config/zsh/aliases.zsh):

```bash
ll      # eza -lah mit Icons
cat     # bat mit Syntax-Highlighting
find    # fd (schneller)
grep    # ripgrep
g       # git
gs      # git status -sb
glog    # git log --graph
```

## 🔄 Änderungen am Setup

### Pakete hinzufügen

```bash
# Brewfile bearbeiten
chezmoi edit ~/.Brewfile

# Änderungen anwenden
chezmoi apply
```

### Einstellungen ändern

```bash
# Datei bearbeiten (z.B. .zshrc)
chezmoi edit ~/.zshrc

# Änderungen prüfen
chezmoi diff

# Anwenden
chezmoi apply
```

### In Git committen

```bash
chezmoi cd
git add .
git commit -m "feat: neue Konfiguration"
git push
```

## 📝 Semantic Versioning

Dieses Repository nutzt [Conventional Commits](https://www.conventionalcommits.org/) und [standard-version](https://github.com/conventional-changelog/standard-version):

```bash
npm run commit    # Commitizen für Conventional Commits
npm run release   # Neue Version erstellen
```

## 🙏 Credits

- macOS Einstellungen inspiriert von [mathiasbynens/dotfiles](https://github.com/mathiasbynens/dotfiles)
- Chezmoi-Setup-Ideen von der [chezmoi-Community](https://github.com/twpayne/chezmoi)

## 📄 Lizenz

MIT
