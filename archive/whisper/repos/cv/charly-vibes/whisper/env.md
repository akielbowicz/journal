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
