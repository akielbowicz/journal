

## Migrated from pretender

# pretender repo facts

## genesis integration
- Depends on genesis crate (git, tag v0.2.0 as of 2026-07-28)
- Cargo.toml is at `pretender/Cargo.toml` (workspace member), not root
- --json output goes through genesis::envelope::Envelope
- Config: `Config` implements `genesis::config::ConfigFile`; load_config + doctor
  delegate read/parse/validate to `ConfigStore` via `config::build_registry()`
- CLI: `main()` uses `genesis::guide::Guide::builder(...)`; typo detection via
  `guide.registry()`; error path via `guide.error_sink()`

## execute table: coverage_cmd / mutation_cmd are INERT (2026-07-28)
- The `[execute]` config table defines `enabled`, `coverage_cmd`, and
  `mutation_cmd` fields in the struct, but they are NEVER read or executed.
  Neither `main.rs` nor `mutation.rs` references `config.execute.*`.
- `mutation` command dispatches hardcoded per-language: `cargo mutants` for
  Rust, `mutmut` for Python, `stryker` for JS/TS. No config-driven path.
- `coverage` is a reserved command (not implemented).
- Any future work adding execute-mode MUST author the full run contract
  (cwd, env, timeout, exit-code handling) from scratch — there is no prior
  pattern to reuse.

## genesis::guide ErrorSink gotcha (v0.2.0)
- ErrorSink's built-in scratch writes `argv = vec![tool_name]`, NOT the full
  command line. For `feedback --from-last-error` to surface the failing
  command, disable the sink's scratch (`.with_scratch(false)`) and write a
  richer `ErrorRecord` with `argv: std::env::args().collect()` yourself.

## genesis::config empty-file gotcha (v0.2.0)
- `ConfigFile::read_from` rejects empty/whitespace-only files as ParseError.
  pretender's `load_config` short-circuits zero-byte `pretender.toml` to
  `Config::default()` (v0.1.0 tolerance) for `check`/`complexity`; `doctor`
  intentionally stays strict and flags empty files as invalid.

## dead deps removed (2026-07-28)
- `miette` and `thiserror` are no longer direct deps — they were only used by
  the removed `ConfigError`. They remain as transitive deps via genesis/serde-sarif.

## CLI commands (PRETENDER_COMMANDS const)
check, complexity, report, doctor, init, duplication, mutation,
hooks, ci, plugins, explain, feedback

## Typo detection
- Uses genesis::suggestions::SuggestionEngine
- Unknown subcommands show "Did you mean 'X'?" via genesis
- Typo handler exits with code 2 directly (bypasses error scratch)

## Error footer
- Non-zero exits with no Fix suggestion print "Feedback: pretender feedback bug --from-last-error"
- Error scratch written to $XDG_CACHE_HOME/pretender/errors.jsonl

## Managed blocks
- `pretender init --non-interactive` injects WAI/OPENSPEC/DONT managed blocks into AGENTS.md
- Uses genesis::managed_block::BlockInjector
