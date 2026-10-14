# dotfiles

Mein Mac-Setup mit [chezmoi](https://chezmoi.io): ein Repo für den privaten und den Arbeits-Mac.

## Neuer Mac

```bash
curl -fsSL https://raw.githubusercontent.com/nimble-123/dotfiles/main/bootstrap.sh | bash
```

Das Skript installiert Xcode CLT → Homebrew → chezmoi, klont dieses Repo, fragt nach E-Mail, Arbeits-Mac (ja/nein) und SSH-Signing-Key, zeigt `chezmoi diff` und wendet erst nach Bestätigung an. Es kann beliebig oft laufen.

Ohne Admin-Rechte: Homebrew braucht einmalig Admin. Fehlt Homebrew, bricht das Skript mit einer Erklärung ab. Alle anderen Skripte laufen ohne `sudo`.

## Alltag

| Was | Befehl |
|---|---|
| Neue Datei aufnehmen | `chezmoi add ~/.config/foo/config` |
| Datei bearbeiten | `chezmoi edit ~/.zshrc` (oder direkt in `~` ändern, dann `chezmoi re-add`) |
| Änderungen ansehen | `chezmoi diff` |
| Anwenden | `chezmoi apply` |
| Ins Repo-Verzeichnis | `chezmoi cd` |
| Pushen | `chezmoi cd && git add -A && git commit -m "…" && git push` |
| Auf dem anderen Mac holen | `chezmoi update` (= pull + apply) |

**Neue App:** Eintrag ins passende Brewfile (`Brewfile` = beide Macs, `Brewfile.private`, `Brewfile.work`), committen, `chezmoi apply`. Das Brew-Skript läuft automatisch erneut, weil sich der Hash des Brewfiles ändert.

## Privat vs. Arbeit

Beim ersten `chezmoi init` wird gefragt, Antworten landen **nur lokal** in `~/.config/chezmoi/chezmoi.toml`:

| Variable | Wirkung |
|---|---|
| `work` | `true` = Arbeits-Mac: `Brewfile.work` statt `Brewfile.private`, `includeIf` für `~/work/`, `~/.gitconfig.work` wird angelegt |
| `email` | private Git-E-Mail (Standard für alle Repos) |
| `workEmail` | nur Arbeits-Mac: E-Mail für Repos unter `~/work/` |
| `sshSigningKey` | Public Key aus 1Password fürs Commit-Signing |

In Templates (`*.tmpl`): `{{ if .work }} … {{ end }}`. Dateien, die nur auf einem Mac existieren sollen: `.chezmoiignore`.
Werte ändern: `chezmoi edit-config`, danach `chezmoi apply`.

### Lokale, ungetrackte Dateien

Alles Firmeninterne (Hostnamen, IPs, Proxy, Registry-URLs, Arbeits-Workflows) gehört **nur** hierhin, nie ins Repo:

| Datei | Zweck |
|---|---|
| `~/.zshrc.local` | Proxy, interne Aliase, Env-Variablen |
| `~/.ssh/config.d/*` | Firmen- und interne SSH-Hosts |
| `~/.gitconfig.work` | Arbeits-E-Mail + Signing-Key für `~/work/` (einmalig von chezmoi angelegt) |
| `~/.gitconfig.local` | sonstige Git-Overrides für diesen Mac |

Secrets nur per `{{ onepasswordRead "op://Vault/Item/Feld" }}` in einem Template, nie im Klartext.

## Was drin ist

- **Shell:** `.zshrc` (zinit, starship, zoxide, direnv, fzf, nvm), `.zprofile`, `.zshenv`, `aliases.zsh`
- **Git:** `.gitconfig` mit SSH-Signing über 1Password, globale `ignore`
- **SSH:** `~/.ssh/config` mit 1Password-Agent, nur github.com. Keine Keys im Repo
- **Apps:** Warp `settings.toml`, VS Code `settings.json`, starship, btop, fastfetch, linearmouse, hazelnut
- **Skripte** (`.chezmoiscripts/`): `10-brew` (Brewfiles), `20-macos` (Finder, Dock, Tastatur, Screenshots, Dialoge), `30-dock` (Dock-Layout + Stacks)

## Sicherheit

- Pre-commit-Hook scannt jeden Commit mit gitleaks (`.githooks/`, aktiviert über `git config core.hooksPath .githooks`, macht `bootstrap.sh` automatisch)
- Ganze History prüfen: `gitleaks git .`

## Checkliste: manuelle Schritte

- [ ] **1Password** anmelden → Einstellungen → Entwickler: **SSH-Agent** und **CLI-Integration** aktivieren
- [ ] SSH testen: `ssh -T git@github.com`
- [ ] Signing-Key bei GitHub als **Signing Key** hinterlegen (Settings → SSH and GPG keys)
- [ ] **Warp:** Settings → Account → **Settings Sync aus** (sonst Konflikte mit chezmoi)
- [ ] **VS Code:** Settings Sync aus lassen (chezmoi verwaltet `settings.json`)
- [ ] App Store anmelden, dann `chezmoi apply` erneut, falls mas-Apps fehlen
- [ ] Datenschutz-Freigaben: Bedienungshilfen (alt-tab, linearmouse, Amphetamine), Bildschirmaufnahme (shottr, OBS), Festplattenvollzugriff (Warp)
- [ ] Logins & Lizenzen: GitHub (`gh auth login`), Claude, ChatGPT, MoneyMoney, gifox
- [ ] Apps mit eigener Cloud-Sync: 1Password, Obsidian, Raycast, Slack
- [ ] Rust optional: `curl https://sh.rustup.rs -sSf | sh`, danach `chezmoi apply` für cargo-Pakete
