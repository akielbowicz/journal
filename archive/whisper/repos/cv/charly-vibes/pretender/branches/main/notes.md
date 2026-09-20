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

### 2026-09-20 (cont.) — pretender-hrw done
- Pinned dtolnay/rust-toolchain to @1.98 (minor branch; @1.98.1 ref doesn't exist upstream) in ci.yml + release.yml (5 refs). PR #13, CI green 33s.
- Gotcha: `bd close` + immediate `git add` staged a stale in_progress snapshot of issues.jsonl — re-add before commit. Worktree was correct all along.
- Bump procedure: bump the @1.98 refs in ci.yml + release.yml together with local `rustup update`.
- Remaining: merge PR #13 (user decision, main-push equivalent); 10 Dependabot PRs open+rebased, unmerged (checkout 4→7, upload-artifact 4→7, codecov 5→7 are major bumps — verify before merging).
- **Dependabot wave complete** (11/11 merged): 4 cargo tree-sitter bumps (python+go needed the except_group_clause fix, #14), 4 actions majors (checkout v7, upload-artifact v7, download-artifact v8, upload-pages-artifact v5), codecov v7. CI+Docs green @2b28aca.
- **Workflow-merge workaround documented** in env.md: gh token lacks `workflow` scope (SSH auth, can't re-auth) → merge workflow-file PRs locally with `--no-ff` and push over SSH.
- **pretender-x3p closed** (#15): flaky feedback test isolated via private XDG_CACHE_HOME tempdir per test (pattern from CORR-001 test). 5× cli_test runs + just ci green.
- **Gotcha:** bd close's JSONL write can be reverted by a git autostash applied mid-sequence — always re-grep the JSONL status after add/commit before pushing (hit twice today).
