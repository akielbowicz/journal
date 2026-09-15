

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

## Windows install-path gotchas (DDL-71i/DDL-2rb, smoke-verified 2026-09-15)

- LockFileEx byte-range locks (fs2 lock_exclusive) block EVERY other handle on
  Windows, including one in the same process — never reopen a file you hold a
  lock on; do all I/O through the locking handle (read_manifest_from /
  write_manifest_to in dot_ddl.rs). Deterministic os error 33, invisible on
  Unix. with_sharing_retry (exponential, 6 attempts) covers genuine AV locks
  on open/lock only.
- secrets.GITHUB_TOKEN is NOT auto-exposed as an env var in Actions steps —
  set `GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}` at job level for ddl's
  github_client() (DDL-2rb) to activate; otherwise shared-runner IPs exhaust
  the anonymous 60 req/hr quota and installs 403 intermittently.
- Workflow events from the default GITHUB_TOKEN do not trigger other
  workflows: release-published smoke never auto-fires for releases created by
  the release workflow — dispatch manually (ddl_version input) or give the
  release workflow a PAT.
- Expand-Archive requires a .zip extension; Git Bash's GNU tar cannot read
  zip. macOS tar.gz extraction drops the exec bit — chmod +x after untar.
