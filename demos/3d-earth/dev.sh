#!/usr/bin/env bash
# ---------------------------------------------------------------------------
# Lokaler Dev-Server für das 3D-Erdmodell.
#   * holt automatisch neue Stände vom Feature-Branch (alle 20 s)
#   * serviert diesen Ordner unter http://localhost:8000
#
# Benutzung:  ./dev.sh   (im Ordner demos/3d-earth)
# Beenden:    Strg + C
# ---------------------------------------------------------------------------
set -euo pipefail

BRANCH="claude/3d-earth-interactive-model-vx3d98"
PORT="${1:-8000}"
DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$DIR"

echo "Branch:  $BRANCH"
echo "Ordner:  $DIR"

# Auto-Pull im Hintergrund
(
  while true; do
    git pull --quiet --ff-only origin "$BRANCH" 2>/dev/null && \
      echo "[auto-pull] aktualisiert $(date '+%H:%M:%S')" || true
    sleep 20
  done
) &
PULL_PID=$!
trap 'kill "$PULL_PID" 2>/dev/null || true' EXIT

echo ""
echo "  →  http://localhost:${PORT}     (Strg+C zum Beenden)"
echo ""

# Statischer Server: python3, sonst Fallback auf 'npx serve'
if command -v python3 >/dev/null 2>&1; then
  python3 -m http.server "$PORT"
elif command -v npx >/dev/null 2>&1; then
  npx --yes serve -l "$PORT" .
else
  echo "Weder python3 noch npx gefunden – bitte einen statischen Server installieren." >&2
  exit 1
fi
