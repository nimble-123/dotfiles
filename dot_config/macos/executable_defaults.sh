#!/usr/bin/env bash
set -euo pipefail

# Ask for the administrator password upfront
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# --------- variables (safe defaults) ----------
SCREENSHOT_DIR="${DOT_SCREENSHOT_DIR:-$HOME/Screenshots}"
ITERM_PREFS_DIR="${DOT_ITERM_PREFS_DIR:-$HOME/.config/iterm2}"

mkdir -p "$SCREENSHOT_DIR" "$ITERM_PREFS_DIR"

###############################################################################
# Shell / System
###############################################################################

# Default user login shell (current user)
if [[ "$(dscl . -read "/Users/$USER" UserShell | awk '{print $2}')" != "/bin/zsh" ]]; then
  chsh -s /bin/zsh || true
fi

# Disable the sound effects on boot (may fail on newer Macs / SIP; ignore errors)
sudo nvram SystemAudioVolume=" " 2>/dev/null || true

# Restart automatically if the computer freezes
sudo systemsetup -setrestartfreeze on >/dev/null 2>&1 || true

# Check for software updates daily
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

###############################################################################
# General UI/UX
###############################################################################

defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 1
defaults write NSGlobalDomain AppleShowScrollBars -string "WhenScrolling"
defaults write NSGlobalDomain NSUseAnimatedFocusRing -bool false
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

# Expand save/print panels by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# Save to disk by default (not iCloud)
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Quit printer app after jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Show ASCII control characters in text views
defaults write NSGlobalDomain NSTextShowsControlCharacters -bool true

# Disable automatic termination of inactive apps
defaults write NSGlobalDomain NSDisableAutomaticTermination -bool true

# Reveal hostname etc. in login window clock click
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

# Coding-friendly text input
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

###############################################################################
# Keyboard / Trackpad / Accessibility
###############################################################################

# Natural scrolling
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool true

# Full keyboard access (Tab in dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Zoom with Ctrl+scroll (optional – keep if you like it)
defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true
defaults write com.apple.universalaccess HIDScrollZoomModifierMask -int 262144
defaults write com.apple.universalaccess closeViewZoomFollowsFocus -bool true

# Disable press-and-hold for key repeat
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Fast key repeat (also set InitialKeyRepeat; you didn’t have that before)
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# Bluetooth audio quality tweak (harmless; may not do much nowadays)
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

###############################################################################
# Screen / Screenshots
###############################################################################

# Require password immediately after sleep/screensaver
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Screenshots
defaults write com.apple.screencapture location -string "$SCREENSHOT_DIR"
defaults write com.apple.screencapture type -string "png"
defaults write com.apple.screencapture disable-shadow -bool false

# Font smoothing (mostly legacy; keep if you want)
defaults write NSGlobalDomain AppleFontSmoothing -int 2

# Enable HiDPI modes (requires restart)
sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true

###############################################################################
# Finder
###############################################################################

defaults write com.apple.finder QuitMenuItem -bool true
defaults write com.apple.finder DisableAllAnimations -bool true

# Default Finder window: Home
defaults write com.apple.finder NewWindowTarget -string "PfLo"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"

# Show hidden files + extensions
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Status + Path bar
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder ShowPathbar -bool true

# Show full POSIX path in title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Search current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# No warning on changing file extensions
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Spring loading
defaults write NSGlobalDomain com.apple.springing.enabled -bool true
defaults write NSGlobalDomain com.apple.springing.delay -float 0.3

# Avoid .DS_Store on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# List view by default
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# No warning before emptying Trash
defaults write com.apple.finder WarnOnEmptyTrash -bool false

# AirDrop over Ethernet
defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true

# Show ~/Library
chflags nohidden "$HOME/Library" || true

# Expand File Info panes
defaults write com.apple.finder FXInfoPanesExpanded -dict \
  General -bool true \
  OpenWith -bool true \
  Privileges -bool true

###############################################################################
# Dock / Mission Control / Hot Corners
###############################################################################

defaults write com.apple.dock mouse-over-hilite-stack -bool true
defaults write com.apple.dock tilesize -int 24
defaults write com.apple.dock mineffect -string "scale"
defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true
defaults write com.apple.dock show-process-indicators -bool true
defaults write com.apple.dock launchanim -bool false
defaults write com.apple.dock expose-animation-duration -float 0.1
defaults write com.apple.dock expose-group-by-app -bool false
defaults write com.apple.dock mru-spaces -bool false

# Autohide (in deinem Script war es kommentiert, aber Delay/Time gesetzt → jetzt konsistent)
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0

# Hidden apps translucent
defaults write com.apple.dock showhidden -bool true

# Launchpad grid
defaults write com.apple.dock springboard-columns -int 9
defaults write com.apple.dock springboard-rows -int 9

# Hot corners: BR -> Desktop, BL -> Screensaver
defaults write com.apple.dock wvous-br-corner -int 4
defaults write com.apple.dock wvous-br-modifier -int 0
defaults write com.apple.dock wvous-bl-corner -int 5
defaults write com.apple.dock wvous-bl-modifier -int 0

###############################################################################
# Safari
###############################################################################

defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.Safari SuppressSearchSuggestions -bool true
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true
defaults write com.apple.Safari HomePage -string "about:blank"
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false
defaults write com.apple.Safari ShowFavoritesBar -bool false
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

###############################################################################
# Mail
###############################################################################

defaults write com.apple.mail DisableReplyAnimations -bool true
defaults write com.apple.mail DisableSendAnimations -bool true
defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false
defaults write com.apple.mail NSUserKeyEquivalents -dict-add "Send" -string "@\\U21a9"

###############################################################################
# Terminal / iTerm2
###############################################################################

# Terminal.app: UTF-8
defaults write com.apple.terminal StringEncodings -array 4
defaults write com.apple.terminal FocusFollowsMouse -bool true

# iTerm2: use custom prefs folder
defaults write com.googlecode.iterm2 PrefsCustomFolder -string "$ITERM_PREFS_DIR"
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true

###############################################################################
# Time Machine (local snapshots: best-effort, may be deprecated)
###############################################################################

defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true
if command -v tmutil >/dev/null 2>&1; then
  sudo tmutil disablelocal >/dev/null 2>&1 || true
fi

###############################################################################
# Activity Monitor
###############################################################################

defaults write com.apple.ActivityMonitor OpenMainWindow -bool true
defaults write com.apple.ActivityMonitor IconType -int 5
defaults write com.apple.ActivityMonitor ShowCategory -int 0
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0

###############################################################################
# TextEdit
###############################################################################

defaults write com.apple.TextEdit RichText -int 0
defaults write com.apple.TextEdit PlainTextEncoding -int 4
defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4

###############################################################################
# Photos / Messages / Chrome printing
###############################################################################

defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticQuoteSubstitutionEnabled" -bool false
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "continuousSpellCheckingEnabled" -bool false

defaults write com.google.Chrome DisablePrintPreview -bool true
defaults write com.google.Chrome PMPrintingExpandedStateForPrint2 -bool true

###############################################################################
# Restart affected apps
###############################################################################
for app in "Activity Monitor" "Contacts" "Calendar" "Dock" "Finder" "Mail" \
           "Messages" "Photos" "Safari" "SystemUIServer" "Terminal" \
           "Google Chrome" "iTerm2"; do
  killall "$app" >/dev/null 2>&1 || true
done

echo "Done. Some changes require logout/restart."