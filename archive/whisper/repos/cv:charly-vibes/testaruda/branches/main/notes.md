### 2026-07-30 15:54 — snap
- **Issue review on epic testaruda-ifx**: Rule of 5 review found 6 issues (2 HIGH, 3 MEDIUM, 1 LOW). Fixed all: added dependency chain (ifx.4 → ifx.1/2/3), updated epic to mark Julia/.NET as ✅ DONE, added verification commands to all fix tickets, fixed Clojure file path, added output dir for re-run, added branch:main + phase:fix labels. Epic is now ready to work.

- **Next**: Start testaruda-ifx.1 (Rust adapter static analysis) or testaruda-ifx.2 (Clojure adapter ns wiring) — both are P1, unblocked

### 2026-07-30 16:48 — snap
- **testaruda-wnn**: Implemented `--mode synthetic` in stress-test.sh. Measures adapter quality by sampling N random source files and testing each individually for dependency edges. Reports `source_coverage` (fraction of source files that produce edges). Also fixed: adapter resolution bug (tail -1 skipping trailing empty lines), set -e arithmetic bomb in ((...)) expressions, path filter bug (*/test* matching "testaruda" in absolute paths). Committed + pushed (72d90c8). Ticket closed.

- **Synthetic stress-test results (51 repos)**: Only Python produces any edges (17% coverage). All other languages: 0%. Overall: 2.9% of source files produce edges. Created epic `testaruda-ifx` (P1) with 4 child tickets: Rust adapter fix, Clojure adapter fix, TypeScript adapter fix, re-run after fixes. Julia (testimonial-7e9x) and .NET (titi-0ej) already have tickets.

### 2026-07-29 18:48 — snap

- **testaruda OpenSpec cleanup**: Archived 6 completed changes (clojure, coldstart, julia, typescript, adopt-genesis, upgrade-genesis). Fixed pre-existing spec validation issues (duplicate TIA-CHG-009, missing SHALL/MUST in continuation paragraphs). All 21 specs now pass `openspec validate --specs`.

- **titi adapter fixes (3 rounds)**: Filed and tracked 3 titi blocker tickets through to resolution — titi-9tg (configurable source-roots), titi-ua5 (warm test cache on first discover), titi-4p5 (detect test projects by package refs). All landed, all closed.

- **.NET stress-test (testaruda-vx7) COMPLETE**: 10 repos tested end-to-end. 3 repos return real test counts (automapper 1383, fluentvalidation 820, nlog 2903). Remaining 7 have repo-specific infrastructure issues (NU1903, missing submodules, broken fixtures) — all documented in `target/stress-test-dotnet/DOTNET_STATUS.md`. Ticket closed.

- **Key decision**: The .NET adapter protocol works for repos that build clean. "0 tests" is a project-specific build health issue, not an adapter bug. titi's default test-SDK list (`DefaultTestSdkIds` in Domain.cs) covers xunit/NUnit/MSTest but not Microsoft.Testing.Platform (xunit.v3.mtp-v2), which Humanizer uses.

- **Next**: `add-dotnet-adapter-detection` openspec change has 2 remaining tasks (1.7 Windows verification, 1.8 Julia coordination — both non-blocking). Consider archiving. The other open beads (Julia stress-test blocked on ingest regression, TS ingest bug) need triage.

### 2026-07-29 20:20 — snap

- **Git mining pass**: Ran `testaruda discover+select` against 30 repos across 6 languages. Filed 5 bugs (fingerprint establishment P1, Clojure 0 edges, Julia 0 edges, .NET 0 tests, TS sparse edges).

- **Issue review**: Ran Rule of 5 on all 11 open issues. Fixed 7 findings: added `metadata.files`, acceptance criteria, split genesis adoption into epic+5 children.

- **Fingerprint fix (testaruda-udy)**: Added `testaruda fingerprint` command — walks all content units, updates blake3 hashes from disk. Verified end-to-end on click (245→2 unknown) and serde (77→1 unknown). Committed + pushed.

- **Clojure adapter fix (testaruda-70e)**: Fixed protocol mismatch — `from` field was file paths, now returns test function node_ids matching `discover` format. Also fixed Phase 2 skip logic so test files in the changed-files list aren't skipped. Verified: ring repo now produces 53 edges (was 0). Committed + pushed.

- **Julia adapter fix (testaruda-ag2)**: Fixed format mismatch — `handle_static_deps` returned edges as a Dict (file→"unresolved"), now returns standard `Vec<DepEdge>` array format. Fixed in Testimonial.jl repo. Committed + pushed.

- **Next**: testaruda-9bj (.NET adapter 0 tests) — need to verify titi AOT binary path avoids `global.json` SDK pinning
### 2026-07-30 11:39 — snap
- **Genesis adoption epic complete** — all 5 sub-tickets (doctor, feedback, cli, status, scaffold) implemented and closed. Bumped genesis-vibes from 0.2 → 0.3.
- **Bug fixes**: closed testaruda-8nl (TS adapter sparse edges — fixed path canonicalization in resolver), testaruda-9bj (.NET 0 tests — not a bug, stress test passed), testaruda-8ws (TS ingest 0 — expected behavior), testaruda-udy (fingerprint — verified ACs, closed)
- **Committed & pushed**: 5 commits on main (0e5aa38, 0ca2a82, b68cecc, 51316b2, a3d97c9)
- **Next:** testaruda-6c6.4 — Julia stress-test extend to 10 repos (P2), or testaruda-rty — Git mining pass (P3)

### 2026-07-30 17:13 — snap
- Completed epic testaruda-ifx (Fix static dependency edge detection across all adapters): Rust adapter rewritten with proper test→source resolution, Clojure adapter response format fixed, TypeScript adapter fix deployed, stress-test `src/` prefix bug fixed
- Rust adapter: 52.5% source_coverage on bat, 17.1% on rayon
- Clojure adapter: 17.9% on babashka (was 0%)
- Stress test fix: discover_source_files was stripping `src/` prefix for Rust/Julia/TS/Clojure
- **Next:** Claim testaruda-a3p (P2) — adopt genesis v0.4.0 CliVerbosity/CliFormat in testaruda

### 2026-08-27 16:46 — snap
- Made CI green on main (runs 33109460825 ✓): fixed gate tools (`espectacular-cli` → `espectacular@0.3.0` + `pretender@0.3.1` pinned), made titi fallback test deterministic (injects adapter via symlink onto child PATH), flushed stdout before `process::exit` in emit paths, pinned coverage to `--test-threads=1` (CwdGuard process-global cwd race). Commits 9bde2e2, a4e919f, 7bd5d1a pushed to main.
- Closed testaruda-b7ks; filed testaruda-pzh6 (P3, CwdGuard race — proper fix: `Command::current_dir()` per child, drops single-thread constraint) and testaruda-ehse (P1, Release workflow homebrew tap push auth failure — needs credentials decision from user).
- Also produced status report earlier: 4 P1s still open (9lbm JSON exit-code fix committed but unverified, lspm dedup same, ixp0 unclaimed); `.pretender/last-check.json` is a tracked-but-dirty artifact — candidate for `git rm --cached`.
- **Next:** verify + close testaruda-9lbm and testaruda-lspm (fixes already committed: a4db12a, 4fa122e); decide homebrew tap auth for testaruda-ehse; optionally untrack `.pretender/last-check.json`.

### 2026-08-28 20:21 — snap
- Value-prop validation + 4 fixes shipped to main: i802 (python adapter src/ layout — module resolution via __init__.py walk + src/ strip, verified 2/34 selection on click clone), pzh6 (parallel-safe test harnesses, CwdGuard deleted, 10/10 parallel runs green, dropped --test-threads=1), ls4t (degenerate full-suite selection now exits 10 with reason "over-selected: no dependency edges resolved" vs silently exit 0), fgoc (ingest --raw auto-detect prefers default_binary over first_ext — was storing 0 results on Python projects).
- Key learnings: cold-start policy = no-history tests are always_run (SAFE-007) so value prop needs one ingest cycle; CWD race was *within* test binaries (threads share process cwd), not across; cli_exit_codes fixture selected_count must be < total_tests for partial-selection asserts.
- All fixes pushed (main @ 81b4e32), beads + Dolt synced. Evaluation repro live at target/scratch/click (sandbox store/config are disposable).
- **Next:** claim P1 testaruda-9lbm (JSON-mode drops CI exit code — interacts with new ls4t exit-10 path), then ixp0 (garbled --help), lspm (SQLite NULL unique dup units — saw live: content_units 225+278 same path). Then P2 kyz2 (Option C scale eval: django/fastapi/numpy/pytest, now running against fixed adapter). Docs may need updating: getting-started still shows old 3-arg examples.
