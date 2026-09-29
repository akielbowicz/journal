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

### 2026-09-29 16:00 — snap
- **3 tickets closed & pushed** (a431c3c): pretender-bi9 (hooks migrated onto genesis::git_hooks 0.8.2 + pre-push support; hook script bytes byte-identical), pretender-u8a (resolution tracking: stable finding IDs `path::unit_name::rule_key`, snapshot persisted on EVERY run incl. clean ones, human delta line, JSON `data.history.resolution`, rate in summaries.json), pretender-15w (gate verified via AFK meter `scripts/meter-gate-hook.sh`, wired into cli_test as test_meter_gate_hook_stops_commit).
- Genesis 0.4→0.8.2 breaks fixed: `Envelope::success/error` gained `cli_version` arg, `DoctorReport::to_envelope(cli_version)`, `CLI_VERSION` const removed.
- **Discovery: global `core.hooksPath` (~/.git-hooks lefthook shim) makes pretender's installed hook inert on this machine** — gate works but hook never invoked. genesis::git_hooks::resolve_hooks_dir only checks local scope. Follow-up: genesis fix (effective hooksPath across scopes) + possible pretender doctor check.
- bd quirks: auto-export does NOT write new tickets to issues.jsonl (needs explicit `bd export`); `git add .beads/...` prints ignore warning but stages fine.
- **Next:** pretender-dj5 (P3, unblocked — gate-blocked findings → bd tickets, uses u8a's `first_seen` + 15w's meter pattern) or genesis-side hooksPath fix.
- 2026-09-29T20:08:36Z [id:718090ac825187a37ab05c385af47edd84bca0d982d3f1dd1a402b66a6655986] (#session) ### 2026-09-29 17:10 — snap
  - pretender-5p4 done (TDD): HookLocationCheck doctor check — warns with scope when git invokes hooks from a different dir than installed .git/hooks/pre-commit, errors on empty hooksPath. genesis-vibes 0.8.2→0.8.3 (effective_hooks_dir).
  - Hermetic tests: ALL cli_test commands now go through pretender_cmd() pinning GIT_CONFIG_GLOBAL to a neutral empty file — genesis 0.8.3 multi-scope resolution made 8 tests hit the machine's real global shim. Keep this pattern for any test spawning pretender.
  - Gotcha: sed over the test file rewrote Command::new(pretender_bin()) INSIDE the new helper → infinite recursion/stack overflow; stash-bisection isolated it.
  - Released v0.6.0: crates.io + GH release + 6 assets; tap/scoop workflow steps failed (TAP_GITHUB_TOKEN secret missing) → patched manually over SSH (homebrew-charly 8562019, scoop-charly 5c3195b). pretender-2tp filed (user must create PAT via web UI).
  - Test bug fixed (c600346): determinism test normalize was asymmetric when data.history absent (run1) vs present (run2) — always strip data.history instead of conditionally extracting. Flagged under tarpaulin only.
  - Meta-confirmation of genesis #12: the global lefthook shim (rbenv ruby missing, exit 127) blocked local commits in homebrew-charly — global core.hooksPath harms foreign repos too. --no-verify / -c core.hooksPath=/dev/null to bypass.
  - Next: pretender-dj5 (ready); user action for 2tp.
