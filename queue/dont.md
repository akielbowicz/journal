# Queue: dont

Sessions captured with /next — processed by /close or /wrap-up.

---

## 2026-05-08 15:39 — dont

- Evaluated codebase completeness: ~60% done (63/105 issues closed); three in-progress specs (rule engine, spawn/harness, import system) each block large clusters
- Claimed and implemented `dont-8os` — `.dont/` directory layout validation in `Project::open()` with `LayoutInvalid` error variant, exit code 3, and `dont init` remediation hint
- Ran Rule of 5 review; found `REQUIRED_SUBDIRS` divergence (HIGH), misleading error message (LOW), and inconsistent test teardown (LOW) — all three fixed
- Committed `feat(layout): validate .dont/ subdirectory layout on project open`
- **Next:** push the commit, then pick up next unblocked issue — shell completions (`dont-8h2`) or config.toml sections (`dont-2tl`, `dont-h8c`, `dont-gl0`) are all ready

---

## 2026-05-08 15:57 — dont

- Validated and closed `dont-3so` (improve-cli-ergonomics milestone): all 26 openspec checks passed, Locked state reachable via full CLI path
- Implemented `dont-2tl`: new `src/config.rs` with `Config`/`ImportConfig`/`VerifyEvidenceConfig`/`DefineShapeConfig` structs; wired into `dont import` (adapter-disabled gate), `verify-evidence` (default timeout), and `validate_label` (shape toggles)
- Added `tests/config.rs` covering all three config surfaces; full test suite green, clippy clean
- Committed and pushed `feat(config): parse [import] [verify_evidence] [define.shape] config blocks`
- **Next:** pick up `dont-h8c` (`[trust.hedges]` and `[rules]` severity blocks) or `dont-gl0` (`[project]` `[output]` `[storage]` blocks) — config infrastructure is now in place

---
