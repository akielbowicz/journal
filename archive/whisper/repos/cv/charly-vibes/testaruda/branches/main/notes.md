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
### 2026-09-20 17:11 — snap
- Fixed 4 tickets this session, all merged to main with green CI: vk20 P0 (test contract: degenerate full-suite now exits 10 FULL_RUN per ls4t), 9lbm P0 (agent-mode now exits with outcome-derived CI code), hnt9 P1 (genesis-vibes pin 0.6→0.7, GH #1 closed), jdw5 P1 (revision-range selects use git diff as change oracle; ChangeSet gained from_revisions flag)
- Re-prioritized the whole beads queue from CI-grounded status report; set .beads/config.yaml to no-db: true (JSONL is source of truth, no Dolt push); fixed titi's global.json SDK pin locally (ad541c4, still unpushed on titi main)
- Per-ticket pipeline established: TDD → ro5u (Rule-of-5 review skill) → fix → commit → PR; ro5u caught a dropped assertion on vk20
- **Next:** claim testaruda-lspm (P1, NULL-UNIQUE store bloat — openspec fix-content-unit-uniqueness drafted, execute the spec). Then ljeg (P2 pre-edit exit code). ehse (P1) blocked on user-provided homebrew-charly credential.
### 2026-09-20 18:03 — snap
- Continued from renew: lspm confirmed duplicate of closed p37i (partial unique indexes already in store.rs, 267 tests verified); then fixed ljeg (pre-edit mode now exits with outcome-derived CI code, PR #16), 6k0z (added tests/genesis_compatibility.rs — 12-module genesis 0.7 API fixture, PR #17), ixp0 (suggestion path gated on ErrorKind::InvalidSubcommand, PR #18), p1uv (genesis suggestion suppressed when clap already prints its tip, PR #19). All merged to main, full suite 281 green
- Found + worked around bd 1.0.4 stale-export bug: auto-export writes stale JSONL (reverted closes, old timestamps) that can get auto-staged into commits; workaround recorded via bd remember — regenerate with `bd export -o`, verify records, commit JSONL-only changes separately
- P1/P2 bug backlog cleared; 6 tickets closed this session (lspm, 9lbm, hnt9, ljeg, 6k0z, ixp0, p1uv minus the 2 stale closes)
- **Next:** remaining ready: zvbw (dont epistemic gate wiring), kyz2 (Python adapters at scale), P3s jxd0/qdw9/vax/rty, P4s; ehse still blocked on homebrew-charly credential (user-provided)
### 2026-09-20 21:35 — snap
- Closed testaruda-zvbw (PR #20, squash 0761783): dont epistemic gate adopted per dont-bpuo ADR — `just check-claims` (runs `dont prime`), lefthook pre-commit hook, `just ci` includes it, CI installs dont-cli@0.2.2, gate documented in docs/contributing.md. Gate verified exit-1-on-doubted on a throwaway store
- Gotcha: `dont prime` requires the full project layout (seed/, vocab/, rules/, schemas/, sessions/, imports/) — a fresh git checkout hard-fails "project layout is corrupt" if any dir is missing. Fixed by tracking .gitkeep sentinels in all six dirs + .gitignore negations; other repos wiring this gate need the same treatment (dont itself uses prek pre-commit)
- Fresh-tree CI simulation: `git archive <sha> | tar -x` into /tmp + `just check-claims` catches layout/track issues before pushing (saved 2 CI cycles on the last fix)
- **Next:** ready backlog = kyz2 (Python adapters at scale), jxd0/qdw9/vax/rty (P3s), 5q1/cwu (P4s); ehse still blocked on homebrew-charly credential
### 2026-09-20 22:05 — snap
- Closed testaruda-kyz2 (PR #21, a533567): Python adapter at scale on django/fastapi/numpy/pytest with freshly-installed testaruda 0.4.0 (fgoc fix included). Pipeline 12/12 pass; discovery counts == real test-file counts (627/508/183/121); edges resolve on mixed commits (up to 36); synthetic source coverage dj 55% / pt 45% / np 20% / fa 10%; 0 unresolved anywhere — src-layout concern from the ticket resolved
- Import validation now 18 projects: Python P 97.3% / R 99.9% (recall-first holds). pytest precision outlier (80.8%) fully attributed: 135 FPs are imports inside docstrings/strings (pytester fixtures embed synthetic code)
- Two real bugs found + filed: testaruda-wpil (P2, adapter keeps trailing comments in lazy-import module names — `import ctypes  # noqa` → "ctypes  # noqa"; only real FNs found) and testaruda-rpqs (P3, validate-imports.py iterates dotted string char-by-char in relative-import base resolution on BOTH truth and adapter sides — 't' vs 'p' phantom mismatches)
- bd create gotcha: `--title` isn't a flag — pass title as positional arg, `-d`/`--description` for body
- **Next:** ready backlog = wpil (P2 adapter comment strip), jxd0/qdw9/vax/rty/5q1/cwu (P3/P4); ehse blocked on homebrew-charly credential. rpqs would sharpen future eval numbers (regenerate validation JSON after)
### 2026-09-20 22:40 — snap
- Closed testaruda-wpil (PR #22, 5d5bfd2): python adapter strips trailing comments from import lines (TDD, 2 failing tests first); mirror fix in validate-imports.py replica. Verified on the 4 eval repos: fn 0 everywhere (was the only real FNs), fastapi now P100/R100, django fp 10→6, numpy 6→4; remaining pytest FPs are docstring/string over-detection (untouched)
- Gotcha: two integration tests (tests/adapter_python.rs) asserted the old src-layout "no edges" limitation — testaruda-i802 (8d69a3b) fixed it but never updated them; they only run when testaruda-adapter-python is on PATH (skipped in CI), so staleness surfaces only locally. Updated to assert actual edges. Lesson: locally-installed adapter version masks/unmasks PATH-gated integration tests — after reinstalling, expect stale PATH-gated assertions
- Full suite green locally + CI (3m15s). Main at 270258d
- **Next:** rpqs (P3, validator relative-import fix → then regenerate multi-language-import-validation.json); P3s jxd0/qdw9/vax/rty; P4s 5q1/cwu; ehse blocked on homebrew-charly credential
### 2026-09-20 23:05 — snap
- Closed testaruda-rpqs (PR #23, f841a55): validate-imports.py relative-import base was a char-iterating string on both truth and replica sides; fixed to module_path.split('.')[:-1]. TDD via new scripts/test_validate_imports.py (7 tests, loaded via importlib since the filename has a dash). Regenerated validation: 18 projects, python P97.4/R100.0/F98.7, aggregate P97.6/R100.0 — ZERO false negatives suite-wide; remaining FPs all string/docstring over-detection (pytest 134)
- Gotcha: appending to docs/multi-language-import-validation.json duplicates rows — replace the existing repo rows before re-adding
- Python eval arc complete: kyz2 (scale-up) → wpil (comment strip) → rpqs (validator fix). Remaining known weakness: docstring/string import detection (precision-only, recall-safe)
- **Next:** P3s jxd0 (format_iso_ts), qdw9 (stale docs example), vax (u32 overflow), rty (git mining survey); P4s 5q1/cwu; ehse blocked on homebrew-charly credential
