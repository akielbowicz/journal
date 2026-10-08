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
### 2026-09-30 18:31 — snap
- Ecosystem standardization: ratified docs/standardization.md v0.3 in ddl (CI, docs structure, microdancing charly theme, dogfood matrix with pinned installs, why/status blocks); specodelic got the standard 5-target release.yml (DDL-cle closed); conformance drift test tests/standard_conformance.rs shipped — ddl green, siblings red; ecosystem dev guide at docs/src/ecosystem.md; turu/whisper reclassified in-org (10 in-org repos, external = bd + openspec only)
- Key decisions: vendored theme/charly.css (no theme crate); default-theme = "coal" (mdBook can't register custom names); versions.ddl.toml pins for all CI ecosystem installs; ddl dogfoods first
- **Next:** rollout steps 2–6 under bd epic DDL-u8x — turn sibling repos green on the conformance test (worst first: whisper — needs docs.yml, book, llms.txt, pins, README block; then dont CI rename, vampiro pages→docs, incitaciones ci.yml, then theme/book.toml + pins + README blocks across the rest; finally per-tool stable/beta/experimental status assignment)

### 2026-09-30 22:1x — snap (standardization rollout marathon)
- Ratified docs/standardization.md v0.3 (DDL-u8x ✓), verified/dogfooded microdancing theme (DDL-sii ✓), migrated CI in dont/vampiro/incitaciones to §1 (DDL-kh5 ✓), added canonical release-naming assertion (DDL-d6z ✓), whisper full rollout: mdBook+theme+docs.yml+llms.txt+llm.txt+pins+README block (DDL-qms ✓)
- DDL-1a0 partial: versions.ddl.toml landed in all 10 repos (s4 green) — remaining: ci.yml install wiring, bd pinned-install mechanism decision (brew vs release download), run-integration
- DDL-jnt bulk: theme/charly.css + coal wired everywhere, README §5 why/status blocks + status.md backfilled ×8 (statuses provisional: beta fleet, experimental specodelic/incitaciones), specodelic+incit books created, wai/espectacular root-book docs.yml fixed → conformance drift test 11/11 GREEN fleet-wide
- All 9 tool repos pushed to origin; ddl beads state exported; meta-repo pointer bumps local-only (no remote)
- **Next:** DDL-57e (confirm statuses + capability matrix) or DDL-1a0 install pass; jnt residual = docs/src restructure for testaruda/dont/pretender, artifacts → docs/research/, llm.txt gaps

### 2026-10-01 — DDL-y49 closed (live-URL smoke guardrail)
- TDD: red mechanism validated against a nonexistent Pages repo (temp probe observed failing, then removed); characterization green-start per ticket
- s2_book_repos_deploy_pages: docs.yml must use actions/deploy-pages — content-based detection, not hardcoded list; ticket's incitaciones/genesis carve-outs were STALE (both deploy books, both live 200) — included, stricter than ticket
- s2_live_book_sites_return_200: GET charly-vibes.github.io/<repo>/ for every detected repo, retry x2 10s timeout, DDL_SKIP_LIVE_SMOKE=1 opt-out; gotcha: reqwest blocking available to tests via main deps; clippy collapsible-if fix
- Coverage boundary: conformance suite runs in ddl CI (ddl URL only — GH Actions parent dir makes ../dulce-de-leche resolve to the checkout itself); full 11-repo smoke only in hub checkouts; per-repo CI doesn't run the suite — accepted residual, documented in module header
- PRE-EXISTING fmt drift at genesis_pin (local rustfmt vs committed style) — cargo fmt fixed whole file in this commit
- Commit e7b8c27 + beads export 8ebbaa4; pushed+synced
- **Next:** DDL-j0u (§6 fleet rollout, s6 test red on ~9 repos expected) or DDL-561; DDL-2um still blocked on TAP_GITHUB_TOKEN

### 2026-10-01 — DDL-j0u closed (§6 fleet rollout: versioned docs + generated release pages)
- s6_docs_deploy_on_tags_with_version_injection: RED on all non-ddl repos → green fleet-wide (18/18 conformance). Scope: pages-deploying ∩ has-Cargo.toml; carve-outs incitaciones (npm) + genesis (lib-crate) per ticket
- 8 repos patched (wai/dont/testaruda/espectacular/pretender/vampiro/specodelic/whisper): v* tag + Cargo.toml path trigger, Generate release-status pre-build step, .gitignore docs/src/release.md, SUMMARY wiring
- GOTCHAS caught by local mdbook verification: (1) pretender root Cargo.toml is a WORKSPACE manifest — no version; step reads pretender/Cargo.toml; (2) mdBook 0.5.2 DROPS a bare SUMMARY entry inserted between list items — repos whose first entry is a list item (- [..]) need list-item syntax for the release link; bare top-level link only works when neighboring entries are bare links
- Hand-typed version claims → generated-page links: vampiro index.md ×2, whisper status.md ×1 (historical/changelog refs deliberately left)
- specodelic: concurrent session ACTIVE (committed hooks refactor on top of mine, pushed both) — staged only my files, zero conflict
- Commits: wai c15ab02, dont 9eb7677, testaruda 60e6ba3, espectacular 4c1283b, pretender 696ffb3, vampiro 7ce0c99, specodelic 127b195, whisper a188fab; ddl ee34d36; charly pointer bumped; all pushed
- **Next:** DDL-561 (genesis conformance declaration test) or DDL-frh (ecosystem landing page); DDL-2um still blocked on TAP_GITHUB_TOKEN

### 2026-10-01 — DDL-frh closed (ecosystem landing page)
- Landing = ddl book page, user's choice over org-profile/root-page: docs.yml 'Generate ecosystem landing' step copies docs/ecosystem-map.md → docs/src/ecosystem-map.md (provenance header; capability-matrix.md relative link rewritten to GitHub absolute since it's not in the book); SUMMARY wires [charly-vibes Tool Ecosystem]
- s7_ecosystem_landing_generated_in_ddl + s7_ecosystem_landing_cross_linked: SUMMARY + README status block must link https://charly-vibes.github.io/dulce-de-leche/ecosystem-map.html in all 11 repos (ddl exempt → in-book relative); red→green; §7 checklist updated in standardization.md
- MDBOOK GOTCHAS (banked, 0.5.2): (1) create-missing=false + external-URL SUMMARY entry → mdbook ABORTS exit 101 trying to read the URL as a chapter source (pretender was the only repo with the flag — removed); (2) bare SUMMARY entries inserted BETWEEN list items are silently DROPPED — match neighbor syntax (list item vs bare/prefix); (3) external URLs render fine as chapters when create-missing=true (fleet default)
- genesis README: multi-line blockquote status — keep the blank '>' continuation when appending segments
- Commits: wai a6c266e, dont 2a8c580, testaruda 18126c8, espectacular ce094ed, pretender 8e9f72c, vampiro 07184e3, specodelic 1d32989, whisper 7b4feac, incitaciones e9cc333, genesis fa6497c, ddl 4865579+d4178aa; all pushed; charly pointer bumped
- **Next:** DDL-561 (genesis conformance declaration test) or DDL-43g (per-repo live-URL smoke step); DDL-2um blocked on TAP_GITHUB_TOKEN

### 2026-10-01 12:17 — snap (quick stash)
- Session banked 3 tickets end-to-end: DDL-y49 (live-URL smoke guardrail — content-based `actions/deploy-pages` detection + networked 200 check, `DDL_SKIP_LIVE_SMOKE=1` opt-out), DDL-j0u (§6 fleet rollout — s6 conformance red→green on 8 repos: v* tag + Cargo.toml triggers, generated release-status pages, SUMMARY wiring; vampiro/whisper hand-typed versions → generated-page links), DDL-frh (ecosystem landing — ddl book hosts page generated from ecosystem-map.md, s7 tests cross-link every book SUMMARY + README status block across 11 repos)
- Key gotchas banked in turu: mdbook 0.5.2 drops bare SUMMARY entries between list items (match neighbor syntax); create-missing=false aborts on external-URL SUMMARY entries (pretender flag removed); pretender workspace manifest needs version from pretender/Cargo.toml; genesis README blockquote blank-'>' continuation
- Conformance suite now 20/20; all repos pushed+synced; charly pointer 198444b; DDL-43g filed as y49 residual (per-repo ci.yml curl of own Pages URL)
- **Next:** user reviewed P3 menu — pick from DDL-bq6 (quick genesis update_check doc row), DDL-43g (highest-value guardrail), or DDL-hsn (installer mock seam, code work); DDL-2um still blocked on TAP_GITHUB_TOKEN; /renew to resume
- 2026-10-01T17:49:02Z [id:a816f2f3733a0f2a5812143e55bff9837f6514785ebd36a6400c1af575e09220] (#ddl) ### 2026-10-01 ~18:40 — pretender reality check: gate is advisory fleet-wide except testaruda
  - QUESTION: does pretender check report good quality fleet-wide? ANSWER: no — and exit codes are green everywhere except testaruda
  - MODE SEMANTICS (pretender/src/main.rs:1082): Guidance=>SUCCESS, Tiered=>SUCCESS (DEFAULT, mode.unwrap_or(Tiered)), Gate=>FAILURE on violations. Tiered/guidance are advisory BY DESIGN — exit 0 no matter what
  - WIRING AUDIT: pretender wired in only 4 repos — wai (--staged, config tiered → NEVER blocks), genesis (check src/, tiered → NEVER blocks), testaruda (--staged --mode gate + --diff-only --mode gate → REAL GATE, and src/ is clean under its tuned thresholds), bajan (tiered, advisory). Other 7 repos don't run pretender at all (their hooks use fmt/clippy/testaruda/vampiro-check/spk/etc)
  - WHOLE-SRC GATE MODE violation counts (vs defaults or own configs): vampiro 1850 (1467 min_assertions = test fns w/o counted assertions), pretender 437 (253 min_assertions), wai 238, specodelic 177, incitaciones 138, espectacular 89, bajan 58, genesis 57, dont 48, ddl 48, whisper 12, testaruda 0. Dominant metric: function_lines, then abc/cognitive. min_assertions likely scanner limitation (assert-in-helper not counted) — triage during tuning
  - ADOPTION PATTERN (wai/testaruda configs prove it): per-repo pretender.toml with thresholds tuned to CURRENT baseline + roles for tests, then --mode gate in hooks = ratchet; tighten progressively (wai config comments say exactly this)
  - FILED: ddl ticket (P2) pretender-advisory-fleet + export pushed (126 issues). Previous claim 'all tools gate commits' corrected: pretender specifically only gates in testaruda; wai/genesis blocking comes from fmt/clippy/testaruda/ah/pretender-adjacent tools
  - Next options: (a) per-repo pretender.toml + gate wiring ratchet (big, mechanical), (b) fix hooks to gate on diff-only scope only (testaruda pattern — cheap, incremental), (c) accept tiered-advisory + rely on vampiro/other tools. User decision
### 2026-10-08 11:27 — snap
- Mined all pi sessions Jul 30–Oct 8 (297 this month; consumer inits: uarup 9/5, finanzas 9/14+9/29, bajan 9/28, REPLy 10/1, wanna/tambor 10/6, gently 10/8) → init-workflow friction report: ddl init never wires gates/wai/no-db; cascade ordering bugs; envelope schema drift; no feedback cmd; repo-unaware doctor; migrate symlinks break tracked dirs
- Filed epic **DDL-6zn** + 6 children (6zn.2 init --gates = top fix, .3 cascade, .4 envelope contract, .5 repo doctor→gh#46, .6 feedback→gh#31, .7 migrate→gh#30, .8 aliases); exported + committed 43b0516, pushed to main
- **Next:** user said "we need to implement" — pick up **DDL-6zn.2** (`ddl init --gates`: lefthook managed blocks inside commands:, gitignore for all tool data dirs, beads no-db stamping, openspec-init-before-ah ordering); claim via `bd update DDL-6zn.2 --claim`, TDD per wai pipeline
