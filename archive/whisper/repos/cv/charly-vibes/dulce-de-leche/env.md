

## Migrated from charly-vibes

# dulce-de-leche env

## Genesis adoption (v0.2.0+)

Uses these genesis v0.4.0 modules:
- guide (CliVerbosity progressive -v/-vv/-vvv, CliFormat auto-detect --json for pipes)
- cli (generate_completions, maybe_print_version_json)
- config (DdlConfig implementing ConfigFile trait)
- fixture (in tests/)
- aix (agents_block generation)
- envelope, doctor, status, suggestions, suite_linter (pre-existing)

## Important CLI behaviors

- Output format auto-detects: TTY → human, piped/redirected → JSON envelopes
  Use `--human` to force human output in non-TTY contexts
- Verbosity uses counts: `-v` = verbose, `-vv` = debug
- All commands support `--json` except `completions` (always plain shell text)
- `ddl scope` also supports `--json` (returns `{"ddl_dir": "...}"}`)
