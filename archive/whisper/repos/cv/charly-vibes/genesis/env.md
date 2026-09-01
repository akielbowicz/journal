

## Migrated from genesis


## Doctor framework (genesis::doctor)

- `DoctorCheck` trait: run() + optional auto_fixable()/fix(). Has `lint_to_doctor()` adapter for existing LintCheck impls.
- `DoctorRunner`: orchestrates checks with `run(repo_root, fix: bool)` producing `DoctorReport`. Stores tool name (default "doctor", set via `with_tool_name()`).
- `DoctorReport`: structured result with `CheckEntry` (pass/warn/fail), `DoctorSummary`, `to_envelope()` for JSON.
- 33 tests covering all paths.
- File: `src/doctor.rs`

## Feedback dispatch helper (genesis::feedback)

- `FeedbackArgs`: kind, dry_run, from_last_error
- `handle_feedback(args, tool_name, tool_version, repo, project_root)`: validates kind with typo suggestions, supports --from-last-error (scratch) or piped stdin, gathers context, redacts, creates gh issue.
- 8 tests covering all paths.
- File: `src/feedback.rs`

## CLI helpers (genesis::cli)

- `generate_completions(cmd, shell)`: one-liner for clap_complete.
- `maybe_print_version_json(name, version)`: pre-parse --version --json before clap.
- 5 tests.
- File: `src/cli.rs`

## Status dashboard (genesis::status)

- `StatusContributor` trait: name() + status(repo_root) -> StatusSection.
- `StatusBuilder`: register contributors, build() -> MultiToolStatus.
- `DoctorStatusBridge`: wraps any DoctorRunner as a StatusContributor automatically.
- `StatusSection`, `StatusItem`, `StatusLevel` (Healthy/Warning/Error).
- `MultiToolStatus` with summary() and to_envelope().
- 26 tests.
- File: `src/status.rs`

## Init scaffolding (genesis::scaffold)

- `Scaffold` builder: .dir(), .default_config(), .gitignore_entry(), .managed_block(), .agent_command_file()
- Returns ScaffoldResult with created/existed paths.
- 11 tests.
- File: `src/scaffold.rs`

## CLI version ownership contract (v0.6.0+)

- `CLI_VERSION` constant **removed** — no longer available from `genesis::envelope::CLI_VERSION`.
- `Envelope::success(cli_version, kind, data, warnings, hints)` — first arg is caller's own version.
- `Envelope::error(cli_version, err, warnings)` — same pattern.
- `Envelope::success_with_tx(cli_version, kind, data, warnings, hints, tx)` — same.
- `GuideOutput::to_envelope(&self, cli_version)` and `::emit(&self, cli_version, ...)` require it.
- `DoctorReport::to_envelope(&self, cli_version)` and `StatusReport::to_envelope(&self, cli_version)` require it.
- Migration: pass `env!("CARGO_PKG_VERSION")` from the downstream tool's own crate.
- Doc: `docs/reference/modules.md` has full migration path.

## Adoption track

- 5 genesis tickets closed, 7 adoption tickets created across repos.
- CI publishes on tag push.
- v0.6.0 adoption tickets: wai-47m0, dont-88m8, espectacular-9ys, testaruda-2wwn, vampiro-aq0, DDL-iqv


## Migrated from charly

# genesis-vibes (n) — env & conventions

## Version history
- v0.4.0 — CliVerbosity, CliFormat (TTY auto-detect), discovery module, Output::emit(), Guide::run_formatted()
- v0.5.0 — Full AIX generation module (aix.rs), 14 modules stable

## Key conventions

### Verbosity mapping (from_verbose_count)
- clap `-v` count 0 → `Verbosity::Normal` (default, not Quiet)
- clap `-v` count 1 → `Verbosity::Verbose`
- clap `-v` count 2+ → `Verbosity::Debug`
- `-q`/`--quiet` → `Verbosity::Quiet` (overrides -v)
- Use `CliVerbosity` struct (`#[command(flatten)]`) rather than raw `verbose: u8`

### Output format (CliFormat)
- `--json` → Json; `--human` → Human
- Neither set → auto-detect: `Human` if stdout is a TTY, `Json` otherwise
- Agents and pipes always get JSON by default
- Use `Output::emit(format, ...)` instead of `Output::print(...)` for format-aware output
- Use `Guide::run_formatted(format, f)` instead of `Guide::run(f)` when format matters

### Tool discovery
- `.genesis/tools.toml` manifest at project root
- Each tool registers during init: `genesis::discovery::register(project, name, desc, type, path)`
- Tools scan via: `genesis::discovery::scan(project)` → `Vec<DetectedTool>`
- Detector types: `"directory"` or `"file"`

### AIX generation (v0.5.0+)
- `genesis::aix::generate_llms_txt(meta, modules)` — standardized `llms.txt` from ProjectMeta + ModuleEntry
- `genesis::aix::generate_llm_txt(title, desc, &[LlmSection])` — composable `llm.txt` from typed sections
- Section helpers: `modules_section()`, `commands_section()`, `genesis_adoption_section()`, `authorship_section()`, `links_section(heading, &[(label, url)])`
- `quick_start_section` was REMOVED in v0.5.0 — use `links_section("Quick start", &[...])` instead
- `LlmSection` is `#[non_exhaustive]` — match with a wildcard arm
- Self-hosting: `just aix-gen` regenerates files; `just ai-check` in CI ensures no drift
- Files are pinned in `Cargo.toml`'s `[package] include` list

### Scratch tests
- Always use tempfile::TempDir or unique tool names (scoped by PID) in scratch tests
- Avoid shared `~/.cache/<tool>/errors.jsonl` paths between parallel tests


## Migrated from charly-vibes

# Genesis Adoption — Release Status (2026-07-28)

## Published to crates.io
- **testaruda**: v0.2.4 ✅ (was v0.1.0)
- **espectacular**: v0.3.0 ✅ (was v0.2.0)
- **dont** (dont-cli): v0.2.2 ✅ (already synced)
- **pretender**: v0.3.1 ✅ (already synced)

## Not yet published / pending
- **wai** (wai-cli): current stable 2026.5.3, HEAD 2026.7.16 — CI release in progress (build.rs include fix)
- **vampiro**: v0.1.0 — new tool, never published
- **crua / livin**: spec stage only, no crate

## CI pipeline issues (all tools)
All three release.yml workflows had the same `--locked` + `cargo publish dirty` bugs.
Fixed across testaruda, espectacular, and wai repos.
The release workflow has NEVER succeeded before this round.

## Doc-drift guard system (added 2026-09-01)

- Onboarding docs are drift-guarded three ways, all failing `cargo test`: `tests/doc_examples.rs` (compilable mirrors of mdBook snippets), `tests/doc_sync.rs` (forbidden-pattern scan + snippet-map coverage + version-pin tracking), `just doc-test` runs both.
- The forbidden-API blocklist lives in `docs/explanation/removed-apis.md` (maintained markdown table); `doc_sync.rs` derives patterns from it. Add a row there whenever a public API is removed/renamed. The anchor page is excluded from the scan (it quotes the patterns).
- Version pins in README.md + docs/getting-started.md are tracked against Cargo.toml — bumping the manifest version requires updating both files in the same commit or CI fails.
- Beads tracker has no dolt remote; `.beads/issues.jsonl` git export is the sync mechanism (commit it alongside ticket changes).
- `bd create --set-metadata 'files=[...]'` errors out (help text); create first, then `bd update --set-metadata`. Setting metadata on `bd update` works fine.
