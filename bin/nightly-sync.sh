#!/usr/bin/env bash
# journal nightly-sync — commit + push the journal repo (incl. ~/.whisper archive)
# Invoked by the journal-nightly systemd user timer. Also runnable by hand.
#
# Design notes:
# - fail-closed: gitleaks gates run via lefthook on commit AND push; if a gate
#   rejects, the script exits non-zero and nothing is pushed (never bypass).
# - idempotent: no changes → no commit, push still attempted (catches up).
# - log: ~/.local/state/journal-nightly.log (rotated at ~256 KB)

set -euo pipefail

JOURNAL="${JOURNAL:-$HOME/para/areas/dev/gh/ak/journal}"
LOG="$HOME/.local/state/journal-nightly.log"

log() { printf '%s %s\n' "$(date '+%F %T')" "$*" >>"$LOG"; }

mkdir -p "$(dirname "$LOG")"
# crude rotation: keep it small
if [ -f "$LOG" ] && [ "$(stat -c%s "$LOG")" -gt 262144 ]; then
  tail -n 400 "$LOG" > "$LOG.tmp" && mv "$LOG.tmp" "$LOG"
fi

cd "$JOURNAL"

# Don't fight an in-flight agent session (rebase/merge in progress, etc.)
if [ -d .git/rebase-merge ] || [ -d .git/rebase-apply ] || git quilt 2>/dev/null; then
  log "SKIP: git operation in progress"
  exit 0
fi

# Everything except gitignored paths (_site/, private zones, local whisper repos)
git add -A

if ! git diff --cached --quiet; then
  msg="autosync: nightly snapshot $(date '+%F %H:%M')"
  if git commit -q -m "$msg"; then
    log "commit: $msg"
  else
    # most likely a hook gate (gitleaks) rejected — leave tree untouched
    log "FAIL: commit rejected (hook gate) — investigate: cd $JOURNAL && git status"
    exit 1
  fi
else
  log "no changes to commit"
  git reset -q  # drop the no-op staging
fi

if git push origin HEAD 2>>"$LOG"; then
  log "push: ok ($(git rev-parse --short HEAD))"
else
  log "FAIL: push failed — next run will retry (non-fast-forward needs manual attention)"
  exit 1
fi
