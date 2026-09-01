

## Migrated from cv:charly-vibes

# vampiro — repo env / infra facts

## Publishing

- **10 crates, published in topological order** — cir → law → harness → rust-fe → seam → py/clj/jl-fe → lifecycle → vampiro
- **crates.io new-crate rate limit**: token-bucket pattern (~5 burst, then ~1 per 10-min refill). First publish of 10 new crates needs multiple rounds with ~10 min between each batch.
- **Self-healing publish** in release.yml: on 429, parses `Please try again after <RFC2822 date>`, sleeps until window clears + 30s buffer, retries (up to 6×).

## Cross-compilation

- **git2** needs `vendored-openssl` feature for cross-compilation (macOS, Linux-aarch64). Without it, `openssl-sys` fails to find system OpenSSL.
- Release workflow builds: Linux (x86_64 + aarch64), macOS (x86_64 + aarch64), Windows (x86_64).

## Workspace metadata

- All metadata hoisted to `[workspace.package]` in root Cargo.toml: license (Apache-2.0), repository, keywords, categories, rust-version.
- All 19 internal path deps use `{ path = "../...", version = "x.y.z" }` — version required for publishing.

## Tap repos

- Homebrew: `charly-vibes/homebrew-charly` → `Formula/vampiro.rb`
- Scoop: `charly-vibes/scoop-charly` → `bucket/vampiro.json`
- Requires `TAP_GITHUB_TOKEN` secret (PAT with repo scope to both tap repos).


## Migrated from charly

# vampiro — repo facts

## Release workflow

- Triggered by `git tag v* && git push origin v<tag>` — see `.github/workflows/release.yml`
- Publishes all 10 workspace crates to crates.io in topological order, then creates
  a GitHub Release with binaries + checksums, then updates `charly-vibes/homebrew-charly`
  and `charly-vibes/scoop-charly`
- Requires `CARGO_REGISTRY_TOKEN` (crates.io) and `TAP_GITHUB_TOKEN` (homebrew/scoop)
  repo secrets. Token rotation needs manual web actions (crates.io + GitHub PATs).
- Version lives in workspace `Cargo.toml` (`[workspace.package] version`); internal
  path deps in `crates/*/Cargo.toml` also carry explicit `version = "X.Y.Z"` that must
  be bumped in sync. `sed -i 's/version = "OLD"/version = "NEW"/g' crates/*/Cargo.toml`
- After a version bump: regenerate AIX artifacts via
  `cargo test -p vampiro --lib aix_regenerate_artifacts -- --ignored` and update
  help snapshots with `TRYCMD=overwrite cargo test -p vampiro --test cli_tests cli_snapshots`

## CLI language dispatch

- `crates/vampiro-cli/src/cli/mod.rs` — `SUPPORTED_EXTENSIONS` constant maps extensions
  to languages; `scan_files()` dispatches by extension to each frontend
- `.rs` → RustFrontend (with `to_visibility_facts`), `.py` → PythonFrontend,
  `.clj`/`.cljs` → ClojureFrontend, `.jl` → JuliaFrontend
- All frontends implement `extract_full(&self, source, path) -> ExtractionOutput`
- To add a language: add to `SUPPORTED_EXTENSIONS`, add dispatch branch, add dep to
  `crates/vampiro-cli/Cargo.toml` (production deps), add integration tests

## genesis v0.6.0 envelope API

- `Envelope::success(cli_version, kind, data, warnings, hints)` — `cli_version`
  is caller-supplied via `env!("CARGO_PKG_VERSION")`, NOT genesis's own version
- `CLI_VERSION` constant was removed in 0.6.0

## Snapshot store

- `SnapshotStore::snapshot_path()` validates commit SHAs are hex-only, 7–64 chars
  (`InvalidCommitSha` error) to prevent path traversal

## Config

- `Config` struct is currently empty (scan_threads removed — was never wired up)
- Doctor's `ConfigCheck` uses `Config::read()` for full schema validation
