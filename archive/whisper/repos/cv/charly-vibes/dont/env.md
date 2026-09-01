

## Migrated from dont

# dont repo environment & operational knowledge

## Git hooks
- Git hooks managed by **lefthook** (v1.13.6), not prek
- lefthook.yml in repo root has pre-commit and pre-push hooks
- To bypass hooks: `git commit --no-verify` or `git push --no-verify`

## ah check (espectacular)
- Spec contracts live in `.espectacular/` as `.toml` files
- `[tests]` section format: `cargo = [{flags = "test_function_name"}]`
- Spec `.md` files are in `openspec/specs/` (canonical source)
- `ah doctor` collisions happen when same slug exists in both `openspec/specs/` and `.espectacular/`
- Fix: `ah doctor --enable cargo` to configure runner; remove duplicate slug dirs from `openspec/changes/` changes

## Config
- `.espectacular/config.toml` — tool_version, runners, paths
- `_typos.toml` — extend-words for typos false positives

## ErrorSink scratch (genesis::guide adoption, dont-rxf6)
- `emit_error_no_exit` writes an `ErrorRecord` to `$XDG_CACHE_HOME/dont/errors.jsonl` on every non-zero exit (the genesis ErrorSink scratch contract). `dont feedback bug --from-last-error` reads it.
- **Tests must redirect `XDG_CACHE_HOME`** to an isolated temp dir, or parallel test runs collide on the shared scratch file and pollute `~/.cache/dont/`. `tests/common/mod.rs::dont()` and `tests/dt_alias.rs::dt()` set it to `std::env::temp_dir().join("dont-test-cache")`; tests asserting scratch contents use a per-test `TempDir`.

## charly-vibes git deps & cargo fetching
- The global git config rewrites `https://github.com/charly-vibes/*` → `git@cv:charly-vibes/*` (SSH alias `cv`). Cargo's libgit2 cannot resolve the `cv` host → git-tag deps fail with "failed to resolve address for cv".
- Workaround: `CARGO_NET_GIT_FETCH_WITH_CLI=true cargo build` (uses system git, which respects SSH config). Moot for repos that consume the published `genesis-vibes` crate instead of the git dep.

## CozoDB WASM build (validated 2026-07-28)
- The `cozo` crate's **in-memory engine (`DbInstance::new("mem", "", "")`) is NOT feature-gated** — it compiles into core cozo with `default-features=false`. Only `sqlite`/`rocksdb`/`sled`/`tikv` are gated. Source: `cozo/src/lib.rs:138`.
- WASM build recipe (verified, 17s clean check): `cozo = { default-features=false, features=["wasm"] }` + `getrandom = { version="0.2", features=["js"] }`. The `wasm` feature enables `uuid/js` + `js-sys`; `getrandom` js is the only extra fix needed (it enters via `rand` used by cozo core).
- **Cozo `backup_db` / `restore_backup` are unusable in WASM** — they require `storage-sqlite` + a filesystem (`impl AsRef<Path>`, `cozo/src/runtime/db.rs:609,627`). For a portable snapshot, dump `*datoms` rows and rehydrate via `put_datoms` instead.

## CliFormat auto-detect (v0.3.0+)
- `genesis::guide::CliFormat` auto-detects output format: TTY → human, pipe/redirect/agent → JSON.
- **This is a change from v0.2.x** where `--json` was required for JSON output. Now agents/CI get JSON by default.
- Tests expecting human output must pass `--human` explicitly, otherwise `assert_cmd` pipes stdout → auto-detect produces JSON.
- `--json` and `--human` flags still override auto-detect; `--json` takes precedence when both are set.
- Quiet mode (`-q`/`--quiet`) suppresses confirmatory output but still emits JSON envelopes (JSON = data, not confirmatory).
- `run_script_str(payload, params, immutable: bool)` — third arg is **immutable** (not mutable). `query_rows` passes `true` (read-only); `run` passes `false` (mutable). Cozo rejects mutable ops in immutable mode (engine-enforced, no token-scanning needed).
- Cozo mutating vocabulary (for spec/scenario wording): `:put`, `:rm`, `:delete`, `:create`, `:replace` (grep `cozo/src/data/program.rs`).
- `dont` record types `ClaimRecord`/`TermRecord`/`EventRecord`/`CurieResolution`/`ImportedTermRecord` do **not** derive `Serialize` (`store.rs:99,107`+). The CLI hand-builds JSON via `build_claim_view` (`main.rs:2106`), which also takes a live `&Store`.
- The actual `Envelope` struct has 9 fields (`envelope.rs:83`): `ok`, `envelope_version`, `cli_version`, `envelope_kind`, `data`, `warnings`, `hints`, `ephemeral`, `meta` — not 5.
- `put_datoms` is private (`store.rs:1624`); a WASM FFI reusing it must live in-crate (feature-gated `src/wasm.rs`) or add a public `import_datoms` wrapper.


## Migrated from charly-vibes

# dont — genesis adoption

## Architecture

- **envelope**: Re-exports shared types from `genesis::envelope` (Warning, ErrorResult, Meta, etc.)
  - Keeps local `EnvelopeKind` (too many dont-specific variants to generalize)
  - Keeps `ENVELOPE_VERSION = "0.2"` (genesis uses "0.1")
  - `current_author()` is private in genesis — local `CURRENT_AUTHOR` OnceLock duplicates it
  - `set_author` wrapper syncs both copies
- **managed_block**: Sources `BlockDef`, `BlockRegistry`, `BlockInjector` from `genesis::managed_block`
  - Read operations use `BlockInjector::read_block`
  - Write operations use local `managed_region_bounds()` + string replacement (dont passes pre-rendered blocks)
- **suggestions**: `CommandRegistry` + `SuggestionEngine` from `genesis::suggestions`
  - Wired into `try_parse()` fallback for clap errors
  - Wired into `emit_error_no_exit` footer for non-clap unknown-command errors
- **feedback**: `gh::create_issue` + `scratch::read_last_error` from `genesis::feedback`
  - `dont feedback [bug|feature|question] [--dry-run] [--from-last-error]`
  - Default repo from `CARGO_PKG_REPOSITORY`
  - Dry-run: human mode prints body + gh command; JSON mode prints `{"body", "gh_command", "kind"}`

## Key Issues

- `current_author()` is private in genesis — needs to be made public before local copy can be removed
- `emit_error_no_exit` doesn't write to error scratch — `--from-last-error` won't find errors unless genesis handlers write first
## mine-claims script
- Located at `scripts/mine-claims` in the dont repo
- Mines claims from: git commit bodies, README Key Features, CHANGELOG Added, docs/src/status.md, whisper notes
- Usage: `mine-claims [--dry-run] [--force] [repo-path]`
- Requires `dont init` first; `dont` must be on PATH
- `--dry-run` previews claims without registering
- `--force` bypasses duplicate detection
- Whisper claims use `dont conclude` (unverified) since they're external to the repo
- Sanitizes multi-byte chars (→ → ->, — → --), strips leading dashes

## Unicode fix (dont-edoc)
- `dont list` panicked on multi-byte UTF-8 truncation (src/main.rs:1539, 1702)
- Fixed with `char_safe_truncate()` using `char_indices()` to find valid char boundaries
- Install fix: `cd dont && cargo install --path .`

## Gate wiring pattern
- Add `dont-check` recipe to justfile: `dont-check:\n    dont check`
- Wire into pre-push in lefthook.yml: `dont-check:\n  run: just dont-check`
- Update .gitignore: replace `.dont/` with negation pattern to track db.cozo

## 2026-08-05: Pre-existing tickets discovered

When creating new bug tickets, always run `bd list --status=open` first to check for existing tickets. The following pre-existing tickets were found after I created duplicates:
- dont-tdx4 (dont lock cross-vocab guard) — duplicate: dont-7afx
- dont-12cp (dont suggest-term) — duplicate: dont-22vn
- dont-dbmi (dont check --lock-readiness) — duplicate: dont-zvlu
- fotos-dn5/hko/a1h (wire toolbar actions) — duplicate: fotos-xzl
- fotos-c01 (fix MCP resources) — duplicate: fotos-1qu
