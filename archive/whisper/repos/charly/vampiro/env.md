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
