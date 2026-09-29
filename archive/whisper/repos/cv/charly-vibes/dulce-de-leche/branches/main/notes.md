### 2026-07-30 16:54 — snap
- Designed and documented `dulce-de-leche` (ddl) — cross-platform bundle orchestrator for charly-vibes tools
- Ran adversarial stakeholder evaluation → concluded shell script insufficient, Rust CLI justified by multi-platform bootstrap problem
- Created openspec specs: `cli-core`, `bootstrap`, `health`, `version-management`, `dot-ddl` — all validated
- Created 42 beads issues (8 epics, 34 tasks) → merged 10 test tickets into impl → now 32 issues
- Applied Rule of 5 review to specs + issue-review to beads tickets — all fixes applied
- **Next:** Start implementation — claim DDL-2te.2 (scaffold crate) from `bd ready`
### 2026-07-30 16:15 — snap
- Full crate scaffolded: Cargo.toml, CLI (clap derive), error types (miette), platform detection, manifest, installer, diagnostics, dot_ddl, compat, output modules
- GitHub Actions workflows: CI (fmt+lint+test+build), Release (cross-compile 5 platforms → crates.io → Homebrew → Scoop), Docs (mdBook → Pages)
- Installation chain: binary download (tar.gz/zip), cargo install, brew install (placeholder detection), scoop install — all wired
- Interactive `ddl init` with cliclack multi-select, `--yes` non-interactive mode, `--json` genesis-vibes envelope on all commands
- Version compatibility matrix: dynamic fetch + embedded fallback + local cache, semver constraint checking
- Health diagnostics: subprocess calls to each tool's status/doctor, per-tool config detection, `--json` output
- Homebrew formula in homebrew-charly, Scoop manifest in scoop-charly
- **Next:** Remaining polish items: DDL-r2t.7 (init --yes CI mode), DDL-h0x.2/3 (version/upgrade commands), DDL-r7a (documentation). All core functionality is implemented.

### 2026-08-05 13:08 — snap
- Fixed all P0/P1/P2 bugs in dulce-de-leche: 13 tickets closed across migrate (symlinks, idempotency, undo), doctor --fix, manifest concurrency, genesis-vibes v0.6.0 API, status_summary, JSON error format, silent .ddl/ creation, and init --json single envelope
- Key changes: `src/dot_ddl.rs` (migrate, locking, find()), `src/diagnostics.rs` (--fix, status_summary), `src/output.rs` (JsonCollectorGuard, banner), `src/compat.rs` (warning return), `src/installer.rs` (user_agent), `src/main.rs` (find() calls)
- DDL-iqv: genesis-vibes bumped 0.4→0.6, all 9 json_output call sites got cli_version arg
- 38 tests all passing, clippy clean
- **Next:** DDL-02a (--verbose non-functional, P3) or the docs drift epic (DDL-6np, P3), or the 6 P2 test-gap tickets

### 2026-08-05 13:41 — close
- Closed 14 tickets: --verbose impl, 33 new integration tests, 6 docs drift fixes, v0.3.0 released
- --verbose now works: verbose_print() helper wired into all 8 installer functions
- 33 integration tests added: doctor (4), install (10), scope (6), status (5), version (7)
- Docs drift: design.md/CLAUDE.md status, symlink direction, exit codes, verbosity levels, --profile minimal note
- v0.3.0 released: changelog created, version bumped, tagged + pushed
- 71 tests total, all passing, clippy clean, fmt clean
- **Next:** all DDL tickets closed — no remaining work

### 2026-09-15 15:50 — snap
- Shipped `feat/init-wai-and-incitaciones` merged to main (`aa56513`): `ddl init` now always forces `wai init`; incitaciones added as npm-managed tool (new `InstallMethod::Npm`, `src/skills.rs` global/local skill detection via `installed-from:` frontmatter marker, global/local/skip prompt, doctor check)
- Fixed Windows npm `.cmd` shim routing via `installer::npm_command()` helper (DDL-1hf); rule-of-5 polish applied: `Tool.npm_package` field, advisory wai init, prompt scoping, walk-up local detection (DDL-ayl); merge commit `aa56513`, feature branch deleted, beads synced
- Rule-of-5 review of the change found and resolved all findings; DDL-b33/1hf/ayl closed
- **Next:** remaining open beads are pre-existing: DDL-q9b (P0 migrate corrupts single-file configs), DDL-0jo/DDL-1se/DDL-mfq (P1 CI badge red, doctor --fix no-op, migrate idempotency), DDL-9c2 (whisper/turu to toolset — now trivial via `Tool.npm_package` if npm), DDL-cnh (stale tap formulas)

### 2026-09-15 17:21 — snap
- Stale-ticket sweep: closed DDL-q9b, DDL-mfq, DDL-1se, DDL-cnh — all fixed same-day in pre-rekey commits (b7f5333/DDL-el9, 89e5998/DDL-40e, f2ab838/DDL-9ge) but never closed after beads→Dolt ID re-key; remembered the gotcha via bd remember
- Fixed red CI badge (DDL-0jo): two stacked causes — unformatted src/main.rs from the incitaciones merge (ace450c), and test_install_json_parses doing a REAL network install in CI because wai wasn't on PATH there (5888b88; now uses unknown-tool error path, asserts envelope on stderr). CI green
- Added turu (whisper-vibes) to the toolset (DDL-9c2, commit 3355dba): registry, compat matrix (>=0.3.0), README/ecosystem-map, INSTALL_ONLY (state is home-dir global, no repo-local legacy config); live-verified on Linux; ticket HELD OPEN pending macOS/Windows smoke tests
- User design decision: install policy = prebuilt binary first everywhere, cargo fallback on 404, npm only for incitaciones, brew/scoop out of ddl's decision path → filed DDL-ei3, drafted openspec change `simplify-install-chain` (validates --strict), implemented after approval (bd72a36, CI green)
- Implementation notes: miette `#[diagnostic(help)]` on named-field error variants triggers unused_assignments false positive (avoid); fallback_after_binary_failure(bool) kept pure for tests; upgrade_tool keeps recorded cargo/npm channel to avoid PATH shadowing; no networked 404 test (would overwrite owner's ~/.cargo/bin dev builds)
- **Next:** (1) macOS/Windows smoke verification → then close DDL-ei3 (openspec archive `simplify-install-chain`) and DDL-9c2; (2) dont-piwl in the dont repo: uncommitted 60-file test refactor there needs commit/discard decision first, then port whisper release fixes and cut v0.3.0 (needs release approval); (3) fabbro still blocked — no tag

### 2026-09-15 18:47 — usage census + family evaluation (cross-session)
- Repo-state census (34 charly repos): adoption tiers — wai (20 repos, ongoing writes) + testaruda (8, ongoing) are the only daily-used family tools; turu light-use; espectacular/dont/fabbro init-and-forget (all 7 dont DBs frozen at 07-28 mass-init); vampiro never installed; pretender has 0 configs; beads (external, AGENTS-mandated) at 25 repos out-adopts all. Full report: `microdancing/conference-analysis/analysis/data/ddl-family-evaluation.md`
- **`src/installer.rs` downloads have no checksum/signature/pin verification** (`download_and_extract_tar_gz`/`_zip`: reqwest::get → tar → unpack). Fix candidates: release checksum manifests + verify, `ddl.lock` pinning (proposed in docs/adversarial-evaluation-addendum.md)
- Family evaluation verdict: pipeline is doc-only (no tool consumes another's workflow state); highest-leverage moves = evals for the family's own tools, checksum the supply chain, measure injected context tokens, per-tool falsifiable metrics
- ⚠️ Stale claim to verify: evaluation report F3 cites placeholder Homebrew formulas (from old adversarial-eval doc) — but DDL-cnh closed 2026-09-15 17:21 saying formulas fixed pre-rekey; confirm before citing

### 2026-09-29 15:07 — ZZZZ-docs external evals triaged + improvement tickets filed
- ZZZZ-docs/ = 4 external AI evals (3× Grok 4.5, 2× Qwen3.7) contra snapshot 2026-09-21 — mayoría stale (fabbro/fotos-mcp ya fuera, genesis 0.8.1, ddl 0.6.0); review Rule-of-5: ~40% mejora / ~60% YAGNI
- **YAGNI verdicts (no filedocs):** Core Quality Triad fail-closed (dont+ah+vampiro) contradice el census (0 installs / frozen) — enforcement parked tras dogfood epic charly-26y; quality receipt sin consumer; benchmark-harness repo duplica evallerina; env-locking/data-lineage/@numerical = schema sin users
- **Mejoras → 6 tickets filed + issue-review pass** (metadata.files, base_commit, Must gates cuantificados, co-mod notes): DDL-5ph (checksums installer.rs — F3 verificado aún missing), DDL-3i4 (registry partition core/recommended/extension), DDL-91a (ddl catalog + capability matrix, un solo registry), incitaciones-xdo + fabbro-dqtc (licencias), evallerina-sqq (6 archetypes, blocked-by e10, reusa fixtures de 7y1)
- **Gotcha:** `bd export` default = stdout — para actualizar el JSONL fuente hace falta `-o .beads/issues.jsonl` (el file puede quedar stale sin que nada falle); después de creates/updates: export -o → add -f → commit → push por store
### 2026-09-29 15:39 — snap
- Implemented DDL-5ph (P1) on feat/checksum-verify: binary-install path now verifies sha256 against the release's checksums.txt (shasum format, per-asset .sha256 fallback) before extraction; mismatch = hard ChecksumMismatch abort naming the tool; absent checksums warn-and-proceed. sha2+bytes deps added. 9 unit tests, TDD red→green (parser bugs: `?` in loop + quote-at-pos-0); live-verified via `ddl install turu` in isolated HOME/PATH against charly-vibes/whisper checksums.txt
- Rule-of-5 review (converged stage 4): fixed misleading double-warning on unlisted assets, sha256sum `-b` `*` prefix parsing, doc-header updates, residual-risk comment (malicious release listing own digest needs sigstore — out of scope). Tidy commit separate (1401bd1)
- Merged PR #29 → main. Merge-commit CI failed: init_noninteractive tests hung in `ddl init --yes`'s real `npx --yes` skill install (network); CMD_TIMEOUT kill = `code=interrupted`. Fixed test-only in PR #32 by stubbing `incitaciones` on PATH (4.76s→0.02s); main CI green (run 36612841340)
- **Next:** remaining beads: DDL-3i4/DDL-91a (registry partition + catalog cmd), DDL-zw4 (P2 install-manifest bug), DDL-x0m (P3 bd version unknown), DDL-2um (P2 needs TAP_GITHUB_TOKEN secret from user), DDL-gap, DDL-isi. Follow-up P3 filed: networked-mock checksum-mismatch integration test
### 2026-09-29 16:01 — snap
- Closed DDL-zw4 (PR #33) + DDL-3i4 (PR #34), both merged to main, merge-commit CI green; branches deleted, local main synced
- DDL-zw4: `ddl install` on PATH-but-untracked tool now records manifest entry (source `skipped`, probed version); integration test stubs `turu` on PATH
- DDL-3i4: `ToolCategory` + `Maturity` on all 11 MANAGED_TOOLS, locked to census draft by drift test; rendered in status `[core/stable]` + version JSON; README block regenerated as category groups
- CI incident: init test's second cmd2 lacked the incitaciones PATH stub → real `npx --yes` network install → CMD_TIMEOUT kill (PR #32's incomplete fix); fixed test-only (7c83d2a)
- **Next:** DDL-91a (`ddl catalog` command + generated docs/capability-matrix.md) — now unblocked, 3i4 landed first; extensions: drift test in tests/tool_registry_drift.rs. Remaining beads: DDL-gap, DDL-isi, DDL-x0m, DDL-hsn, DDL-2um (needs TAP_GITHUB_TOKEN from user)
