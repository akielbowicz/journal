### 2026-07-29 15:37 — snap
- Investigated why pi sessions don't use wai pipelines (AGENTS.md manual cycle vs. pipeline disconnect)
- Created 5 tickets: wai-ak5q (doctor pipeline utilization check), wai-885g (update Quick Start), wai-knbl (prime pipeline highlights), wai-j56n (health banner), wai-hfgz (pi hook check)
- Implemented wai-ak5q: `check_pipeline_utilization()` in `src/commands/doctor/mod.rs` — warns when manual TDD-cycle instructions exist but a pipeline is available
- Implemented wai-885g: updated AGENTS.md & CLAUDE.md Quick Start to prefer `wai pipeline start epic-autonomy-tdd-ro5`; ran `wai init` to regenerate managed blocks
- **Next:** wai-knbl (prime pipeline section) or wai-j56n (health banner in status/prime)

### 2026-07-29 17:33 — full wai session: 6 tickets + release v2026.7.29
- **Managed-block always-stale bug**: `wai_block_content()` inserted `\n` after `WAI_START` marker, but genesis `BlockInjector` writes `start_marker + inner + end_marker` with NO newline. Every workspace falsely reported CLAUDE.md/AGENTS.md staleness. Fix: removed the `push('\n')` in `wai_block_content()`. Fresh `wai init` now doctor-green.
- **wai-knbl**: `render_pipelines()` in prime — active run step + available pipelines with phase-gated start suggestion. Reuses `pipeline_current_status` (re-exported from pipeline::orchestration) and `detect_installed_pipelines`.
- **wai-j56n**: `DoctorHealthSummary { warn, fail }` with `health_summary()` in doctor/mod.rs. Single `collect_checks()` shared by `wai doctor` and inline summary so they never disagree.
- **wai-hfgz**: pi `session_start` check — gated on project-local `.pi/` presence (not global `~/.pi/agent/`). Rationale: keeps tests hermetic and prevents breaking wai-j56n's silent-when-green contract. Scanner matches both shell-string (`wai prime`) and argv (`pi.exec("wai", ["prime"])`) forms.
- **wai-pa3b**: `clear_complete_pipeline_run()` removes `.wai/.pipeline-run` + `.wai/resources/pipelines/.last-run`. `.last-run` was accidentally tracked; added to `.wai/.gitignore` and untracked.
- **Release v2026.7.29** — tagged and pushed. GHA builds/publishes.
- **Suite propagation**: ran `wai init` in all 7 suite repos (pretender/espectacular/testaruda/dont/vampiro/crua/livin); added badge to pretender README.

### 2026-07-31 15:58 — snap
- Genesis v0.4.0 adoption: adopted cli, doctor (DoctorCheck+DoctorRunner+DoctorReport), status (DoctorStatusBridge), scaffold modules across 5 commits
- Files touched: src/main.rs, src/commands/mod.rs, src/commands/doctor/mod.rs, src/commands/status.rs, src/commands/feedback.rs, src/workspace.rs, tests/doctor_test.rs
- Closed wai-u9ci (all 6 items done). wai-xkoq still open — 4 P2 modules remain: discovery, fixture, aix, suite_linter
- **Next:** Start on discovery or fixture module adoption, or tackle wai-91zm (pretender.toml rollout) / wai-4guc (cli ergonomics)

### 2026-08-05 13:08 — snap
- Closed 6 tickets: `wai-5i1l` (P0 plugin trust model — SEC-1 RCE fix), `wai-hc8j` (P0 remove local doctor types), `wai-wzgz` (P0 behavioral guardrails), `wai-qqlt` (P1 hook timeout deadlock), `wai-vjbu` (P1 phantom --update flag), `wai-k9ih` (P1 CI test failure)
- Key changes: TrustStore + SHA-256 digest-based approval for plugin hooks; `wai plugin trust`/`--list`/`--revoke` commands; replaced local CheckResult/Status/DoctorHealthSummary with genesis::doctor types; fixed try_wait() deadlock in execute_hook/execute_passthrough; removed phantom `--update` flag refs; stubbed HOME in prime test for CI
- Files touched: `src/plugin.rs`, `src/cli.rs`, `src/commands/plugin.rs`, `src/error.rs`, `src/commands/doctor/`, `src/commands/way/`, `src/commands/status.rs`, `src/commands/prime.rs`, `tests/integration.rs`, `tests/prime_test.rs`, `docs/src/concepts/pipelines.md`, `openspec/changes/add-plugin-trust-model/`
- **Next:** Continue with remaining P1-P2 bugs: `wai-hktb` (dual pipeline-run tracking), `wai-6pmm` (way --fix), `wai-uhs4` (doctor --fix), `wai-lrlz` (add review --reviews), or task `wai-47m0` (genesis v0.6.0 envelope API)

### 2026-08-05 15:24 — snap
- Closed 12 tickets in one session: wai-47m0 (genesis v0.6.0 envelope API), wai-0qx0 (falsifiable VP), wai-hktb (dual pipeline-run consolidation), wai-6pmm (way --fix error msg), wai-8hsg (unclosed code fence), wai-uhs4 (doctor --fix staleness auto-fix), wai-lrlz (add review --reviews help), wai-uqu1 (ls default root docs), wai-sr40 (feedback docs), wai-07nd (Claude hook warn→Pass), wai-zswo (deprecated resource add skill dupe), wai-0uvy (missing flags in help)
- Pushed 18 commits to main (all pre-commit hooks passed: fmt, clippy, tests)
- **Next:** wai-4guc (genesis CLI ergonomics refactor — CliVerbosity, CliFormat, discovery) needs a dedicated session; wai-91zm (pretender.toml rollout) is cross-repo

### 2026-08-05 16:45 — close
- Closed wai-4guc (genesis CLI ergonomics: CliVerbosity, CliFormat, --human)
- Closed wai-91zm (pretender.toml for wai + lefthook + CI integration)
- Released v2026.8.5 (crates.io + GitHub binaries + Homebrew)
- Fixed pre-existing cargo publish bug: include_str! paths referencing .wai/ outside package. Moved skill templates into src/commands/way/
- **Key decision:** pretender doctor removed from CI pipeline (exits non-zero in CI, no hook); pretender check --diff-only is the CI gate
- **Next:** no ready work — all tickets deferred or blocked
- **Cargo publish fix:** skill templates must live inside src/ (not .wai/) for cargo package to verify the tarball

### 2026-09-17 11:49 — snap
- Merged PR #1 into main (way artifact-stub check wai-vdg6, prime Prior-context wai-xt9o, CI fetch-depth fix); branch deleted; dogfood confirmed on main
- Session-mining research doc + 6 tickets filed; wai-sojk blocked on add-decision-freshness-tracking epic (17 tasks: 4 spec, 3 design, 5 impl TDD, validation)
- bd dolt push still failing (diverged histories) — needs user decision (force vs bootstrap)
- **Next:** start add-decision-freshness-tracking epic spec tasks 1.1–1.4 (openspec deltas), then design 2.1–2.3, then TDD impl 3.x/4.x; fresh session via /renew or wai prime

### 2026-09-28 19:14 — release v2026.9.28
- Released v2026.9.28: decision matrix feature (wai-vk0u, PR #14) + way stub-check + prime prior-context; changelog got retroactive [2026.8.5] section (that release shipped with no changelog entry)
- CI red on the tag: matrix decide-snapshot test read the matrix/ *directory* via fs::read_to_string — read_dir ordering is filesystem-dependent, so it passed locally in pre-push and failed in CI. Test now filters to regular files (PR #15, merged)
- bd close takes ONE id at a time (multi-id silently fails); .beads is gitignored but issues.jsonl is tracked → needs `git add -f .beads/issues.jsonl`
- Release convention confirmed: release commit = Cargo.toml/lock bump only (CalVer YYYY.M.D); GHA Release workflow publishes crates.io + binaries; mdbook Docs workflow is separate
- bd dolt push issue from earlier sessions is resolved by design: no-db=true, JSONL is the sync path
- **Next:** ready work = wai-sib1 (P1, project use portability), wai-sojk (P2), remaining P2/P3 hygiene
### 2026-07-31 16:26 — close session (genesis adoption completion + v2026.7.31 release)
- **wai-xkoq closed**: all 14 genesis v0.4.0 modules adopted
- **discovery**: `genesis::discovery::register("wai", ...)` during `wai init` — wai now self-registers in `.genesis/tools.toml`
- **aix**: created `examples/gen-aix.rs` with `just aix-gen`. Uses `genesis::aix::agents_block()`. Full structured generation (ProjectMeta, section helpers) not yet available in published crate — inline formatting for now
- **fixture**: `tests/genesis_fixture_test.rs` demonstrates `Fixture` builder with markers, TOML config, git init, and custom files. Prefer `Fixture` over raw `TempDir` for new tests
- **Release v2026.7.31**: tag pushed, CI should build/publish binaries to GitHub
- **Next:** `wai-91zm` (pretender.toml rollout) or `wai-4guc` (CLI ergonomics adoption)
### 2026-09-28 15:39 — snap
- Merged PR #14 (feat/matrix-command-group, decision matrix) into main via --no-ff, pushed; PR marked MERGED, CI green
- Fixed beads Dolt divergence: local DB was authoritative (710) vs stale remote (425); recovered 3 remote-only issues (wai-sib1, wai-cmej, wai-005m) via JSONL import → 713 total, 656 dep edges, verified union before any destructive step
- Root cause of slow/broken sync: no-db was false + sync.remote set (gitblobstore chunk push over SSH). Fixed: `no-db: true`, dropped sync.remote, deleted stale refs/dolt/data from remote — sync is now git-tracked issues.jsonl only
- Verified fresh-clone bootstrap yields 713; committed dbebd46. Note: GitHub SSH port 443 intermittently denied clones mid-session (rate-limit suspicion); retries work
- **Next:** nothing pending on beads/PR-14 thread; `bd ready` shows next work (wai-cjnx epic: 16 clippy errors). Consider tracking junk tracked in git (.beads/dolt-config.log, dolt-server.pid, dolt-server.activity) for gitignoring
