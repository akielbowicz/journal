# whisper repo env notes

## Release infrastructure (added 2026-09-15)

- Publishing is tag-triggered GHA, never manual: `git tag vX.Y.Z && git push --tags` → `.github/workflows/release.yml` (ported from `charly-vibes/dont`)
- Pipeline: cross-platform builds (linux/darwin amd64+arm64, windows) → GH Release with archives of all three bins (`turu`, `turututu`, `whisper`) + `checksums.txt` → `cargo publish --locked` (crate `whisper-vibes`) → auto-update `homebrew-charly` `Formula/turu.rb` and `scoop-charly` `bucket/turu.json` via `scripts/update-{homebrew,scoop}.py`
- Repo secrets (set from existing configs, do not re-login or tokens get revoked): `CARGO_REGISTRY_TOKEN` lives in `~/.cargo/credentials.toml`; `TAP_GITHUB_TOKEN` is the existing `GH_TOKEN` (broad scope — swap for fine-grained PAT if tightening)

## Release workflow gotchas (hit in practice on v0.3.0)

- Darwin staging must map artifact names to cargo target triples: `darwin_amd64` → `x86_64-apple-darwin`, `darwin_arm64` → `aarch64-apple-darwin` (not `target/darwin_amd64-apple-darwin`)
- `bins/` and `dist/` must stay gitignored — untracked packaging artifacts make `cargo publish` abort with the dirty-workdir check (exit 101)
- Failed releases leave the GH Release behind: delete (`gh release delete <tag> --yes`) before rerunning, or "release with same tag already exists" fails the rerun

## CI (added 2026-09-16)

- `ci.yml` runs `just ci` (genesis parity pattern): fmt-check + clippy `-D warnings` + test + `build-locked`; the locked build catches Cargo.lock drift before release.yml's `cargo publish --locked` trips on it
- Justfile recipes `ci` and `build-locked` are the local equivalents — if CI fails, reproduce with `just ci`

## Known issues

- No `ci.yml` yet — `--locked` builds aren't verified before tags (beads: `whisper-bez`)
- Sibling repo `dont` v0.3.0 release failed at macOS/Windows build stage; same fixes likely apply there
- 2026-09-15T17:45:00Z [id:383eaa0203a73e4bc524b3fd21c01d432386ab09de8969439a84639202b58101] (#lifecycle) v0.4.0 shipped the full memory lifecycle (record→manage→distill→recall→share): structured idempotent entries (sha2 id over scope-key+second-precision-UTC+text, O_APPEND fast path, full rewrite only for --supersedes), turu recall (recency-ranked, whole-entry byte budget, all = precedence composition), turu distill (two-phase begin/commit with immutable revisions + drift guard), turu bundle (deterministic packs). Rule-of-5 reviewed x3; strategic fork (bundle transport) = beads dont.. ticket in this repo's tracker
- 2026-09-15T17:45:00Z [id:47d6f79b186c9ede1ac8e57c57607e69ca635108de6f39b4097c96a72f1667b1] (#rust) time-crate gotcha: format_description with literal T/Z works for FORMATTING but cannot PARSE — for parsing use time::format_description::well_known::Rfc3339 then re-format with the canonical description and compare (also used to validate entry lines and TURU_NOW); cargo build --locked fails after a Cargo.toml version bump until Cargo.lock is regenerated (cargo build without --locked)
