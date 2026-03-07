#!/usr/bin/env bash
# install.sh — Install claude-dev-team profiles and CLI
# Usage: bash install.sh
#
# What this does:
#   1. Copies team member profiles to ~/.claude/team/
#   2. Installs the claude-team CLI to ~/.local/bin/
#   3. Checks that ~/.local/bin is on your PATH

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROFILES_SRC="$REPO_DIR/profiles"
PROFILES_DST="$HOME/.claude/team"
BIN_SRC="$REPO_DIR/bin/claude-team"
BIN_DST="$HOME/.local/bin/claude-team"

bold()  { printf '\033[1m%s\033[0m' "$*"; }
green() { printf '\033[32m%s\033[0m' "$*"; }
yellow(){ printf '\033[33m%s\033[0m' "$*"; }
dim()   { printf '\033[2m%s\033[0m' "$*"; }

echo ""
echo "$(bold "claude-dev-team installer")"
echo "────────────────────────────────────"
echo ""

# 1. Install profiles
echo "Installing profiles to $PROFILES_DST ..."
mkdir -p "$PROFILES_DST"
cp "$PROFILES_SRC"/*.md "$PROFILES_DST/"
echo "$(green "✓") Profiles installed:"
for f in "$PROFILES_DST"/*.md; do
  echo "    $(dim "$f")"
done
echo ""

# 2. Install CLI
echo "Installing CLI to $BIN_DST ..."
mkdir -p "$(dirname "$BIN_DST")"
cp "$BIN_SRC" "$BIN_DST"
chmod +x "$BIN_DST"
echo "$(green "✓") CLI installed: $(dim "$BIN_DST")"
echo ""

# 3. PATH check
if echo "$PATH" | grep -q "$HOME/.local/bin"; then
  echo "$(green "✓") ~/.local/bin is already on your PATH."
else
  echo "$(yellow "!") ~/.local/bin is not on your PATH."
  echo ""
  echo "  Add it by appending one of the following to your shell config:"
  echo ""
  echo "    $(dim "# ~/.zshrc or ~/.bashrc")"
  echo "    export PATH=\"\$HOME/.local/bin:\$PATH\""
  echo ""
  echo "  Then reload your shell:"
  echo "    source ~/.zshrc   $(dim "# or ~/.bashrc")"
fi

echo ""
echo "$(bold "Done!") Your Claude dev team is ready."
echo ""
echo "Quick start:"
echo "  claude-team list          $(dim "# see your team")"
echo "  claude-team use robin     $(dim "# activate Robin (Testing)")"
echo "  claude-team use akira     $(dim "# activate Akira (Backend)")"
echo "  claude-team use sasha     $(dim "# activate Sasha (Frontend)")"
echo "  claude-team reset         $(dim "# return to default Claude")"
echo ""
echo "$(dim "Start a new Claude Code session after activating a team member.")"
echo ""
