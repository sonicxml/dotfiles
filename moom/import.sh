#!/usr/bin/env bash
# Restore Moom's settings from the dotfiles repo (fresh machine, or rollback).
set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/dotfiles}"
SRC="$DOTFILES_DIR/moom/Moom.plist"

[ -f "$SRC" ] || { echo "No snapshot at $SRC — run moom/export.sh first." >&2; exit 1; }

osascript -e 'quit app "Moom"' 2>/dev/null || true
sleep 1

defaults import com.manytricks.Moom "$SRC"
killall cfprefsd   # drop the cached copy so Moom reads what we just wrote

open -a Moom
echo "Imported Moom settings from $SRC"
echo "Note: Accessibility permission and the license key are per-machine; set those by hand."
