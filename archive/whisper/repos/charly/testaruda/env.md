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
