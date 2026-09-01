
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
