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
