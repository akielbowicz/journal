### 2026-07-31 09:17 — snap

- Implemented 8 new deterministic code-quality checks across the pretender CLI: coupling metrics (Ce, Ca, CBO, LCOM-HS, cycle detection), mock-overuse detection, void-mutator check, mutable-state ratio, primitive-obsession (bool clusters + domain params), unwrap-density, inheritance-depth, and lazy-test-cluster detection
- All 254 tests pass (161 unit + 86 integration + 7 compile), 0 failures
- Key architectural decisions: per-language pattern registries in `mock_detector.rs`, `mutability_metrics.rs`, `error_metrics.rs`; shared `CONVENTIONS.md` for rule IDs and naming; all checks default to 0/disabled; generated/vendor files excluded
- **Next:** Push to remote, then either start on the pre-existing `add-test-duration-check` tickets (P2, 6 open sub-tickets) or the `adopt-genesis` tickets
### 2026-07-31 10:58 — snap
- Completed entire `add-test-duration-check` openspec (7 tickets, 9 commits, 299 tests)
- Files: config.rs, roles.rs, test_report.rs (new), main.rs, cli_test.rs, docs/configuration.md
- Implemented: DurationThresholds, JUnit XML parser, sub-role detection, duration evaluation, CLI wiring (--test-report/--execute), human/json/sarif output, docs
- All tickets closed, pushed to main
- **Next:** pretender-042 (adopt genesis doctor/feedback/cli/status/scaffold modules) or pretender-gyb (canonical pretender.toml template)
### 2026-07-31 14:13 — snap
- Completed pretender-gyb (canonical pretender.toml template + suite rollout)
- Created `templates/pretender.toml.example` with all sections documented
- Added `HooksConfigMismatchCheck` to doctor.rs (warns when hook installed but no config)
- Added "Recommended baseline for Rust CLI repos" to docs/configuration.md
- Filed wai-91zm for cross-suite pretender.toml rollout
- Commit: fbbe9d1, pushed to main
- **Next:** wai-91zm rollout to suite repos, or `bd ready` for next pretender ticket

### 2026-07-31 13:04 — snap
- Completed pretender-042 genesis adoption across 5 phases: global CliVerbosity/CliFormat flags, feedback::handle_feedback, completions subcommand, DoctorCheck trait/DoctorRunner for doctor checks, scaffold+discovery in init, StatusContributor
- Files changed: main.rs, doctor.rs, config.rs, Cargo.toml, tests/cli_test.rs, CHANGELOG.md, README.md, llm.txt
- Bumped version to 0.4.0, tagged v0.4.0, pushed to main and crates.io via CI
- All 91 tests passing, clippy clean, fmt clean
- **Next:** pretender-gyb (P2 — canonical pretender.toml template for suite repos)
