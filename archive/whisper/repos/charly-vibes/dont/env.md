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
