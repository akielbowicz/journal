### 2026-09-05 17:51 — snap
- Scaffolded whisper-vibes v0.3.0 end-to-end: deterministic workspace CLI (key/resolve/append/init/status/check), turu rename (aliases turututu+whisper), doctor with fix hints, turu sync managed block in AGENTS.md, skill_pack shipping the whisper skill (11 files, content-hashed)
- Incitaciones whisper skill converted to thin pointer; DDL registration filed in dulce-de-leche; dogfooded .turu/skills + AGENTS.md block in this repo
- All pushed: whisper (f090323, 0948e2a), incitaciones (395a15e), dulce-de-leche (41a51d3)
- **Next:** implement 'turu consolidate' (detection already in doctor); then DDL/homebrew registration; verify incitaciones npx skill install picks up the thin pointer

### 2026-09-16 — ci.yml shipped (whisper-bez closed)
- Added `.github/workflows/ci.yml` on push/PR to main + workflow_dispatch; runs `just ci` for local/CI parity (genesis pattern)
- Justfile gained `ci: fmt-check lint test build-locked` and `build-locked` — the `--locked` build verifies Cargo.lock sync before release.yml's `cargo publish --locked` would trip on it
- `just ci` green locally (14 tests, clippy -D warnings); committed `1664c56`, pushed, ticket closed
- **Next:** `whisper-ae0` — implement `turu consolidate` (legacy repo-key dir migration; detection already in doctor); optionally port `bins/`/`dist/` gitignore + darwin-triple fixes to `dont`'s release workflow
