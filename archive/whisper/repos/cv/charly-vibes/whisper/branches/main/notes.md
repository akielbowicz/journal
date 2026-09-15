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

### 2026-09-16 16:0x — turu consolidate shipped (whisper-ae0 closed)
- Implemented `workspace::consolidate()` (TDD, 5 new tests): wholesale rename when canonical dir absent; per-entry move without conflict, else text merge by extending with trimmed-line dedup; legacy dirs removed after
- New `Consolidate` subcommand emits moved/merged manifest + hint `turu doctor — the legacy-keys check must pass`; doctor fix hint now real
- **Safety fix folded in:** `legacy_variants` colon rule matched any dir with a colon — real false positive in this very workspace (`ak:akielbowicz`, a multi-repo legacy root with other repos' knowledge). Detection now requires the post-colon path to equal the bare repo name; regression test added. Detection that warns can be loose; detection that moves data cannot
- End-to-end verified against a synthetic workspace: check → consolidate → doctor pass
- Cargo quirk hit twice: `cargo build` claims fresh but target/debug/turu is stale after src changes (hardlinked bins); `cargo clean -p whisper-vibes` before smoke-testing binaries
- Committed `e217adf`, pushed; both whisper tickets now closed
- **Next:** optionally port `bins/`/`dist/` gitignore + darwin-triple fixes to `dont`'s release workflow; consider version bump v0.4.0 (consolidate + ci.yml) via tag push

### 2026-09-15 15:57 — snap
- Shipped both whisper tickets: `whisper-bez` (ci.yml + `just ci` with build-locked, commit `1664c56`) and `whisper-ae0` (`turu consolidate` — move/merge migration with line-dedup, commit `e217adf`)
- Folded-in safety fix: `legacy_variants` colon rule tightened (colon dir must end in bare repo name) after finding real false positive `ak:akielbowicz` in ~/.whisper holding other repos' knowledge
- All gates green, both repos pushed, tickets closed, knowledge routed
- **Next:** port `bins/`/`dist/` gitignore + darwin-triple fixes to `dont`'s failed release workflow; consider tagging v0.4.0 (consolidate + CI) to exercise release.yml end-to-end
