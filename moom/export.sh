#!/usr/bin/env bash
# Snapshot Moom's settings into the dotfiles repo, then commit the result.
# Moom has no text config: layouts and hotkeys live in a binary plist that
# cfprefsd rewrites behind your back, so a symlink does not work here.
#
# This repo is public. Moom stores its license in the same plist as its
# layouts, so the snapshot is scrubbed of registration keys before writing.
set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/dotfiles}"
DEST="$DOTFILES_DIR/moom/Moom.plist"

# Flush Moom's in-memory prefs to disk before reading them.
osascript -e 'quit app "Moom"' 2>/dev/null || true
sleep 1

TMP="$(mktemp -t moom-export)"
trap 'rm -f "$TMP" "$TMP.plist"' EXIT
defaults export com.manytricks.Moom "$TMP.plist"

# Drop any top-level key that looks like licensing/identity, then write XML
# so the diff is reviewable in git.
python3 - "$TMP.plist" "$DEST" <<'PY'
import plistlib, re, sys

src, dest = sys.argv[1], sys.argv[2]
SENSITIVE = re.compile(r'licen|serial|registrat|purchase|receipt|e-?mail', re.I)

with open(src, 'rb') as f:
    data = plistlib.load(f)

stripped = [k for k in data if SENSITIVE.search(k)]
for k in stripped:
    del data[k]

with open(dest, 'wb') as f:
    plistlib.dump(data, f, fmt=plistlib.FMT_XML)

print(f"stripped: {', '.join(stripped)}" if stripped else "stripped: nothing matched")
PY

open -a Moom
echo "Exported Moom settings to $DEST"
echo "Review the diff before committing — this repo is public."
