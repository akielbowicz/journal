# Whisper archive

This directory **is** `~/.whisper/` — a symlink (`~/.whisper` → `archive/whisper/`).
The incitaciones skills (`/next` per repo/branch session snapshots, `/close` env
notes, `rules.md` universal agent rules) write here directly.

Run `mise run whisper-sync` to commit + push new entries (they land as untracked
files until committed).

> **Never run `git clean -fd` in the journal repo** — unpublished whisper notes
> are untracked files in the working tree and would be destroyed irreversibly.
