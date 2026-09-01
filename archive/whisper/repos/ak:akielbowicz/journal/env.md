## 2026-09-01: Journal repo arrangement (single record repo)

- Canonical repo: `~/para/areas/dev/gh/ak/journal` (public, published at https://ak.saxa.xyz/journal/ via pages.yml on push to main)
- Path chain: `$JORNAL` → `~/para/areas/jornal` (symlink) → repo; `$JOURNAL_PATH` derives from `$JORNAL`; `$JOURNAL_LOG_SUBDIR=areas/log`; also set in `.mise.toml` `[env]`
- `~/.whisper` is a symlink to `archive/whisper/` — incitaciones `/next` + `/close` write here directly; new notes are untracked files until `mise run whisper-sync` commits+pushes
- Skills: `close`/`next`/`park`/`renew` come from incitaciones (npm; pi project dep in `.pi/settings.json`); 8 journal-only skills (archive, capture, jlog, migrate, morning, standup, weekly, wrap-up) live in `resources/skills/`, symlinked into `~/.agents/skills/` — deprecated docs + upstream candidates
- NEVER run `git clean -fd` in this repo (unpublished whisper notes would be destroyed)
- `mise run doctor` validates env vars, symlinks, skills, and site buildability
