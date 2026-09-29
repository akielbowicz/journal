

## Migrated from testaruda

# testaruda genesis adoption (v0.3.1+)

All 14 genesis v0.4.0 modules are adopted. 13 are in active use; `aix` is a
stub upstream (TODO: implement full AIX generation once design is finalized).

## Boundary rule

If testaruda needs functionality NOT in genesis and NOT duplicated in another
tool, keep it local. If it IS duplicated elsewhere, the pattern belongs in
genesis — file a genesis change first, then adopt.

## Usage per module

| Module | Usage |
|--------|-------|
| cli | generate_completions, maybe_print_version_json |
| config | ConfigFile, ConfigRegistry, ConfigStore |
| discovery | .genesis/tools.toml registration |
| doctor | DoctorCheck, DoctorReport, DoctorRunner |
| envelope | Envelope, EnvelopeKind, ErrorResult |
| feedback | handle_feedback, scratch records, gh issues |
| fixture | Fixture::new().with_file().build() in test suites |
| guide | Guide builder, CliVerbosity, CliFormat |
| managed_block | BlockInjector, BlockRegistry, BlockDef |
| scaffold | Scaffold builder for init |
| status | StatusBuilder for cross-tool health |
| suggestions | SuggestionEngine + CommandRegistry for typos |
| suite_linter | LintResult, Severity |


## Migrated from charly

# testaruda environment notes

## Schema migrations
- SCHEMA_VERSION is in src/store.rs, increment for breaking schema changes
- Migrations use (from, to) pattern in apply_migration()
- Partial unique indexes fix SQLite NULL uniqueness: `WHERE symbol IS NULL` / `WHERE symbol IS NOT NULL`
- CREATE TABLE IF NOT EXISTS in migration to handle edge cases from test-created old schemas

## Git porcelain parsing
- Rename lines in git status --porcelain v1: `R  oldpath -> newpath`
- Extract via `find(" -> ")` and take text after the arrow

## CI exit codes
- JSON mode (emit_json_plan) must call std::process::exit(code) to match human mode (emit_human_output)
- By default emit_json_plan returned Ok(()) even for non-zero outcome codes

## genesis v0.6.0 envelope API
- Envelope::success(cli_version, kind, data, warnings, hints) — 5 args
- Envelope::error(cli_version, err, warnings) — 3 args
- report.to_envelope(cli_version) — 1 arg
- Use env!("CARGO_PKG_VERSION") for the cli_version parameter

## Known bugs / conventions (2026-09-29)
- `testaruda feedback` truncates multi-line stdin descriptions to the first line (silent data loss; `--dry-run` shares the bug). Bug filed: charly-vibes/testaruda#27. Until fixed, file feedback issues via plain `gh issue create --body-file`.
- Feature request for an `exec` subcommand (select→run→ingest→calibrate loop) + uncalibrated-store warning: testaruda#26.
- 2026-09-29T16:38:35Z [id:b1c64edf3242bd2e7d79fd4bfe7c59f06e748bc827470a032acf8186c6440cf6] (#feedback) UPDATE (2026-09-29, PR #28/#29 session): gh-27 feedback truncation is FIXED — genesis-vibes 0.8.1 reads full stdin (0.7 used read_line) and partitions multi-line input (first line → title, rest → Description).  with piped multi-line input is now safe; the old 'use gh issue create --body-file' workaround no longer applies. Regression pinned in tests/cli.rs::feedback_multiline_stdin_is_not_truncated. Also:  (gh-26) now completes select→run→ingest→calibrate; uncalibrated-store advisory fires when run history is empty.

## Release workflow order (release.yml, 2026-09-29)
- Tag push `v*` → 3 platform builds → publish job order: GitHub release → crates.io publish → homebrew tap → scoop. The ehse tap/scoop auth failure does NOT block release publishing — package managers just fall behind until TAP_GITHUB_TOKEN (PAT with contents:write on homebrew-charly + scoop-charly) is set
- Release binaries only bundle testaruda/adapter-rust/adapter-python — adapter-clojure/typescript are source-installed via `cargo install --path adapter-<x>`, so adapter fixes reach users via repo installs, not release assets
